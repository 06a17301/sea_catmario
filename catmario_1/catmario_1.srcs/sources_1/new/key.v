`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 11:08:08
// Design Name: 
// Module Name: key
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


module key(
    input clk,//clk_system
    input rst,
    input key_left,
    input key_right,
    input key_jump,
    output reg left_en,
    output reg right_en,
    output reg jump_en,
    //output reg [3:0]tlevel_left,//16个等级，1
    //output reg [3:0]tlevel_right,
    output reg [3:0]tlevel_jump
    
    );
 //   reg [31:0]clk_cnt=0;
    reg [31:0]clk_cnt_low=0;
//    reg left_key_last;
//    reg right_key_last;
//    reg jump_key_last;
    reg [1:0]jump_i=0;
    reg [1:0]left_i=0;
    reg [1:0]right_i=0;

        always@(posedge clk or negedge rst) 
        begin
        if(!rst) begin
 //           clk_cnt <= 0;
            left_en <= 0;
            right_en <= 0;
            jump_en<=0;
                  
//            left_key_last <= 0;
//            right_key_last <= 0;
//            jump_key_last <= 0;              
        end 
        else begin
//            if(clk_cnt == 30_0000) begin//30_0000
//                clk_cnt <= 0;
////                left_key_last <= key_left;
//                right_key_last <= key_right;
//                jump_key_last <= key_jump;  
                  
//                if(left_key_last == 0 && key_left == 1) 
if(left_i==2'b10)
                    left_en <= 1;
    //            if(right_key_last == 0 && key_right == 1)
   else if(left_i==2'b01)
                    left_en <= 0;
   else if(right_i==2'b10)
                    right_en <= 1;
                    else if(right_i==2'b01)
                    right_en <=0;
     //           if(jump_key_last == 0 && key_jump == 1)
   else  if(jump_i==2'b10)
                    jump_en <= 1;
                    else  if(jump_i==2'b01)
                    jump_en <= 0;
            end
      end                           
//            else begin
//                clk_cnt <= clk_cnt + 1;
//                left_en <= 0;
//                right_en <= 0;
//                jump_en <= 0;

//            end
//        end 
//    end    
    always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            jump_i<=2'b00;
            else
            jump_i<={jump_i[0],key_jump};
        end    
        always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            left_i<=2'b00;
            else
            left_i<={left_i[0],key_left};
        end  
            always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            right_i<=2'b00;
            else
            right_i<={right_i[0],key_right};
        end  
    always@( posedge clk) //////////////得到jump的相对时长
    begin
         if(key_jump==0)
            clk_cnt_low=clk_cnt_low+1;
         else
            begin
                if(0<=clk_cnt_low/30_0000<1000&&jump_i==2'b01)
                    begin
                    tlevel_jump=(clk_cnt_low/30_0000)/10;
                    clk_cnt_low=0;
                    end
                    else
                    tlevel_jump=0;         
                    clk_cnt_low=0;
             end
    end         
  
endmodule














