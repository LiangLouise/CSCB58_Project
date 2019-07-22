`timescale 1ns / 1ps


module game_logic( 
    CLK, RESET,
    board_input,
    board_out_addr,
    board_out_piece,
	board_change_en_wire,
    keyL, // All button inputs shall have been debounced & made a single clk pulse outside this module
    keyU,
    keyR,
    keyD,
    keyC, // go amd select
    cursor_addr,
    selected_addr,
    hilite_selected_square,
	state, move_is_legal, is_in_initial_state
    );

/* Inputs */
input wire CLK, RESET;
input wire keyL, keyU, keyR, keyD, keyC;

input wire [159:0] board_input; // board info: state and chess_rep

wire [4:0] board[31:0];

genvar i;
generate for (i=0; i<31; i=i+1) begin: BOARD
	assign board[i] = board_input[i*5+4 : i*5];
end
endgenerate

/* Outputs */ 
// outputs for communicating with the board register in top
output reg[4:0] board_out_addr; // 2 bits for rows; 3 bits for columns
output reg[4:0] board_out_piece; // {color, type, state}
reg board_change_enable; // signal the board reg in top to write the new piece to the addr
output wire board_change_en_wire;
assign board_change_en_wire = board_change_enable;

// outputs for communicating with the module
output reg[4:0] cursor_addr;
output reg[4:0] selected_addr;
output wire hilite_selected_square;

output wire is_in_initial_state;
assign is_in_initial_state = (state == INITIAL);

// wires for the contents of the board input
wire[4:0] cursor_contents, selected_contents;
assign cursor_contents = board[cursor_addr]; // contents of the cursor square
assign selected_contents = board[selected_addr]; // contents of the selected square

/* Piece Definitions */
// {COLOR, PIECE, STATE}
localparam PIECE_NONE = 3'b000;
localparam PIECE_SOLDIER = 3'b001;
localparam PIECE_CANNON = 3'b010;
localparam PIECE_KNIGHT = 3'b011;
localparam PIECE_ROOK = 3'b100;
localparam PIECE_BISHOP  = 3'b101;
localparam PIECE_QUEEN  = 3'b110;
localparam PIECE_KING   = 3'b111;

localparam COLOR_RED  = 1'b0;
localparam COLOR_BLACK  = 1'b1;

localparam STATE_COVERED = 1'b0;
localparam STATE_UNCOVERED = 1'b1;

/* DPU registers */
reg player_to_move;

output reg move_is_legal; // signal will be generated in combinational logic

/* State Machine Definition */
// use encoded-assignment
localparam INITIAL = 3'b000,
            PIECE_SEL = 3'b001, 
            PIECE_MOVE= 3'b010,
            WRITE_NEW_PIECE = 3'b011, 
            ERASE_OLD_PIECE = 3'b100,
            FLIP_CHESS = 3'b101;
output reg[2:0] state;
assign hilite_selected_square = (state == PIECE_MOVE);

/* State Machine NSL and OFL */
always @ (posedge CLK, posedge RESET) begin
    if (RESET) begin
        // initialization code here
        state <= INITIAL;
        player_to_move <= COLOR_RED;
        
        cursor_addr <= 5'b00_000; // select (0,0) as the cursor start postion 
        selected_addr <= 5'bXXXXX;

        board_out_addr <= 5'b00_000;
        board_out_piece <= 5'b0_000_0;
        board_change_enable <= 0;
	
    end
    else begin
        // State machine code from herPIECE_NONEe
        case (state)
            INITIAL :
            begin
                // State Transitions
                state <= PIECE_SEL; // unconditional

                // RTL operations
            end
				
				
		    FLIP_CHESS:
            begin
                board_change_enable <= 1;
                board_out_addr <= selected_addr;
                board_out_piece <= {selected_contents[4:1], STATE_UNCOVERED};
                state <= ERASE_OLD_PIECE;
            end
				

            PIECE_SEL:
            begin
                // State Transitions
                if (keyC 
                    && cursor_contents[4] == player_to_move
                    && cursor_contents[3:1] != PIECE_NONE) 
						begin
                            // flip the chess
                            if (cursor_contents[0:0] == STATE_COVERED)
                                begin
                                state <= FLIP_CHESS;
										  end

                            else begin
                                state <= PIECE_MOVE;
                            end
						selected_addr <= cursor_addr;
						end
                // else we remain in this state
                
            end

            PIECE_MOVE:
            begin
                // RTL operations
                if (keyC) begin
                    if (    (cursor_contents[4] != player_to_move
                            || cursor_contents[3:1] == PIECE_NONE)
                            && move_is_legal)
                    begin
                        // big eats small rational
                        // they clicked either an empty space or the other color piece & legally
                        if (cursor_contents[3:1] <= selected_contents[3:1] 
                            && cursor_contents[4] != selected_contents[4] 
                            && cursor_contents[0] == STATE_UNCOVERED
                            || cursor_contents[3:1] == PIECE_NONE) 
                            begin
                            state <= WRITE_NEW_PIECE; 
                            board_out_addr <= cursor_addr;
                            board_out_piece <= selected_contents;
                            board_change_enable <= 1;
                            end 
                        else begin
                            state <= PIECE_SEL;
                        end

                    end
                    // else if (cursor_contents[3] == player_to_move
                    //     && cursor_contents[2:0] != PIECE_NONE)
                    // begin
                    //     // they clicked their own piece
                    //     selected_addr <= cursor_addr;
                    // end
					// 	  else begin
					// 			state <= PIECE_SEL;
					// 	  end
                end
            end

            

            WRITE_NEW_PIECE:
            begin
                // State Transitions
                state <= ERASE_OLD_PIECE;

                // RTL operations
                // going to ERASE_OLD_PIECE
                board_change_enable <= 1; // already done but it doesn't hurt here
                board_out_addr <= selected_addr;
                board_out_piece <= 4'b0000; // no piece
            end

            ERASE_OLD_PIECE:
            begin
                // State Transitions
                state <= PIECE_SEL;

                // RTL operations
                board_change_enable <= 0;
                board_out_addr <= 6'bXXXXXX;
                board_out_piece <= 4'bXXXX;

                player_to_move <= ~player_to_move;
            end

			endcase
	 
		 /* Cursor Movement Controls */
		 if      (keyL && cursor_addr[2:0] != 3'b000) 
			cursor_addr <= cursor_addr - 5'b00_001; // Left move, not allowed when x == 0
		 else if (keyR && cursor_addr[2:0] != 3'b111)
			cursor_addr <= cursor_addr + 5'b00_001; // Right Move, not allowed when x == 7 
		 else if (keyU && cursor_addr[4:3] != 2'b00) 
			cursor_addr <= cursor_addr - 5'b01_000; // Up Move, not allowed when y == 0 
		 else if (keyD && cursor_addr[4:3] != 2'b11)
			cursor_addr <= cursor_addr + 5'b01_000; // Down Move, not allowed when y == 3
	end
end


	
/* Combinational logic to 1;determine if the selected piece can move as desired */
// really only valid when 1;in PIECE_MOVE state
// selected_contents is th1;e piece we're trying to move
// selected_addr is the old location
// cursor_addr is the destination square

// cursor addr and selected addr are 6 bit numbers. 5:3 reps the row, 2:0 reps the col

// always @(*) begin
// 	if (cursor_addr[2:0] >= selected_addr[2:0]) h_delta = cursor_addr[2:0] - selected_addr[2:0];
// 	else													  h_delta = selected_addr[2:0] - cursor_addr[2:0];
	
// 	if (cursor_addr[5:3] >= selected_addr[5:3]) v_delta = cursor_addr[5:3] - selected_addr[5:3];
// 	else													  v_delta = selected_addr[5:3] - cursor_addr[5:3];
// end

// Logic to generate the move_is_legal signal
always @(*) begin

    if(selected_contents[0] == STATE_UNCOVERED)
        begin
            if (player_to_move == COLOR_RED) begin 
                // if it moves downward 1 unit, it is allowed
                if ((cursor_addr[4:3] > selected_addr[4:3])
						 && ((cursor_addr[4:3] - selected_addr[4:3]) == 1)
						 && ((cursor_addr[2:0] - selected_addr[2:0]) == 0))
                   move_is_legal = 1;

                // if it moves upward 1 unit, it is allowed
                else if (cursor_addr[4:3] <= selected_addr[4:3] && 
                        cursor_addr[4:3] - selected_addr[4:3] == 1 && 
                        cursor_addr[2:0] - selected_addr[2:0] == 0)
                        move_is_legal = 1;
                
                // if it moves left 1 unit, it is allowed
                else if (cursor_addr[2:0] > selected_addr[2:0] && 
                        cursor_addr[2:0] - selected_addr[2:0] == 1 && 
                        cursor_addr[4:3] - selected_addr[4:3] == 0)
                        move_is_legal = 1;

                
                // if it moves right 1 unit, it is allowed
                else if (cursor_addr[2:0] <= selected_addr[2:0] && 
                        cursor_addr[2:0] - selected_addr[2:0] == 1 &&
                        cursor_addr[4:3] - selected_addr[4:3] == 0)
                        move_is_legal = 1;
                else move_is_legal = 0;
            end

            else if (player_to_move == COLOR_BLACK) begin
                if (cursor_addr[4:3] > selected_addr[4:3] && 
                    cursor_addr[4:3] - selected_addr[4:3] ==1 && 
                    cursor_addr[2:0] - selected_addr[2:0] == 0)
                    
                        move_is_legal = 1;
                    

                else if (cursor_addr[4:3] <= selected_addr[4:3] && 
                        cursor_addr[4:3] - selected_addr[4:3] == 1 && 
                        cursor_addr[2:0] - selected_addr[2:0] == 0)
                    
                        move_is_legal = 1;
                    
                
                else if (cursor_addr[2:0] > selected_addr[2:0] && 
                        cursor_addr[2:0] - selected_addr[2:0] == 1 && 
                        cursor_addr[4:3] - selected_addr[4:3] == 0)
                        move_is_legal = 1;
                    

                else if (cursor_addr[2:0] <= selected_addr[2:0] && 
                        cursor_addr[2:0] - selected_addr[2:0] == 1 &&
                        cursor_addr[4:3] - selected_addr[4:3] == 0)
                        move_is_legal = 1;

                else move_is_legal = 0;
            end
		end
 end
endmodule


