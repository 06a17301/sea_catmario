`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 08:12:26
// Design Name: 
// Module Name: monster
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module monster(
    input clk,
    input rst,
    input hit_unknown3,
    output reg [11:0]monster_x,
    output reg [11:0]monster_y,
    output reg monster_en0
    );
    reg [31:0]cnt;
    
    always@(posedge clk or negedge rst)
        begin
            if(!rst) begin
			cnt <= 0;	
			monster_en0<=0;		
			monster_x <= 22*32;
			monster_y <= 18*32;

		    end	
		    else //if(hit_unknown3==1)
		    begin
		          cnt<=cnt+1;
		       //   monster_en0<=1;
		          if(cnt==10_000_000 )begin
		              cnt<=0;
		              if(hit_unknown3==1) begin
		              monster_en0<=1;	
		                  if((monster_y==18*32)&&(monster_x<24*32)) begin
		                      monster_x<=monster_x+8;
		                      monster_y<=monster_y;
		                  end
		                  else if((monster_x==24*32)&&(monster_y<22*32)) begin
		                      monster_x<=monster_x;
		                      monster_y<=monster_y+16;
		                  end
		                  else if((monster_y==22*32)&&(monster_x>9*32)) begin
		                      monster_x<=monster_x-8;
		                      monster_y<=monster_y;
		                  end
		                  else if((monster_y==22*32)&&(monster_x==9*32)) begin
		                      monster_en0<=0;
		                       monster_x<=monster_x;
		                  monster_y<=monster_y; 
		                  end
		               end   
		           else begin
		                  monster_en0<=monster_en0;
		                  monster_x<=monster_x;
		                  monster_y<=monster_y; 
		           end
		   end
		   
//		   else begin
//		   monster_en0<=0;		
//		   monster_x <= 22*32;
//		   monster_y <= 18*32; 
		   
//		   end
	end	                       
end		    
		    
		    
endmodule
