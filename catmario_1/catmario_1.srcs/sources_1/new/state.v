`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 09:33:40
// Design Name: 
// Module Name: state
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


module state(
    input clk,//clk_system
	input rst,
  //  input key_start,
	input cat_win,/////需要key2move给出；1：win
	input cat_die,/////需要key2move给出：1：die
	output reg [1:0]game_status=2'b00

    );
    localparam PLAY = 2'b00;
	localparam FAIL = 2'b01;
	localparam WIN = 2'b10;
//	localparam INITIAL = 2'b11;
	
//	reg [1:0]start_i=0;
//always@(posedge clk or negedge rst)///////////检测key的上升沿
//        begin
//            if(!rst)
//            start_i<=2'b00;
//            else
//            start_i<={start_i[0],key_start};
//        end    
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst) begin
                    game_status <= PLAY;//??????????????PLAY??????????????????/
	
		end
		else begin
			case(game_status)			
//			    INITIAL:begin           //游戏开始等待
//					if(key_start==2'b10) begin
//						game_status <= PLAY;
						
//						end
//					else begin
//						game_status <= INITIAL;
					
//					end
//					if(clk_cnt <= 100_000_000) 
//						clk_cnt <= clk_cnt + 1;		
//					else begin
//						game_status <= PLAY;
//						clk_cnt <= 0;
//					end
                
                
			//	end
				
				PLAY:begin
				     if(cat_win==1)
					  game_status <= WIN;
				     else if(cat_die==1)
				      game_status <= FAIL;
					 else 
					 game_status <= PLAY;
				end	
				
				WIN:begin
				     if(!rst) 
					    begin
						  
						  game_status<=PLAY;
					    end
					else begin 	
					 
					  game_status <= WIN;
					end
				end	
								
				FAIL:begin
					if(!rst) 
					     begin
						   
						   game_status<=PLAY;
						 end
					else begin
							
							game_status <= FAIL;
						 end
					end
			endcase
		end
	end
    
    
endmodule









