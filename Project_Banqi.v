
module project(CLOCK_50,
		KEY, SW, LEDR, VGA_R, VGA_G, VGA_B, VGA_BLANK_N,VGA_CLK,VGA_HS,VGA_SYNC_N,VGA_VS);
		
		input CLOCK_50;
		input	[1:0] SW;
		input [3:0] KEY;
		output [4:0] LEDR;
		wire reset;
		assign reset = SW[1];
		
		output [7:0]VGA_R;
		output [7:0]VGA_G;
		output [7:0]VGA_B;

		
		
		output VGA_CLK;
		output VGA_HS;
		output VGA_BLANK_N;
		output VGA_SYNC_N;
		output VGA_VS;
		
		
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
		
		//assign LEDR = board[0];
		
//		genvar i;
//		generate for (i=0; i<31; i=i+1) begin: BOARD
//			assign  passable_board[i*5+4 : i*5] = board[i];
//		end
//		endgenerate

assign  passable_board[4 : 0] = { 1'b0 ,1'b001, 1'b1};
		
		
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
			.XPixelPosition(XPixelPosition),
			.YPixelPosition(YPixelPosition),
			.pixelClock(pixelClock),
			.redValue(redValue),
			.greenValue(greenValue),
			.blueValue(blueValue),
			.BOARD(passable_board),
			.CURSOR(cursor_addr),
			.SELECTED(selected_piece_addr),
			.SELECT_EN(board_change_en_wire)
			);	
	wire [10:0] XPixelPosition;
wire [10:0] YPixelPosition; 

wire	[7:0] redValue;
wire	[7:0] greenValue;
wire	[7:0] blueValue;

reg	aresetPll = 0;
wire pixelClock;

assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b1;			
assign VGA_CLK = pixelClock;

	VGAFrequency VGAFreq (aresetPll, CLOCK_50, pixelClock);

	VGAController VGAControl (pixelClock, redValue, greenValue, blueValue, VGA_R, VGA_G, VGA_B, VGA_VS, VGA_HS, XPixelPosition, YPixelPosition);
	
		always @(posedge CLK_50)
		begin 
			if (Reset != 1) begin 
				if (board_change_en_wire == 1)  
				begin
					board[board_change_addr] <= board_change_piece;
				end
			end
			if (is_in_initial_state )
			begin
				board[24] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[25] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[26] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[27] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[28] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[29] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[30] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[31] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				
				board[16] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[17] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[18] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[19] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[20] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[21] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[22] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[23] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				
				
				board[8] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[9] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[10] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[11] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[12] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[13] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[14] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[15] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				
				board[0] <= { 1'b0 ,1'b001, 1'b1};
				board[1] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[2] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[3] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[4] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[5] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[6] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
				board[7] <= { COLOR_RED ,PIECE_PAWN, STATE_UNCOVERED};
			
				//////
//				board[5'b11_000] <= { COLOR_RED ,PIECE_ROOK, STATE_COVERED};
//				board[5'b11_001] <= { COLOR_RED, PIECE_KNIGHT, STATE_COVERED};
//				board[5'b11_010] <= { COLOR_RED, PIECE_BISHOP, STATE_COVERED };
//				board[5'b11_011] <= { COLOR_RED, PIECE_QUEEN, STATE_COVERED };
//				board[5'b11_100] <= { COLOR_RED, PIECE_KING, STATE_COVERED };
//				board[5'b11_101] <= { COLOR_RED, PIECE_BISHOP, STATE_COVERED };
//				board[5'b11_110] <= { COLOR_RED, PIECE_KNIGHT, STATE_COVERED };
//				board[5'b11_111] <= { COLOR_RED, PIECE_ROOK, STATE_COVERED };
//				
//				board[5'b10_000] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
//				board[5'b10_001] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
//				board[5'b10_010] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED};
//				board[5'b10_011] <= { COLOR_RED, PIECE_CANNON, STATE_COVERED};
//				board[5'b10_100] <= { COLOR_RED, PIECE_CANNON, STATE_COVERED};
//				board[5'b10_101] <= { COLOR_RED, PIECE_QUEEN, STATE_COVERED };
//				board[5'b10_110] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
//				board[5'b10_111] <= { COLOR_RED, PIECE_PAWN, STATE_COVERED };
//				
//				
//				board[5'b01_000] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
//				board[5'b01_001] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
//				board[5'b01_010] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
//				board[5'b01_011] <= { COLOR_BLACK, PIECE_CANNON, STATE_COVERED };
//				board[5'b01_100] <= { COLOR_BLACK, PIECE_CANNON, STATE_COVERED };
//				board[5'b01_101] <= { COLOR_BLACK, PIECE_QUEEN, STATE_COVERED };
//				board[5'b01_110] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
//				board[5'b01_111] <= { COLOR_BLACK, PIECE_PAWN, STATE_COVERED };
//				
//				board[5'b00_000] <= { COLOR_BLACK, PIECE_ROOK, STATE_COVERED };
//				board[5'b00_001] <= { COLOR_BLACK, PIECE_KNIGHT, STATE_COVERED };
//				board[5'b00_010] <= { COLOR_BLACK, PIECE_BISHOP, STATE_COVERED };
//				board[5'b00_011] <= { COLOR_BLACK, PIECE_QUEEN, STATE_COVERED };
//				board[5'b00_100] <= { COLOR_BLACK, PIECE_KING, STATE_COVERED };
//				board[5'b00_101] <= { COLOR_BLACK, PIECE_BISHOP, STATE_COVERED };
//				board[5'b00_110] <= { COLOR_BLACK, PIECE_KNIGHT, STATE_COVERED };
//				board[5'b00_111] <= { COLOR_BLACK, PIECE_ROOK, STATE_COVERED };
			end
		end

endmodule

//1280 1024

module draw(
	XPixelPosition,
	YPixelPosition,
	pixelClock,
	redValue,
	greenValue,
	blueValue,
	BOARD,
	CURSOR,
	SELECTED,
	SELECT_EN
);

input [159:0] BOARD;
input [4:0] CURSOR;
input [4:0] SELECTED; 
input SELECT_EN;
input pixelClock;

//input clock50;
//output [7:0] vga_blue;
//output vga_blank_nn;
//output vga_clock;
//output [7:0] vga_green;
//output	vga_hss;
//output [7:0] vga_red;
//output vga_sync_nn;
//output vga_vss;
//reg	aresetPll = 0;
//wire pixelClock;
input [10:0] XPixelPosition;
input [10:0] YPixelPosition; 
output reg	[7:0] redValue;
output reg	[7:0] greenValue;
output reg	[7:0] blueValue;
//
//assign vga_blank_nn = 1'b1;
//assign vga_sync_nn = 1'b1;			
//assign vga_clock = pixelClock;
//
//VGAFrequency VGAFreq (aresetPll, clock50, pixelClock);
//
//VGAController VGAControl (pixelClock, redValue, greenValue, blueValue, vga_red, vga_green, vga_blue, vga_vss, vga_hss, XPixelPosition, YPixelPosition);


localparam PIECE_NONE = 3'b000;
localparam PIECE_SOLDIER = 3'b001;
localparam PIECE_CANNON = 3'b010;
localparam PIECE_KNIGHT = 3'b011;
localparam PIECE_ROOK = 3'b100;
localparam PIECE_BISHOP  = 3'b101;
localparam PIECE_QUEEN  = 3'b110;
localparam PIECE_KING   = 3'b111;

localparam COLOR_RED  = 1'b0;
localparam COLOR_BLUE  = 1'b1;

localparam STATE_COVERED = 1'b0;
localparam STATE_UNCOVERED = 1'b1;


//VGA pattern and charactor display
always @(posedge pixelClock)
begin
	
	//each position 5 bits
	//bit1 -> colour
	//bit2-4 -> piece
	//bit5 -> state
	
	
		//horizontal lines
	if(XPixelPosition > 0 && XPixelPosition < 1146 &&  YPixelPosition > 0 && YPixelPosition < 10) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 1146 &&  YPixelPosition > 256 && YPixelPosition < 266) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 1146 &&  YPixelPosition > 512 && YPixelPosition < 522) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 1146 &&  YPixelPosition > 768 && YPixelPosition < 778) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 1146	 &&  YPixelPosition > 1014 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	///////////////////////////vertical lines
	else if(XPixelPosition > 0 && XPixelPosition < 10 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 142 && XPixelPosition < 152 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 284 && XPixelPosition < 294 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 426 && XPixelPosition < 436 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 568 && XPixelPosition < 578 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 710 && XPixelPosition < 720 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 852 && XPixelPosition < 862 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 994 && XPixelPosition < 1004 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 1136 && XPixelPosition < 1146 &&  YPixelPosition > 0 && YPixelPosition < 1024) begin
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	//row0
	else if(XPixelPosition > 30 && XPixelPosition < 122 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,0
		
		if(BOARD[4] == COLOR_RED) begin
			//set colour red
			redValue <= 8'b11111111;
			blueValue <= 8'b00000000;
			greenValue <= 8'b00000000;
		end
		else begin
			//set colour blue
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b00000000;
		end
		
		if(BOARD[0] == STATE_COVERED)begin
			//draw WHITE
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
		end
		else if(BOARD[3:1] == PIECE_NONE)begin
			//draw black
			redValue <= 8'b00000000;
			blueValue <= 8'b00000000;
			greenValue <= 8'b00000000;
		end
		else if(BOARD[3:1] == PIECE_SOLDIER)begin
		
				if (XPixelPosition > 71-40 && XPixelPosition < 71-30 && YPixelPosition > 128-75 && YPixelPosition < 128+70)begin
					redValue <= 8'b00000000;
					blueValue <= 8'b11111111;
					greenValue <= 8'b11111111;
				end
				else if(XPixelPosition > 71-30 && XPixelPosition < 71+50 && YPixelPosition > 128-75 && YPixelPosition < 128-65)begin
					redValue <= 8'b00000000;
					blueValue <= 8'b11111111;
					greenValue <= 8'b11111111;
				end
				else if(XPixelPosition > 71-30 && XPixelPosition < 71+50 && YPixelPosition > 128 && YPixelPosition < 128+10)begin
						redValue <= 8'b00000000;
						blueValue <= 8'b11111111;
						greenValue <= 8'b11111111;
				end
				
				else if(XPixelPosition > 71+40 && XPixelPosition < 71+50 && YPixelPosition > 128-65 && YPixelPosition < 128+10)begin
						redValue <= 8'b00000000;
						blueValue <= 8'b11111111;
						greenValue <= 8'b11111111;
				end
				else begin 
						redValue <= 8'b00000000;
						blueValue <= 8'b00000000;
						greenValue <= 8'b00000000;
				end
				
				
		end
		else if(BOARD[3:1] == PIECE_CANNON)begin
		
		end
		else if(BOARD[3:1] == PIECE_KNIGHT)begin
		
		end
		else if(BOARD[3:1] == PIECE_ROOK)begin
		
		end
		else if(BOARD[3:1] == PIECE_BISHOP) begin
		
		end
		else if(BOARD[3:1] == PIECE_QUEEN) begin
		
		end
		else if(BOARD[3:1] == PIECE_KING) begin
		
		end
		
			
	end
	else if(XPixelPosition > 172 && XPixelPosition < 264 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,1
		
		if(BOARD[5] == COLOR_RED) begin
			//set colour red
			redValue <= 8'b11111111;
			blueValue <= 8'b00000000;
			greenValue <= 8'b00000000;
		end
		else begin
			//set colour blue
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b00000000;
		end
		
		if(BOARD[9] == STATE_COVERED)begin
		//draw WHITE
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
		end
		else if(BOARD[8:6] == PIECE_NONE)begin
			//draw black
			redValue <= 8'b11111111;
			blueValue <= 8'b00000000;
			greenValue <= 8'b00000000;
		end
		else if(BOARD[8:6] == PIECE_SOLDIER)begin
		
		end
		else if(BOARD[8:6] == PIECE_CANNON)begin
		
		end
		else if(BOARD[8:6] == PIECE_KNIGHT)begin
		
		end
		else if(BOARD[8:6] == PIECE_ROOK)begin
		
		end
		else if(BOARD[8:6] == PIECE_BISHOP) begin
		
		end
		else if(BOARD[8:6] == PIECE_QUEEN) begin
		
		end
		else if(BOARD[8:6] == PIECE_KING) begin
		
		end
		
	end
	else if(XPixelPosition > 314 && XPixelPosition < 406 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,2
		
		if(BOARD[10] == COLOR_RED) begin
			//set colour red
		end
		else begin
			//set colour blue
		end
		
		if(BOARD[14] == STATE_COVERED)begin
			//draw WHITE
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
		end
		else if(BOARD[13:11] == PIECE_NONE)begin
			//draw black
		end
		else if(BOARD[13:11] == PIECE_SOLDIER)begin
		
		end
		else if(BOARD[13:11] == PIECE_CANNON)begin
		
		end
		else if(BOARD[13:11] == PIECE_KNIGHT)begin
		
		end
		else if(BOARD[13:11] == PIECE_ROOK)begin
		
		end
		else if(BOARD[13:11] == PIECE_BISHOP) begin
		
		end
		else if(BOARD[13:11] == PIECE_QUEEN) begin
		
		end
		else if(BOARD[13:11] == PIECE_KING) begin
		
		end
		
	end
	else if(XPixelPosition > 456 && XPixelPosition < 548 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,3
		if(BOARD[15] == COLOR_RED) begin
			//set colour red
		end
		else begin
			//set colour blue
		end
		
		if(BOARD[19] == STATE_COVERED)begin
			//draw WHITE
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
		end
		else if(BOARD[18:16] == PIECE_NONE)begin
			//draw black
		end
		else if(BOARD[18:16] == PIECE_SOLDIER)begin
		
		end
		else if(BOARD[18:16] == PIECE_CANNON)begin
		
		end
		else if(BOARD[18:16] == PIECE_KNIGHT)begin
		
		end
		else if(BOARD[18:16] == PIECE_ROOK)begin
		
		end
		else if(BOARD[18:16] == PIECE_BISHOP) begin
		
		end
		else if(BOARD[18:16] == PIECE_QUEEN) begin
		
		end
		else if(BOARD[18:16] == PIECE_KING) begin
		
		end
	end
	else if(XPixelPosition > 598 && XPixelPosition < 690 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,4
		if(BOARD[20] == COLOR_RED) begin
			//set colour red
		end
		else begin
			//set colour blue
		end
		
		if(BOARD[24] == STATE_COVERED)begin
			//draw WHITE
			redValue <= 8'b11111111;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
		end
		else if(BOARD[23:21] == PIECE_NONE)begin
			//draw black
		end
		else if(BOARD[23:21] == PIECE_SOLDIER)begin
		
		end
		else if(BOARD[23:21] == PIECE_CANNON)begin
		
		end
		else if(BOARD[23:21] == PIECE_KNIGHT)begin
		
		end
		else if(BOARD[23:21] == PIECE_ROOK)begin
		
		end
		else if(BOARD[23:21] == PIECE_BISHOP) begin
		
		end
		else if(BOARD[23:21] == PIECE_QUEEN) begin
		
		end
		else if(BOARD[23:21] == PIECE_KING) begin
		
		end
	end
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
//	else if(XPixelPosition > 740 && XPixelPosition < 832 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,5
//		if(BOARD[25] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[29] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[28:26] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[26:28] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[26:28] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 882 && XPixelPosition < 974 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,6
//		if(BOARD[30] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[34] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[31:33] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[31:33] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[31:33] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 1024 && XPixelPosition < 1116 &&  YPixelPosition > 30 && YPixelPosition < 236) begin //0,7
//		if(BOARD[35] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[39] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[36:38] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[36:38] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[36:38] == PIECE_KING) begin
//		
//		end
//	end
//	
//	//row1
//	else if(XPixelPosition > 30 && XPixelPosition < 122 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,0
//		if(BOARD[40] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[44] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[41:43] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[41:43] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[41:43] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 172 && XPixelPosition < 264 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,1
//		if(BOARD[45] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[49] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[46:48] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[46:48] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[46:48] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 314 && XPixelPosition < 406 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,2
//		if(BOARD[50] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[54] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[51:53] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[51:53] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[51:53] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 456 && XPixelPosition < 548 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,3
//		if(BOARD[55] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[59] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[56:58] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[56:58] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[56:58] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 598 && XPixelPosition < 690 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,4
//		if(BOARD[60] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[64] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[61:63] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[61:63] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[61:63] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 740 && XPixelPosition < 832 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,5
//		if(BOARD[65] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[69] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[66:68] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[66:68] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[66:68] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 882 && XPixelPosition < 974 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,6
//		if(BOARD[70] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[74] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[71:73] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[71:73] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[71:73] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 1024 && XPixelPosition < 1116 &&  YPixelPosition > 286 && YPixelPosition < 492) begin //1,7
//		if(BOARD[75] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[79] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[76:78] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[76:78] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[76:78] == PIECE_KING) begin
//		
//		end
//	end
//	
//	//row2
//	else if(XPixelPosition > 30 && XPixelPosition < 122 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,0
//		if(BOARD[80] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[84] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[81:83] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[81:83] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[81:83] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 172 && XPixelPosition < 264 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,1
//		if(BOARD[85] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[89] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[86:88] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[86:88] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[86:88] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 314 && XPixelPosition < 406 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,2
//		if(BOARD[90] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[94] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[91:93] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[91:93] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[91:93] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 456 && XPixelPosition < 548 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,3
//		if(BOARD[95] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[99] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[96:98] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[96:98] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[96:98] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 598 && XPixelPosition < 690 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,4
//		if(BOARD[100] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[104] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[101:103] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[101:103] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[101:103] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 740 && XPixelPosition < 832 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,5
//		if(BOARD[105] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[109] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[106:108] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[106:108] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[106:108] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 882 && XPixelPosition < 974 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,6
//		if(BOARD[110] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[114] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[111:113] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[111:113] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[111:113] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 1024 && XPixelPosition < 1116 &&  YPixelPosition > 542 && YPixelPosition < 748) begin //2,7
//		if(BOARD[115] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[119] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[116:118] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[116:118] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[116:118] == PIECE_KING) begin
//		
//		end
//	end
//	
//	//row3
//	else if(XPixelPosition > 30 && XPixelPosition < 122 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,0
//		if(BOARD[120] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[124] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[121:123] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[121:123] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[121:123] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 172 && XPixelPosition < 264 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,1
//		if(BOARD[125] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[129] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[126:128] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[126:128] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[126:128] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 314 && XPixelPosition < 406 && YPixelPosition > 798 && YPixelPosition < 994) begin //3,2
//		if(BOARD[130] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[134] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[131:133] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[131:133] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[131:133] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 456 && XPixelPosition < 548 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,3
//		if(BOARD[135] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[139] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[136:138] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[136:138] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[136:138] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 598 && XPixelPosition < 690 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,4
//		if(BOARD[140] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[144] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[141:143] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[141:143] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[141:143] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 740 && XPixelPosition < 832 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,5
//		if(BOARD[145] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[149] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[146:148] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[146:148] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[146:148] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 882 && XPixelPosition < 974 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,6
//		if(BOARD[150] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[154] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[151:153] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[151:153] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[151:153] == PIECE_KING) begin
//		
//		end
//	end
//	else if(XPixelPosition > 1024 && XPixelPosition < 1116 &&  YPixelPosition > 798 && YPixelPosition < 994) begin //3,7
//		if(BOARD[155] == COLOR_RED) begin
//			//set colour red
//		end
//		else begin
//			//set colour blue
//		end
//		
//		if(BOARD[159] == STATE_COVERED)begin
//			//draw WHITE
//			redValue <= 8'b11111111;
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b11111111;
//		end
//		else if(BOARD[156:158] == PIECE_NONE)begin
//			//draw black
//		end
//		else if(BOARD[156:158] == PIECE_SOLDIER)begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_CANNON)begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_KNIGHT)begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_ROOK)begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_BISHOP) begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_QUEEN) begin
//		
//		end
//		else if(BOARD[156:158] == PIECE_KING) begin
//		
//		end
//	end
	
	else begin
			redValue <= 8'b00000000;
			blueValue <= 8'b00000000;
			greenValue <= 8'b00000000;
	end
	
	
	
	

end

endmodule

// The VGAController is the source code
// This is a controller written for a VGA Monitor with resolution 1280 by 1024 with an refresh rate of 60 fps
// VGA Controller use to generate signals for the monitor 
module VGAController (PixelClock,
							 inRed,
							 inGreen,
							 inBlue,
							 outRed,
							 outGreen,
							 outBlue,
							 VertSynchOut,
							 HorSynchOut,
							 XPosition,
							 YPosition);
//======================================================= 
// Parameter Declarations 				
//=======================================================
// Parameters are set for a 1280 by 1024 pixel monitor running at 60 frames per second
// X Screen Constants	 
parameter XLimit = 1688;
parameter XVisible = 1280;
parameter XSynchPulse = 112;
parameter XBackPorch = 248;
// Y Screen Constants
parameter YLimit = 1066;
parameter YVisible = 1024;
parameter YSynchPulse = 3;
parameter YBackPorch = 38;

//=======================================================			 
// Port Declarations 				
//=======================================================
input PixelClock;
input [7:0] inRed;
input [7:0] inGreen;
input [7:0] inBlue;
output [7:0] outRed;
output [7:0] outGreen;
output [7:0] outBlue;
output VertSynchOut;
output HorSynchOut;
output [10:0] XPosition;
output [10:0] YPosition;

//========================================================
// REG/WIRE declarations
//========================================================

reg [10:0] XTiming;
reg [10:0] YTiming;
reg HorSynch;
reg VertSynch;

//========================================================
// Structural coding
//========================================================
assign XPosition = XTiming - (XSynchPulse + XBackPorch);
assign YPosition = YTiming - (YSynchPulse + YBackPorch);


always@(posedge PixelClock)// Control X Timing
begin
	if (XTiming >= XLimit)
		XTiming <= 11'd0;
	else
		XTiming <= XTiming + 1;
end
	
always@(posedge PixelClock)// Control Y Timing
begin
	if (YTiming >= YLimit && XTiming >= XLimit)
		YTiming <= 11'd0;
	else if (XTiming >= XLimit && YTiming < YLimit)
		YTiming <= YTiming + 1;
	else
		YTiming <= YTiming;
end

always@(posedge PixelClock)// Control Vertical Synch Signal
begin
	if (YTiming >= 0 && YTiming < YSynchPulse)
		VertSynch <= 1'b0;
	else
		VertSynch <= 1'b1;
end
	
always@(posedge PixelClock)// Control Horizontal Synch Signal
begin
	if (XTiming >= 0 && XTiming < XSynchPulse)
		HorSynch <= 1'b0;
	else
		HorSynch <= 1'b1;
end
	
// Draw black in off screen areas of screen
assign outRed = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inRed : 8'b0;
assign outGreen = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inGreen : 8'b0;
assign outBlue = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inBlue : 8'b0;

assign VertSynchOut = VertSynch;
assign HorSynchOut = HorSynch;


// Initialization registers block
initial
begin
	XTiming = 11'b0;
	YTiming = 11'b0;
	HorSynch = 1'b1;
	VertSynch = 1'b1;
end
	
	
endmodule 

`timescale 1 ps / 1 ps
// The VGAFrequency is the source code
module VGAFrequency (
	areset,
	inclk0,
	c0);

	input	  areset;
	input	  inclk0;
	output	  c0;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  areset;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [0:0] sub_wire2 = 1'h0;
	wire [4:0] sub_wire3;
	wire  sub_wire0 = inclk0;
	wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
	wire [0:0] sub_wire4 = sub_wire3[0:0];
	wire  c0 = sub_wire4;

	altpll	altpll_component (
				.areset (areset),
				.inclk (sub_wire1),
				.clk (sub_wire3),
				.activeclock (),
				.clkbad (),
				.clkena ({6{1'b1}}),
				.clkloss (),
				.clkswitch (1'b0),
				.configupdate (1'b0),
				.enable0 (),
				.enable1 (),
				.extclk (),
				.extclkena ({4{1'b1}}),
				.fbin (1'b1),
				.fbmimicbidir (),
				.fbout (),
				.fref (),
				.icdrclk (),
				.locked (),
				.pfdena (1'b1),
				.phasecounterselect ({4{1'b1}}),
				.phasedone (),
				.phasestep (1'b1),
				.phaseupdown (1'b1),
				.pllena (1'b1),
				.scanaclr (1'b0),
				.scanclk (1'b0),
				.scanclkena (1'b1),
				.scandata (1'b0),
				.scandataout (),
				.scandone (),
				.scanread (1'b0),
				.scanwrite (1'b0),
				.sclkout0 (),
				.sclkout1 (),
				.vcooverrange (),
				.vcounderrange ());
	defparam
		altpll_component.bandwidth_type = "AUTO",
		altpll_component.clk0_divide_by = 25,
		altpll_component.clk0_duty_cycle = 50,
		altpll_component.clk0_multiply_by = 54,
		altpll_component.clk0_phase_shift = "0",
		altpll_component.compensate_clock = "CLK0",
		altpll_component.inclk0_input_frequency = 20000,
		altpll_component.intended_device_family = "Cyclone IV E",
		altpll_component.lpm_hint = "CBX_MODULE_PREFIX=VGAFrequency",
		altpll_component.lpm_type = "altpll",
		altpll_component.operation_mode = "NORMAL",
		altpll_component.pll_type = "AUTO",
		altpll_component.port_activeclock = "PORT_UNUSED",
		altpll_component.port_areset = "PORT_USED",
		altpll_component.port_clkbad0 = "PORT_UNUSED",
		altpll_component.port_clkbad1 = "PORT_UNUSED",
		altpll_component.port_clkloss = "PORT_UNUSED",
		altpll_component.port_clkswitch = "PORT_UNUSED",
		altpll_component.port_configupdate = "PORT_UNUSED",
		altpll_component.port_fbin = "PORT_UNUSED",
		altpll_component.port_inclk0 = "PORT_USED",
		altpll_component.port_inclk1 = "PORT_UNUSED",
		altpll_component.port_locked = "PORT_UNUSED",
		altpll_component.port_pfdena = "PORT_UNUSED",
		altpll_component.port_phasecounterselect = "PORT_UNUSED",
		altpll_component.port_phasedone = "PORT_UNUSED",
		altpll_component.port_phasestep = "PORT_UNUSED",
		altpll_component.port_phaseupdown = "PORT_UNUSED",
		altpll_component.port_pllena = "PORT_UNUSED",
		altpll_component.port_scanaclr = "PORT_UNUSED",
		altpll_component.port_scanclk = "PORT_UNUSED",
		altpll_component.port_scanclkena = "PORT_UNUSED",
		altpll_component.port_scandata = "PORT_UNUSED",
		altpll_component.port_scandataout = "PORT_UNUSED",
		altpll_component.port_scandone = "PORT_UNUSED",
		altpll_component.port_scanread = "PORT_UNUSED",
		altpll_component.port_scanwrite = "PORT_UNUSED",
		altpll_component.port_clk0 = "PORT_USED",
		altpll_component.port_clk1 = "PORT_UNUSED",
		altpll_component.port_clk2 = "PORT_UNUSED",
		altpll_component.port_clk3 = "PORT_UNUSED",
		altpll_component.port_clk4 = "PORT_UNUSED",
		altpll_component.port_clk5 = "PORT_UNUSED",
		altpll_component.port_clkena0 = "PORT_UNUSED",
		altpll_component.port_clkena1 = "PORT_UNUSED",
		altpll_component.port_clkena2 = "PORT_UNUSED",
		altpll_component.port_clkena3 = "PORT_UNUSED",
		altpll_component.port_clkena4 = "PORT_UNUSED",
		altpll_component.port_clkena5 = "PORT_UNUSED",
		altpll_component.port_extclk0 = "PORT_UNUSED",
		altpll_component.port_extclk1 = "PORT_UNUSED",
		altpll_component.port_extclk2 = "PORT_UNUSED",
		altpll_component.port_extclk3 = "PORT_UNUSED",
		altpll_component.width_clock = 5;
endmodule

