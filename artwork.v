//1280 1024


module project(
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,
	KEY,
	SW,
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS 
);
input CLOCK_50;
input CLOCK2_50;
input CLOCK3_50;
input [3:0] KEY;
input [17:0] SW;
output [7:0] VGA_B;
output VGA_BLANK_N;
output VGA_CLK;
output [7:0] VGA_G;
output	VGA_HS;
output [7:0] VGA_R;
output VGA_SYNC_N;
output VGA_VS;
reg	aresetPll = 0;
wire pixelClock;
wire [10:0] XPixelPosition;
wire [10:0] YPixelPosition; 
reg	[7:0] redValue;
reg	[7:0] greenValue;
reg	[7:0] blueValue;
reg	[2:0] movement = 0;
reg	[3:0] tool = 0;
reg [10:0] r = 10;
reg [10:0] speed = 1;
reg [10:0] P1_paddle_len = 125;
reg [10:0] P2_paddle_len = 125;
reg [10:0] P1_paddle_speed = 5;
reg [10:0] P2_paddle_speed = 5;
reg [20:0] slowClockCounter = 0;
wire slowClock;
reg [20:0] fastClockCounter = 0;
wire fastClock;
reg	[10:0] XDotPosition = 500;
reg	[10:0] YDotPosition = 500; 
reg	[10:0] P1x = 225;
reg	[10:0] P1y = 500;
reg	[10:0] P2x = 1030;
reg	[10:0] P2y = 500;
reg [3:0] P1Score = 0;
reg	[3:0] P2Score = 0;
reg flag =1;
reg	[2:0] printer = 0;
wire [9:0] randX;
wire [9:0] randY;
reg [9:0] itemX = 640;
reg [9:0] itemY = 512;
reg [27:0] clock;
wire [3:0] rtool;
wire [7:0] color1;
wire [7:0] color2;
wire [7:0] color3;
reg [7:0] col1;
reg [7:0] col2;
reg [7:0] col3;
reg [3:0] randomtool = 2;
reg [1:0] drawItem;

assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b1;			
assign VGA_CLK = pixelClock;

VGAFrequency VGAFreq (aresetPll, CLOCK_50, pixelClock);
/*
PixelClock,
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
*/

VGAController VGAControl (pixelClock, redValue, greenValue, blueValue, VGA_R, VGA_G, VGA_B, VGA_VS, VGA_HS, XPixelPosition, YPixelPosition);

//coordinates
/*


*/

