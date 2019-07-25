
module project(CLOCK_50,
		KEY, SW, LEDR, VGA_R, VGA_G, VGA_B, VGA_BLANK_N,VGA_CLK,VGA_HS,VGA_SYNC_N,VGA_VS);
		
		input CLOCK_50;
		input	[1:0] SW;
		input [3:0] KEY;
		input [2:0] LEDR;
		wire reset;
		assign reset = SW[1];
		
		
		/* Piece Definitions */
		// {COLOR, PIECE, STATE}
		localparam PIECE_NONE = 3'b000;
		localparam PIECE_PAWN = 3'b001;
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
		
		reg [4:0] board[31:0];
		wire [159:0] passable_board;
		
		genvar i;
		generate for (i=0; i<31; i=i+1) begin: BOARD
			assign  passable_board[i*5+4 : i*5] = board[i];
		end
		endgenerate
		
		wire [4:0] board_change_addr;
		wire [4:0] board_change_piece;
		wire [4:0] cursor_addr;
		wire [4:0] selected_piece_addr;
		wire hilite_selected_square;
		wire [2:0] logic_state;
		wire board_change_en_wire;
		wire is_in_initial_state;
		
		logic logic_module(
			.CLK(CLK_50), 
			.RESET(Reset),
			.board_input(passable_board),

			.board_out_addr(board_change_addr),
			.board_out_piece(board_change_piece),
			.board_change_en_wire(board_change_en_wire),
			.cursor_addr(cursor_addr),
			.selected_addr(selected_piece_addr),
			.hilite_selected_square(hilite_selected_square),

			.keyU(KEY[3]), .keyL(KEY[2]), .keyC(SW[0]),
			.keyR(KEY[1]), .keyD(KEY[0]),
			.state(logic_state), .move_is_legal(LEDR[0]), .is_in_initial_state(is_in_initial_state)
			);
		
		draw draw_board(
			.clock50(CLOCK_50),
			.vga_blue(VGA_B),
			.vga_blank_nn(VGA_BLANK_N),
			.vga_clock(VGA_CLK),
			.vga_green(VGA_G),
			.vga_hss(VGA_HSS),
			.vga_red(VGA_R),
			.vga_sync_nn(VGA_SYN_N),
			.vga_vss(VGA_VS), 
			.BOARD(passable_board),
			.CURSOR(cursor_addr),
			.SELECTED(selected_piece_addr)
			.SELECT_EN(board_change_en_wire)
			);	
	
	
	
		always @(posedge CLK_50)
		begin 
			if (Reset != 1) begin 
				if (board_change_en_wire == 1)  
				begin
					board[board_change_addr] <= board_change_piece;
				end
			end
			if (is_in_initial_state)
			begin
				board[5'b11_000] <= { COLOR_RED ,PIECE_ROOK, STATE_COVERED};
				board[5'b11_001] <= { COLOR_RED, PIECE_KNIGHT, STATE_COVERED};
				board[5'b11_010] <= { COLOR_RED, PIECE_BISHOP, STATE_COVERED };
				board[5'b11_011] <= { COLOR_RED, PIECE_QUEEN, STATE_COVERED };
				board[5'b11_100] <= { COLOR_RED, PIECE_KING, STATE_COVERED };
				board[5'b11_101] <= { COLOR_RED, PIECE_BISHOP, STATE_COVERED };
				board[5'b11_110] <= { COLOR_RED, PIECE_KNIGHT, STATE_COVERED };
				board[5'b11_111] <= { COLOR_RED, PIECE_ROOK, STATE_COVERED };
				
				board[5'b10_000] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
				board[5'b10_001] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
				board[5'b10_010] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED};
				board[5'b10_011] <= { COLOR_RED, PIECE_CANNON, STATE_COVERED};
				board[5'b10_100] <= { COLOR_RED, PIECE_CANNON, STATE_COVERED};
				board[5'b10_101] <= { COLOR_RED, PIECE_QUEEN, STATE_COVERED };
				board[5'b10_110] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
				board[5'b10_111] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
				
				
				board[6'b01_000] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
				board[6'b01_001] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
				board[6'b01_010] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
				board[6'b01_011] <= { COLOR_BLACK, PIECE_CANNON, STATE_COVERED };
				board[6'b01_100] <= { COLOR_BLACK, PIECE_CANNON, STATE_COVERED };
				board[6'b01_101] <= { COLOR_BLACK, PIECE_QUEEN, STATE_COVERED };
				board[6'b01_110] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
				board[6'b01_111] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
				
				board[6'b00_000] <= { COLOR_BLACK, PIECE_ROOK, STATE_COVERED };
				board[6'b00_001] <= { COLOR_BLACK, PIECE_KNIGHT, STATE_COVERED };
				board[6'b00_010] <= { COLOR_BLACK, PIECE_BISHOP, STATE_COVERED };
				board[6'b00_011] <= { COLOR_BLACK, PIECE_QUEEN, STATE_COVERED };
				board[5'b00_100] <= { COLOR_BLACK, PIECE_KING, STATE_COVERED };
				board[5'b00_101] <= { COLOR_BLACK, PIECE_BISHOP, STATE_COVERED };
				board[5'b00_110] <= { COLOR_BLACK, PIECE_KNIGHT, STATE_COVERED };
				board[5'b00_111] <= { COLOR_BLACK, PIECE_ROOK, STATE_COVERED };
			end
		end

endmodule
