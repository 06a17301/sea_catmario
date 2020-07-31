`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 00:40:01
// Design Name: 
// Module Name: video
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



module video(
input clk,
//input [2:0]cat_direct,
///////////////游戏控制部分给出参数
input hit_unknown1,
input hit_unknown2,
input hit_unknown3,

input [1:0]game_status,

///monster
//////////////////////
//input [2:0]element,
//input cat_en0,
//input map_en,//等于零说明人物死亡，换game over的图像显示（自动重新开始，需要延时

input [11:0]cat_x,//=12'd90,是否可以赋初值？？？？？？？？？？？？？？？？？？？
input [11:0]cat_y,//=12'd840,
    input RGB_VDE,
    input [11:0]Set_X,
    input [11:0]Set_Y,
    output reg[23:0]RGB_Data    //RBG
    );
 //   reg [13:0]Address=0;
//////////////////    wire [7:0]R_Data;
///////////////////    wire [7:0]G_Data;
///////////////////////    wire [7:0]B_Data=8'h00;
//换算成50*50的块    
//    wire [5:0]x_rem;
//    wire [5:0]y_rem;
//   wire [11:0]addr=0;
   
    wire [7:0]cat_r_data;
    wire [7:0]cat_g_data;
    wire [7:0]cat_b_data;

    wire [7:0]brick_data;
    wire [7:0]unknown_data;
    wire [7:0]hidden_data;
    
    wire[7:0]win_data;
    wire[7:0]fail_data;
//////////////////////// //   wire [7:0]fish_data;
///////////////////////////////  //  wire [7:0]monster_data;
//    wire [7:0]brick_r_data;
//    wire [7:0]brick_b_data;
  //   wire [7:0]brick_g_data; 
//     wire [7:0]hidden_r_data;
//     wire [7:0]hidden_g_data;     
//    wire [7:0]unknown_r_data;
//     wire [7:0]unknown_g_data; 
  //    wire [7:0]unknown_b_data; 
 //   wire [7:0]money_rg_data;
   // wire [7:0]zero=8'h00;
    reg[12:0]win_address;
    reg[12:0]fail_address;
    
    
    reg [10:0]cat_address;
    reg [9:0]brick_address;
    reg [9:0]unknown_address;
    
//    reg cat_en;//0：cat可以显示；1：cat不可以显示
//    reg black_en;
//    reg unknown_en;//0：brick可以显示；1：显示unknown
    wire cat_en;
    wire black_en;
     wire unknown_en;
    wire hidden1_en;
    wire hidden2_en;
    wire hidden3_en;
    
    wire brick_en;
    wire center_en;
    wire [7:0]x_32;
    wire [7:0]y_32;
    
    assign x_32=Set_X>>5;
    assign y_32=Set_Y>>5;
   /////////////////////////////////////////////////地图及人物的绘制，需要添加游戏控制部分提供的使能：map_en0，需要GAMEOVER////////////////////// 
    /////////////////////////////////直接算/32（>>5)在哪个范围就行！！！！！！！！！！！！
   // always@(Set_X or Set_Y)
   // begin 
   assign black_en=(x_32>=0&&x_32<10)||(x_32>=53&&x_32<60)||(x_32>=10&&x_32<53&&y_32>=0&&y_32<10)||(x_32>=10&&x_32<53&&y_32>=25&&y_32<34);
  
    assign brick_en=(x_32>=10&&x_32<36&&y_32>=23&&y_32<25)||(x_32>=39&&x_32<45&&y_32>=23&&y_32<25)||(x_32>=46&&x_32<53&&y_32>=23&&y_32<25)||
                    (x_32>=19&&x_32<20&&y_32>=19&&y_32<20)||(x_32>=21&&x_32<22&&y_32>=19&&y_32<20)||(x_32>=23&&x_32<24&&y_32>=19&&y_32<20)||
                    (x_32>=35&&x_32<36&&y_32>=20&&y_32<21)||(x_32>=39&&x_32<40&&y_32>=20&&y_32<21)||
                    (x_32>=27&&x_32<29&&y_32>=20&&y_32<23)||(x_32>=46&&x_32<48&&y_32>=20&&y_32<23)||
                    (x_32>=34&&x_32<36&&y_32>=21&&y_32<23)||(x_32>=39&&x_32<41&&y_32>=21&&y_32<23);
//                    (Set_X>=1635&&Set_X<1885&&Set_Y>=900&&Set_Y<1000)||(Set_X>=835&&Set_X<935&&Set_Y>=750&&Set_Y<900)||
//                    (Set_X>=1635&&Set_X<1735&&Set_Y>=750&&Set_Y<900)||(Set_X>=1035&&Set_X<1135&&Set_Y>=800&&Set_Y<900)||
//                    (Set_X>=1285&&Set_X<1385&&Set_Y>=800&&Set_Y<900)||(Set_X>=1085&&Set_X<1135&&Set_Y>=750&&Set_Y<800)||
//                    (Set_X>=1285&&Set_X<1335&&Set_Y>=750&&Set_Y<800);                   
   assign unknown_en=(x_32>=15&&x_32<16&&y_32>=19&&y_32<20)||(x_32>=20&&x_32<21&&y_32>=19&&y_32<20)||(x_32>=22&&x_32<23&&y_32>=19&&y_32<20);
    assign hidden1_en=(x_32>=15&&x_32<16&&y_32>=19&&y_32<20);
    assign hidden2_en=(x_32>=20&&x_32<21&&y_32>=19&&y_32<20);
    assign hidden3_en=(x_32>=22&&x_32<23&&y_32>=19&&y_32<20);
assign  cat_en=(Set_X>=cat_x)&&(Set_X<(cat_x+32))&&(Set_Y>=cat_y+8)&&(Set_Y<(cat_y+64));/////2格高,上面八行像素不显示
//    (!((cat_x>=64&&cat_x<768&&cat_y>=672&&cat_y<736)||(cat_x>=864&&cat_x<1056&&cat_y>=672&&cat_y<736)));
 assign center_en=(x_32>=28&&x_32<32&&y_32>=18&&y_32<20);
    ////////////////猫的位置是否正确由游戏控制部分给出cat_en0//////////////////
   //  end
    /////////////
    reg [3:0]part;
    always@(Set_X or Set_Y)
    begin
        if(!black_en) 

        part=brick_en? 1:((unknown_en==1) ? 2:((cat_en==1) ? 3:7));

        //part=0;//黑色区域
        else 
        part=0;
                    
    end///////////////////////////是否与可以直接放到下面的always里面去判断？或者写成。。
    //////////////////////////////////////////////////////////////////////////////////////////
    localparam PLAY = 2'b00;
	localparam FAIL = 2'b01;
	localparam WIN = 2'b10;
//	localparam INITIAL = 2'b11;


    always@(posedge clk)
        begin
        if(game_status==WIN)begin
                if(center_en==1)begin
                win_address<=((Set_X-28*32)<<6)+(Set_Y-18*32);
                RGB_Data<={ win_data,win_data, win_data};
                end
                else
                RGB_Data<=24'h000000;
           end     
       
        
        else if(game_status==FAIL)begin
                if(center_en==1)begin
                fail_address<=((Set_X-28*32)<<6)+(Set_Y-18*32);
                RGB_Data<={ fail_data,fail_data, fail_data};
                end
                else
                RGB_Data<=24'h000000;
        
        end
        
//        else if(game_status==INITIAL) begin
//        case(part)
//                     0:  
//                        RGB_Data<=24'h000000;
//                                 //          RGB_Data<={ R_Data,G_Data,B_Data };                        
//                    1:  
//                        begin
//                       brick_address=((Set_X&31)<<5)+(Set_Y&31); ///////////不能用左移<<，为什么？？？？？
//                       //    brick_address=(Set_X-(Set_X>>5)<<5)<<5+(Set_Y-(Set_Y>>5)<<5); ///////////不能用左移<<，为什么？？？？？
//                        RGB_Data<={ brick_data,brick_data, brick_data};
//                                   //         RGB_Data<={ R_Data,G_Data,B_Data };
//                        end
//                    2:
//                        begin
//                        unknown_address=((Set_X&31)<<5)+(Set_Y&31);
  
//                        RGB_Data<={ unknown_data,unknown_data, unknown_data};
                        
//                                   //         RGB_Data<={ R_Data,G_Data,B_Data };
//                        end
//                    3:
//                        begin
        
//                          cat_address=((Set_X-cat_x)<<6)+(Set_Y-cat_y);
//                          RGB_Data<={cat_r_data,cat_b_data,cat_g_data};         
//                        end
//                    default: RGB_Data<=24'h76ff91;  ////////背景色
//             endcase 
//             end
        

        
        else    begin//if(game_status==PLAY||game_status==INITIAL)////////INITIAL需要开始界面吗？？？？？？？？？？？
              case(part)
                     0:  
                        RGB_Data<=24'h000000;
                                 //          RGB_Data<={ R_Data,G_Data,B_Data };                        
                    1:  
                        begin
                        brick_address<=((Set_X&31)<<5)+(Set_Y&31); ///////////不能用左移<<，为什么？？？？？
                        RGB_Data<={ brick_data,brick_data, brick_data};
                                   //         RGB_Data<={ R_Data,G_Data,B_Data };
                        end
                    2:
                        begin
                        unknown_address<=((Set_X&31)<<5)+(Set_Y&31);
                        if((hit_unknown1==1)&&(hidden1_en==1))
                        RGB_Data<={ hidden_data,hidden_data, hidden_data};
                        else if((hit_unknown2==1)&&(hidden2_en==1))
                        RGB_Data<={ hidden_data,hidden_data, hidden_data};
                        else if((hit_unknown3==1)&&(hidden3_en==1))
                        RGB_Data<={ hidden_data,hidden_data, hidden_data};
                        else
                        RGB_Data<={ unknown_data,unknown_data, unknown_data};
//                        else
//                        RGB_Data<={ hidden_data,hidden_data, hidden_data};
                        
                                   //         RGB_Data<={ R_Data,G_Data,B_Data };
                        end
                    3:
                        begin
//                        if((Set_Y-cat_y)<32)
//                        begin
//                        cat_head_address=((Set_X-cat_x)<<5)+(Set_Y-cat_y);
//                        RGB_Data<={cat_head_data,cat_head_data,cat_head_data};
//                        end
//                        else
//                        cat_body_address=((Set_X-cat_x)<<5)+(Set_Y-cat_y-32);
//                        RGB_Data<={cat_body_data,cat_body_data,cat_body_data};
                                   //         RGB_Data<={ R_Data,G_Data,B_Data };           
                          cat_address<=((Set_X-cat_x)<<6)+(Set_Y-cat_y);
                          RGB_Data<={cat_r_data,cat_b_data,cat_g_data};         
                        end
                    default: RGB_Data<=24'h76ff91;  ////////背景色
             endcase 
             end
                  
       end            


//   brickg_dist_mem_gen_0 unknowng_0(

//      .a(unknown_address),  // input wire [9 : 0] addra
//      .spo(unknown_g_data)  // output wire [7 : 0] douta
//    );     
   unknown_dist_mem_gen_0 unknown_0(

      .a(unknown_address),  // input wire [9 : 0] addra
      .spo(unknown_data)  // output wire [7 : 0] douta
    ); 
       brick_dist_mem_gen_0 brick_0(

      .a(brick_address),  // input wire [9 : 0] addra
      .spo(brick_data)  // output wire [7 : 0] douta
    );     
          hidden_dist_mem_gen_0 hidden_0(

      .a(unknown_address),  // input wire [9 : 0] addra
      .spo(hidden_data)  // output wire [7 : 0] douta
    );  
           win_dist_mem_gen_0 win_0(

      .a(win_address),  // input wire [9 : 0] addra
      .spo(win_data)  // output wire [7 : 0] douta
    );  
    
           fail_dist_mem_gen_0 fail_0(

      .a(fail_address),  // input wire [9 : 0] addra
      .spo(fail_data)  // output wire [7 : 0] douta
    );  
    
      catr_dist_mem_gen_0 cat_r_0(
      .a(cat_address),  // input wire [10 : 0] addra
      .spo(cat_r_data)  // output wire [7 : 0] douta
    );  
    catg_dist_mem_gen_0 cat_g_0(

      .a(cat_address),  // input wire [9 : 0] addra
      .spo(cat_g_data)  // output wire [7 : 0] douta
    );     
    catb_dist_mem_gen_0 cat_b_0(

      .a(cat_address),  // input wire [9 : 0] addra
      .spo(cat_b_data)  // output wire [7 : 0] douta
    ); 

    
endmodule