//VGA pattern and charactor display
always @(posedge pixelClock)
begin
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
	
	
	//pawn piece artwork
	else if (XPixelPosition > 71-40 && XPixelPosition < 71-30 && YPixelPosition > 128-75 && YPixelPosition < 128+70)begin
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
	
	
	//horse piece artwork
	else if(XPixelPosition > 213-40 && XPixelPosition < 213+40 && YPixelPosition > 384-5 && YPixelPosition < 384+5)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213-40 && XPixelPosition < 213-30 && YPixelPosition > 384-75 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213+40 && XPixelPosition < 213+50 && YPixelPosition > 384-75 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	//cannon piece artwork
	else if (XPixelPosition > 71-40 && XPixelPosition < 71-30 && YPixelPosition > 384-75 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end

	else if(XPixelPosition > 71-30 && XPixelPosition < 71+45 && YPixelPosition > 384-75 && YPixelPosition < 384-65)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 71-30 && XPixelPosition < 71+45 && YPixelPosition > 384+60 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	//rook piece artwork
	else if (XPixelPosition > 213-40 && XPixelPosition < 213-30 && YPixelPosition > 128-75 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213-30 && XPixelPosition < 213+50 && YPixelPosition > 128-75 && YPixelPosition < 128-65)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213-30 && XPixelPosition < 213+50 && YPixelPosition > 128 && YPixelPosition < 128+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	else if(XPixelPosition > 213+40 && XPixelPosition < 213+50 && YPixelPosition > 128-65 && YPixelPosition < 128+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213-10 && XPixelPosition < 213 && YPixelPosition > 128+10 && YPixelPosition < 128+20)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213 && XPixelPosition < 213+10 && YPixelPosition > 128+20 && YPixelPosition < 128+30)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213+10 && XPixelPosition < 213+20 && YPixelPosition > 128+30 && YPixelPosition < 128+40)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213+20 && XPixelPosition < 213+30 && YPixelPosition > 128+40 && YPixelPosition < 128+50)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213+30 && XPixelPosition < 213+40 && YPixelPosition > 128+50 && YPixelPosition < 128+60)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 213+40 && XPixelPosition < 213+50 && YPixelPosition > 128+60 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	
	//bishop piece artwork
	else if (XPixelPosition > 355-40 && XPixelPosition < 355-30 && YPixelPosition > 128-75 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355-30 && XPixelPosition < 355+20 && YPixelPosition > 128-75 && YPixelPosition < 128-65)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355-30 && XPixelPosition < 355+50 && YPixelPosition > 128 && YPixelPosition < 128+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	else if(XPixelPosition > 355+20 && XPixelPosition < 355+30 && YPixelPosition > 128-75 && YPixelPosition < 128+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355-40 && XPixelPosition < 355+50 && YPixelPosition > 128+60 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355+40 && XPixelPosition < 355+50 && YPixelPosition > 128+10 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	//queen piece artwork
	else if (XPixelPosition > 355-40 && XPixelPosition < 355-30 && YPixelPosition > 384-75 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355-30 && XPixelPosition < 355+40 && YPixelPosition > 384-75 && YPixelPosition < 384-65)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355-30 && XPixelPosition < 355+40 && YPixelPosition > 384+60 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355+30 && XPixelPosition < 355+40 && YPixelPosition > 384-75 && YPixelPosition < 384+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	else if(XPixelPosition > 355+20 && XPixelPosition < 355+25 && YPixelPosition > 384+50 && YPixelPosition < 384+55)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355+25 && XPixelPosition < 355+30 && YPixelPosition > 384+55 && YPixelPosition < 384+60)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 355+40 && XPixelPosition < 355+45 && YPixelPosition > 384+70 && YPixelPosition < 384+75)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;		
	end
	else if(XPixelPosition > 355+45 && XPixelPosition < 355+50 && YPixelPosition > 384+75 && YPixelPosition < 384+80)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	
	
	//king piece artwork
	else if (XPixelPosition > 497-40 && XPixelPosition < 497-30 && YPixelPosition > 128-75 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end

	else if(XPixelPosition > 497-30 && XPixelPosition < 497-10 && YPixelPosition > 128 && YPixelPosition < 128+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	
	else if(XPixelPosition > 497-10 && XPixelPosition < 497 && YPixelPosition > 128-10 && YPixelPosition < 128)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497 && XPixelPosition < 497+10 && YPixelPosition > 128-20 && YPixelPosition < 128-10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+10 && XPixelPosition < 497+20 && YPixelPosition > 128-30 && YPixelPosition < 128-20)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+20 && XPixelPosition < 497+30 && YPixelPosition > 128-40 && YPixelPosition < 128-30)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+30 && XPixelPosition < 497+40 && YPixelPosition > 128-50 && YPixelPosition < 128-40)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+40 && XPixelPosition < 497+50 && YPixelPosition > 128-60 && YPixelPosition < 128-50)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	

	else if(XPixelPosition > 497-10 && XPixelPosition < 497 && YPixelPosition > 128+10 && YPixelPosition < 128+20)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497 && XPixelPosition < 497+10 && YPixelPosition > 128+20 && YPixelPosition < 128+30)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+10 && XPixelPosition < 497+20 && YPixelPosition > 128+30 && YPixelPosition < 128+40)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+20 && XPixelPosition < 497+30 && YPixelPosition > 128+40 && YPixelPosition < 128+50)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+30 && XPixelPosition < 497+40 && YPixelPosition > 128+50 && YPixelPosition < 128+60)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 497+40 && XPixelPosition < 497+50 && YPixelPosition > 128+60 && YPixelPosition < 128+70)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	
	//cursor
	else if(XPixelPosition > 0 && XPixelPosition < 0+142 && YPixelPosition > 0 && YPixelPosition < 0+10)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 0+10 && YPixelPosition > 0 && YPixelPosition < 0+256)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0 && XPixelPosition < 0+142 && YPixelPosition > 0+246 && YPixelPosition < 0+256)begin
			redValue <= 8'b00000000;
			blueValue <= 8'b11111111;
			greenValue <= 8'b11111111;
	end
	else if(XPixelPosition > 0+132 && XPixelPosition < 0+142 && YPixelPosition > 0 && YPixelPosition < 0+256)begin
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

