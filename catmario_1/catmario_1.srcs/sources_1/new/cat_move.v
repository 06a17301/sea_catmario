`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 13:20:51
// Design Name: 
// Module Name: cat_move
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


module cat_move(
//    input [11:0]Set_X,
//    input [11:0]Set_Y,

    input clk,//clk_system
    input rst,
    input left_en,////1:ʹ��
    input right_en,
    input jump_en,
    input [3:0]tlevel_jump,
    
   input [2:0]game_status,////���ֻҪ�����HDMI_display����,no
    
    output reg [11:0]cat_x=11*32,//=12'd90,�Ƿ���Ը���ֵ��������������������������������������
    output reg [11:0]cat_y=21*32//=12'd840,
    );
    wire [2:0]direct_en;
    assign direct_en={left_en,right_en,jump_en};
    
//    reg [11:0]cat_xx=12'd352;
//    reg [11:0]cat_yy=12'd672;
    reg [31:0]cnt;
    
//    always@(posedge clk or negedge rst)
//    begin
//    if(!rst)
//    cnt<=0;
//    else
//    begin
//    cnt<=cnt+1;
//		      if(cnt==30_000_000)begin///////////��Լÿ�����//////////30_000000
//		          cnt<=0;
//		          if(game_status==0)
//		          begin
//		          if(right_en==1)
//		          cat_x<=cat_x+8;
//		          else if(left_en==1) 
//		          cat_x<=cat_x-8;
//		          end
		          
//		          else if(game_status==1)
//		          cat_x<=cat_x+8;
//		          end
//	end 
//	end    


    always@(posedge clk or negedge rst)
        begin
            if(!rst) begin
			cnt <= 0;			
			cat_x <= 11*32;
			cat_y <= 21*32;
//			ren_hit_wall <= 0;
//			meet<=0;
		    end	
		    
		    else if(game_status==3)begin
		    cnt <= 0;			
			cat_x <= 11*32;
			cat_y <= 21*32;
//			ren_hit_wall <= 0;
//			meet<=0;
		    end	
		    
		    ///////////////////////////////////////meet??????????orfall??????????????????
		    else 
		    begin
		      cnt<=cnt+1;
		      if(cnt==10_000_000)begin///////////��Լÿ�����//////////30_000000
		          cnt<=0;
		          if(game_status==0)begin
		              	////////////////////////////ǽ�ں�win����������������������������
		              	case(direct_en)
		              	3'b100:begin
		              	/////////////////////////////ײǽ
		              	  // if(//����ĳЩλ�þ����
		              	  if(cat_x==10*32)//&&cat_yy==21*32)
		              	   cat_x<=cat_x;
		              	   else
		              	   cat_x<=cat_x-8;
		              	 end
		              	 3'b010:begin
		              	   if( cat_x==36*32&&(cat_y<=21*32&&cat_y>=18*32)   )
		              	   cat_x<=cat_x;
		              	   else
		              	   cat_x<=cat_x+8;
		              	 end 
		              	 3'b001:begin
		              	    if( ( ( cat_x>=24*32&&cat_x>=26*32)|| (cat_x>=28*32&&cat_x>=34*32))
		              	    &&cat_y==21*32) 
		              	    cat_y<=21*32;
		              	    else
		              	    
		              	    cat_y<=cat_y+16;
		              	    end
		              	 default:begin
		              	 cat_x<=cat_x;
		              	 cat_y<=cat_y;
		              	 end
		              	 endcase
		             end 	 
		        end
		   end
	end	  
	
//	always@(Set_X or Set_Y)
//	begin
//	cat_x<=cat_xx;
//	cat_y<=cat_yy; 
//	end           	    
    
endmodule