endmodule


// The VGAController is the source code
// This is a controller written for a VGA Monitor with resolution 1280 by 1024 with an refresh rate of 60 fps
// VGA Controller use to generate signals for the monitor 

/*

*/
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

//The module find a random x and random y for the coordinate
module RandomPoint(VGA_clk,randX, randY);
	input VGA_clk;
	output reg [9:0] randX;
	output reg [9:0] randY;

	reg [9:0] x = 260;
	reg [9:0] y = 225;

	always @(posedge VGA_clk)
	begin
	if (x < 1020)
		x <= x+1'b1;
	else
		x <= 10'd260;
	end						
	
	always @(posedge VGA_clk)
	begin
	if (y < 795)
		y <= y+1'b1;
	else
		y <= 10'd225;
	end

	always @(x,y)
	begin
		randX <= x;
		randY <= y;
	end

endmodule

//The module find a random number from 1-10 for rtool and
//random RPG for the tool point.
module RandomTool(VGA_clk, rtool, color1, color2, color3);
	input VGA_clk;
	output reg [3:0] rtool;
	output reg [7:0] color1;
	output reg [7:0] color2;
	output reg [7:0] color3;
	reg [3:0]outp = 1;
	reg [7:0] colorp1 = 1;
	reg [7:0] colorp2 = 1;
	reg [7:0] colorp3 = 1;
	always @(posedge VGA_clk)
	begin
		if (outp < 11)
			outp <= outp + 1;
		else
			outp <= 1;
	end
	always @(posedge VGA_clk)
	begin
		if (colorp1 < 8'b11111111)
			colorp1 <= colorp1 + 1;
		else
			colorp1 <= 1;
	end
	always @(posedge VGA_clk)
	begin
		if (colorp2 < 8'b11111111)
			colorp2 <= colorp2 + 2;
		else
			colorp2 <= 1;
	end
	always @(posedge VGA_clk)
	begin
		if (colorp3 < 8'b11111111)
			colorp3 <= colorp3 + 4;
		else
			colorp3 <= 1;
	end
	always @(outp)
	begin
		rtool <= outp;
	end
	always @(colorp1)
	begin
		color1 <= colorp1;
	end
	always @(colorp2)
	begin
		color2 <= colorp2;
	end
	always @(colorp3)
	begin
		color3 <= colorp3;
	end
endmodule	



//// Part 2 skeleton
////1280 1024
//module project2
//	(
//		CLOCK_50,						//	On Board 50 MHz
//		// Your inputs and outputs here
//        KEY,
//        SW,
//		// The ports below are for the VGA output.  Do not change.
//		VGA_CLK,   						//	VGA Clock
//		VGA_HS,							//	VGA H_SYNC
//		VGA_VS,							//	VGA V_SYNC
//		VGA_BLANK_N,						//	VGA BLANK
//		VGA_SYNC_N,						//	VGA SYNC
//		VGA_R,   						//	VGA Red[9:0]
//		VGA_G,	 						//	VGA Green[9:0]
//		VGA_B,   						//	VGA Blue[9:0]
//		CLOCK2_50,
//		CLOCK3_50
//	);
//
//	input CLOCK_50;
//input CLOCK2_50;
//input CLOCK3_50;
//input [3:0] KEY;
//input [17:0] SW;
//output [7:0] VGA_B;
//output VGA_BLANK_N;
//output VGA_CLK;
//output [7:0] VGA_G;
//output	VGA_HS;
//output [7:0] VGA_R;
//output VGA_SYNC_N;
//output VGA_VS;
//reg	aresetPll = 0;
//wire pixelClock;
//wire [10:0] XPixelPosition;
//wire [10:0] YPixelPosition; 
//reg	[7:0] redValue;
//reg	[7:0] greenValue;
//reg	[7:0] blueValue;
//reg	[2:0] movement = 0;
//reg	[3:0] tool = 0;
//reg [10:0] r = 10;
//reg [10:0] speed = 1;
//reg [10:0] P1_paddle_len = 125;
//reg [10:0] P2_paddle_len = 125;
//reg [10:0] P1_paddle_speed = 5;
//reg [10:0] P2_paddle_speed = 5;
//reg [20:0] slowClockCounter = 0;
//wire slowClock;
//reg [20:0] fastClockCounter = 0;
//wire fastClock;
//reg	[10:0] XDotPosition = 500;
//reg	[10:0] YDotPosition = 500; 
//reg	[10:0] P1x = 225;
//reg	[10:0] P1y = 500;
//reg	[10:0] P2x = 1030;
//reg	[10:0] P2y = 500;
//reg [3:0] P1Score = 0;
//reg	[3:0] P2Score = 0;
//reg flag =1;
//reg	[2:0] printer = 0;
//wire [9:0] randX;
//wire [9:0] randY;
//reg [9:0] itemX = 640;
//reg [9:0] itemY = 512;
//reg [27:0] clock;
//wire [3:0] rtool;
//wire [7:0] color1;
//wire [7:0] color2;
//wire [7:0] color3;
//reg [7:0] col1;
//reg [7:0] col2;
//reg [7:0] col3;
//reg [3:0] randomtool = 2;
//reg [1:0] drawItem;
//
//assign VGA_BLANK_N = 1'b1;
//assign VGA_SYNC_N = 1'b1;			
//assign VGA_CLK = pixelClock;
//	
////	input			CLOCK_50;				//	50 MHz
////	input   [9:0]   SW;
////	input   [3:0]   KEY;
////
////	// Declare your inputs and outputs here
////	// Do not change the following outputs
////	output			VGA_CLK;   				//	VGA Clock
////	output			VGA_HS;					//	VGA H_SYNC
////	output			VGA_VS;					//	VGA V_SYNC
////	output			VGA_BLANK_N;				//	VGA BLANK
////	output			VGA_SYNC_N;				//	VGA SYNC
////	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
////	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
////	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
////	
////	wire resetn,go;
////	assign resetn = KEY[0];
////	assign go = ~KEY[1];
////	
////	wire pixelClock;
////	wire [10:0] XPixelPosition;
////	wire [10:0] YPixelPosition; 
////	reg	[7:0] redValue;
////	reg	[7:0] greenValue;
////	reg	[7:0] blueValue;
////	reg	aresetPll = 0;
////	
////	assign VGA_BLANK_N = 1'b1;
////	assign VGA_SYNC_N = 1'b1;			
////	assign VGA_CLK = pixelClock;
////	
////	// Create the colour, x, y and writeEn wires that are inputs to the controller.
////	wire [2:0] colour;
////	wire [7:0] x,xpos;
////	wire [6:0] y,ypos;
////	wire writeEn;
//	
//	
//	
//	
//	assign colour = SW[9:7];
//	assign ypos = SW[6:0];
//	reg [6:0] med_x;
//	always @(negedge KEY[3], negedge KEY[0])
//	begin
//		if (!KEY[0])
//			med_x <= 7'd0;
//		else
//			med_x <= SW[6:0];
//	end
//	assign xpos = {1'b0,med_x};
//	
////	FSM_datapath(8'b0,7'b0,resetn,CLOCK_50,go,x,y,writeEn);
////	FSM_datapath(8'b0,7'd16,resetn,CLOCK_50,go,x,y,writeEn);
////	FSM_datapath(8'b0,7'd32,resetn,CLOCK_50,go,x,y,writeEn);
////	FSM_datapath(8'b0,7'd48,resetn,CLOCK_50,go,x,y,writeEn);
//	// Create an Instance of a VGA controller - there can be only one!
//	// Define the number of colours as well as the initial background
//	// image file (.MIF) for the controller.
////	vga_adapter VGA(
////			.resetn(resetn),
////			.clock(CLOCK_50),
////			.colour(colour),
////			.x(x),
////			.y(y),
////			.plot(writeEn),
////			/* Signals for the DAC to drive the monitor. */
////			.VGA_R(VGA_R),
////			.VGA_G(VGA_G),
////			.VGA_B(VGA_B),
////			.VGA_HS(VGA_HS),
////			.VGA_VS(VGA_VS),
////			.VGA_BLANK(VGA_BLANK_N),
////			.VGA_SYNC(VGA_SYNC_N),
////			.VGA_CLK(VGA_CLK));
////		defparam VGA.RESOLUTION = "160x120";
////		defparam VGA.MONOCHROME = "FALSE";
////		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
////		defparam VGA.BACKGROUND_IMAGE = "black.mif";
//			
//	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
//	// for the VGA controller, in addition to any other functionality your design may require.
//    
//    // Instansiate datapath
//	// datapath d0(...);
//
//    // Instansiate FSM control
//    // control c0(...)
//		
//
//		
//
//VGAFrequency VGAFreq (aresetPll, CLOCK_50, pixelClock);
//
//VGAController VGAControl (pixelClock, redValue, greenValue, blueValue, VGA_R, VGA_G, VGA_B, VGA_VS, VGA_HS, XPixelPosition, YPixelPosition);
//
////VGA pattern and charactor display
//always@ (posedge pixelClock)
//begin		
//		//Word1 on the top 
//		if (XPixelPosition > 100 && XPixelPosition < 120 && YPixelPosition > 30 && YPixelPosition < 120)//row1
//		begin
//			if (printer == 1 || printer == 2 || printer == 3)
//			begin
//			redValue <= 8'b11111111; 
//			blueValue <= 8'b00000000;
//			greenValue <= 8'b11111111;
//			end
//			else
//			begin
//			redValue <= 8'b00000000; 
//			blueValue <= 8'b11111111;
//			greenValue <= 8'b00000000;
//			end
//		end
////		else if (XPixelPosition > 410 && XPixelPosition < 470 && YPixelPosition > 46 && YPixelPosition < 54)//row2
////		begin
////			//if (printer == 1 || printer == 2 || printer == 3)
////			//begin
////			redValue <= 8'b00000000; 
////			blueValue <= 8'b11111111;
////			greenValue <= 8'b11111111;
////			//end
////			//else
////			//begin
////			redValue <= 8'b00000000; 
////			blueValue <= 8'b00000000;
////			greenValue <= 8'b00000000;
////			//end
////		end
//end
//
//endmodule
//
//// The VGAController is the source code
//// This is a controller written for a VGA Monitor with resolution 1280 by 1024 with an refresh rate of 60 fps
//// VGA Controller use to generate signals for the monitor 
//module VGAController (PixelClock,
//							 inRed,
//							 inGreen,
//							 inBlue,
//							 outRed,
//							 outGreen,
//							 outBlue,
//							 VertSynchOut,
//							 HorSynchOut,
//							 XPosition,
//							 YPosition);50
////======================================================= 
//// Parameter Declarations 				
////=======================================================
//// Parameters are set for a 1280 by 1024 pixel monitor running at 60 frames per second
//// X Screen Constants	 
//parameter XLimit = 1688;
//parameter XVisible = 1280;
//parameter XSynchPulse = 112;
//parameter XBackPorch = 248;
//// Y Screen Constants
//parameter YLimit = 1066;
//parameter YVisible = 1024;
//parameter YSynchPulse = 3;
//parameter YBackPorch = 38;
//
////=======================================================			 
//// Port Declarations 				
////=======================================================
//input PixelClock;
//input [7:0] inRed;
//input [7:0] inGreen;
//input [7:0] inBlue;
//output [7:0] outRed;
//output [7:0] outGreen;
//output [7:0] outBlue;
//output VertSynchOut;
//output HorSynchOut;
//output [10:0] XPosition;
//output [10:0] YPosition;
//
////========================================================
//// REG/WIRE declarations
////========================================================
//
//reg [10:0] XTiming;
//reg [10:0] YTiming;
//reg HorSynch;
//reg VertSynch;
//
////========================================================
//// Structural coding
////========================================================
//assign XPosition = XTiming - (XSynchPulse + XBackPorch);
//assign YPosition = YTiming - (YSynchPulse + YBackPorch);
//
//
//always@(posedge PixelClock)// Control X Timing
//begin
//	if (XTiming >= XLimit)
//		XTiming <= 11'd0;
//	else
//		XTiming <= XTiming + 1;
//end
//	
//always@(posedge PixelClock)// Control Y Timing
//begin
//	if (YTiming >= YLimit && XTiming >= XLimit)
//		YTiming <= 11'd0;
//	else if (XTiming >= XLimit && YTiming < YLimit)
//		YTiming <= YTiming + 1;
//	else
//		YTiming <= YTiming;
//end
//
//always@(posedge PixelClock)// Control Vertical Synch Signal
//begin
//	if (YTiming >= 0 && YTiming < YSynchPulse)
//		VertSynch <= 1'b0;
//	else
//		VertSynch <= 1'b1;
//end
//	
//always@(posedge PixelClock)// Control Horizontal Synch Signal
//begin
//	if (XTiming >= 0 && XTiming < XSynchPulse)
//		HorSynch <= 1'b0;
//	else
//		HorSynch <= 1'b1;
//end
//	
//// Draw black in off screen areas of screen
//assign outRed = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inRed : 8'b0;
//assign outGreen = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inGreen : 8'b0;
//assign outBlue = (XTiming >= (XSynchPulse + XBackPorch) && XTiming <= (XSynchPulse + XBackPorch + XVisible)) ? inBlue : 8'b0;
//
//assign VertSynchOut = VertSynch;
//assign HorSynchOut = HorSynch;
//
//
//// Initialization registers block
//initial
//begin
//	XTiming = 11'b0;
//	YTiming = 11'b0;
//	HorSynch = 1'b1;
//	VertSynch = 1'b1;
//end
//	
//	
//endmodule 
//
//`timescale 1 ps / 1 ps
//// The VGAFrequency is the source code
//module VGAFrequency (
//	areset,
//	inclk0,
//	c0);
//
//	input	  areset;
//	input	  inclk0;
//	output	  c0;
//`ifndef ALTERA_RESERVED_QIS
//// synopsys translate_off
//`endif
//	tri0	  areset;
//`ifndef ALTERA_RESERVED_QIS
//// synopsys translate_on
//`endif
//
//	wire [0:0] sub_wire2 = 1'h0;
//	wire [4:0] sub_wire3;
//	wire  sub_wire0 = inclk0;
//	wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
//	wire [0:0] sub_wire4 = sub_wire3[0:0];
//	wire  c0 = sub_wire4;
//
//	altpll	altpll_component (
//				.areset (areset),
//				.inclk (sub_wire1),
//				.clk (sub_wire3),
//				.activeclock (),
//				.clkbad (),
//				.clkena ({6{1'b1}}),
//				.clkloss (),
//				.clkswitch (1'b0),
//				.configupdate (1'b0),
//				.enable0 (),
//				.enable1 (),
//				.extclk (),
//				.extclkena ({4{1'b1}}),
//				.fbin (1'b1),
//				.fbmimicbidir (),
//				.fbout (),
//				.fref (),
//				.icdrclk (),
//				.locked (),
//				.pfdena (1'b1),
//				.phasecounterselect ({4{1'b1}}),
//				.phasedone (),
//				.phasestep (1'b1),
//				.phaseupdown (1'b1),
//				.pllena (1'b1),
//				.scanaclr (1'b0),
//				.scanclk (1'b0),
//				.scanclkena (1'b1),
//				.scandata (1'b0),
//				.scandataout (),
//				.scandone (),
//				.scanread (1'b0),
//				.scanwrite (1'b0),
//				.sclkout0 (),
//				.sclkout1 (),
//				.vcooverrange (),
//				.vcounderrange ());
//	defparam
//		altpll_component.bandwidth_type = "AUTO",
//		altpll_component.clk0_divide_by = 25,
//		altpll_component.clk0_duty_cycle = 50,
//		altpll_component.clk0_multiply_by = 54,
//		altpll_component.clk0_phase_shift = "0",
//		altpll_component.compensate_clock = "CLK0",
//		altpll_component.inclk0_input_frequency = 20000,
//		altpll_component.intended_device_family = "Cyclone IV E",
//		altpll_component.lpm_hint = "CBX_MODULE_PREFIX=VGAFrequency",
//		altpll_component.lpm_type = "altpll",
//		altpll_component.operation_mode = "NORMAL",
//		altpll_component.pll_type = "AUTO",
//		altpll_component.port_activeclock = "PORT_UNUSED",
//		altpll_component.port_areset = "PORT_USED",
//		altpll_component.port_clkbad0 = "PORT_UNUSED",
//		altpll_component.port_clkbad1 = "PORT_UNUSED",
//		altpll_component.port_clkloss = "PORT_UNUSED",
//		altpll_component.port_clkswitch = "PORT_UNUSED",
//		altpll_component.port_configupdate = "PORT_UNUSED",
//		altpll_component.port_fbin = "PORT_UNUSED",
//		altpll_component.port_inclk0 = "PORT_USED",
//		altpll_component.port_inclk1 = "PORT_UNUSED",
//		altpll_component.port_locked = "PORT_UNUSED",
//		altpll_component.port_pfdena = "PORT_UNUSED",
//		altpll_component.port_phasecounterselect = "PORT_UNUSED",
//		altpll_component.port_phasedone = "PORT_UNUSED",
//		altpll_component.port_phasestep = "PORT_UNUSED",
//		altpll_component.port_phaseupdown = "PORT_UNUSED",
//		altpll_component.port_pllena = "PORT_UNUSED",
//		altpll_component.port_scanaclr = "PORT_UNUSED",
//		altpll_component.port_scanclk = "PORT_UNUSED",
//		altpll_component.port_scanclkena = "PORT_UNUSED",
//		altpll_component.port_scandata = "PORT_UNUSED",
//		altpll_component.port_scandataout = "PORT_UNUSED",
//		altpll_component.port_scandone = "PORT_UNUSED",
//		altpll_component.port_scanread = "PORT_UNUSED",
//		altpll_component.port_scanwrite = "PORT_UNUSED",
//		altpll_component.port_clk0 = "PORT_USED",
//		altpll_component.port_clk1 = "PORT_UNUSED",
//		altpll_component.port_clk2 = "PORT_UNUSED",
//		altpll_component.port_clk3 = "PORT_UNUSED",
//		altpll_component.port_clk4 = "PORT_UNUSED",
//		altpll_component.port_clk5 = "PORT_UNUSED",
//		altpll_component.port_clkena0 = "PORT_UNUSED",
//		altpll_component.port_clkena1 = "PORT_UNUSED",
//		altpll_component.port_clkena2 = "PORT_UNUSED",
//		altpll_component.port_clkena3 = "PORT_UNUSED",
//		altpll_component.port_clkena4 = "PORT_UNUSED",
//		altpll_component.port_clkena5 = "PORT_UNUSED",
//		altpll_component.port_extclk0 = "PORT_UNUSED",
//		altpll_component.port_extclk1 = "PORT_UNUSED",
//		altpll_component.port_extclk2 = "PORT_UNUSED",
//		altpll_component.port_extclk3 = "PORT_UNUSED",
//		altpll_component.width_clock = 5;
//
//
//endmodule
//
//module FSM_datapath(xpos,ypos,resetn,clk,go,x,y,plot);
//	input [7:0] xpos;
//	input [6:0] ypos;
//	input resetn,clk,go;
//	output [7:0] x;
//	output [6:0] y;
//	output reg plot;
//	reg counter_enable;
//	reg x_counter_enable;
//	reg y_counter_enable;
//	wire finish;
//	wire finish_x;
//	wire finish_y;
//	
//	reg [3:0] counter_output;
//	reg [7:0] counter_x;
//	reg [7:0] counter_y;
//	reg [1:0] current_state,next_state;
//	reg [7:0] next_x;
//	
//	localparam  NEUTRAL        = 3'd0,
//                WAIT           = 3'd1,
//                PLOT           = 3'd2,
//					 NEXT_X		=3'd3,
//					 NEXT_Y		= 3'd4;
//	
//	always@(*)
//    begin: state_table 
//            case (current_state)
//                NEUTRAL: next_state = go ? PLOT : NEUTRAL; 
//                PLOT: next_state = finish ? NEXT_X: PLOT;
//					 NEXT_X: next_state = finish_x ? NEUTRAL : PLOT;
//					 //NEXT_Y: next_state = finish_y ? NEUTRAL : PLOT;
//            default:     next_state = NEUTRAL;
//        endcase
//    end 
//	
//	// current_state registers
//    always@(posedge clk)
//    begin: state_FFs
//        if(!resetn)
//            current_state <= NEUTRAL;
//        else
//            current_state <= next_state;
//    end // state_FFS
//	
//	always @(*)
//    begin: output_logic
//		plot = 1'b0;
//		counter_enable = 1'b0;
//        case (current_state)
//            NEUTRAL: begin
//                plot = 1'b0;
//				counter_enable = 1'b0;
//				x_counter_enable = 1'b0;
//				y_counter_enable= 1'b0;
//                end
//            PLOT: begin
//                plot = 1'b1;
//				counter_enable = 1'b1;
//				x_counter_enable = 1'b0;
//				y_counter_enable = 1'b0;
//                end
//				NEXT_X: begin
//					plot = 1'b0;
//					counter_enable = 1'b0;
//					x_counter_enable = 1'b1;
//					y_counter_enable= 1'b0;
//				end
//				NEXT_Y: begin
//					plot = 1'b0;
//					counter_enable = 1'b0;
//					x_counter_enable = 1'b0;
//					y_counter_enable= 1'b1;
//				end
//        endcase
//    end 
//	
//	always @(posedge clk, negedge resetn)
//	begin: counter
//		if(!resetn)
//			counter_output <= 4'd0;
//		else if(counter_output == 4'b1111)
//			counter_output <= 4'd0;
//		else if(counter_enable == 1'b1)
//			counter_output <= counter_output + 1'b1;
//	end
//	
//	//x counter
//	always @(posedge clk, negedge resetn)
//	begin: x_counter
//		if(!resetn)
//			counter_x <= 8'd0;
//		else if(counter_x == 8'b11111111)
//			counter_x <= 8'd0;
//		else if(x_counter_enable == 1'b1)
//			counter_x <= counter_x + 1'b1;
//	end
//	
////	//y counter
////	always @(posedge clk, negedge resetn)
////	begin: y_counter
////		if(!resetn)
////			counter_y <= 8'd0;
////		else if(counter_y == 8'b00100000)
////			counter_y <= 8'd0;
////		else if(y_counter_enable == 1'b1)
////			counter_y <= counter_y + 8'b00001000;
////	end
//	
//	
//	assign finish = &counter_output;
//	assign finish_x = &counter_x;
//	//assign finish_y = counter_y[5];
//	
//	assign x = xpos + counter_output[1:0] + counter_x[7:0];
//	//assign y = ypos + counter_output[3:2] + counter_y[7:0];
//endmodule
//
//
//		
//		
//		
//		
//		
//		
