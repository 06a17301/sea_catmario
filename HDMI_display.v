`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 17:27:39
// Design Name: 
// Module Name: HDMI_display
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


module HDMI_display(
    input clk_100MHz,
  //     input [11:0]cat_x,//=12'd90,是否可以赋初值？？？？？？？？？？？？？？？？？？？
  //  input [11:0]cat_y,//=12'd840,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P,
    input rst,
    input key_right,
    input key_jump///////////////////////
  //  input key_left
 //   input key_start
 
    );
    wire clk_system;
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    
//    wire left_en;
//    wire right_en;
//   wire jump_en;
//   wire [3:0]tlevel_jump;
   
   wire cat_win;
   wire cat_die;
   wire hit_unknown;
   wire [1:0]game_status;
   
   wire [11:0]cat_x;
   wire [11:0]cat_y;
   
   state state0(
  //  .key_start(key_start),
    .clk(clk_system),
    .rst(rst),
    .cat_win(cat_win),
    .cat_die(cat_die),
    .game_status(game_status)
    );
    
    clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_in1(clk_100MHz));
    
    key2move key2move0(
     .clk(clk_system),
    .rst(rst),
    .game_status(game_status),///////////////////////之后要改！！！！！！！！！！！
    .key_left(1),
    .key_right(key_right),
    .key_jump(key_jump),
    .cat_win(cat_win),
    .cat_die(cat_die),
     .hit_unknown(hit_unknown),
    .cat_x(cat_x),
    .cat_y(cat_y)
    );
    
//    key key0(
//    .clk(clk_system),
//    .rst(rst),
//    .key_left(key_left),
//    .key_right(key_right),
//    .key_jump(1),
//    .left_en(left_en),
//    .right_en(right_en),
//    .jump_en(jump_en),
//    .tlevel_jump(tlevel_jump)
//    );
    
//    cat_move cat_move0(
////                .Set_X(Set_X),
////            .Set_Y(Set_Y),
//        .clk(clk_system),
//    .rst(rst),
//    .left_en(left_en),
//    .right_en(right_en),
//    .jump_en(jump_en),
//    .tlevel_jump(tlevel_jump),
//    .game_status(0),///////////////////////之后要改！！！！！！！！！！！
//    .cat_x(cat_x),
//    .cat_y(cat_y)
//    );
    
        
    
    
    //RGBToDvi实例化
    rgb2dvi_0 rgb2dvi(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),
        .TMDS_Clk_n(TMDS_Tx_Clk_N),
        .TMDS_Data_p(TMDS_Tx_Data_P),
        .TMDS_Data_n(TMDS_Tx_Data_N),
        .aRst_n(1),
        .vid_pData(RGB_Data),
        .vid_pVDE(RGB_VDE),
        .vid_pHSync(RGB_HSync),
        .vid_pVSync(RGB_VSync),
        .PixelClk(clk_system));
    //视频产生
    Driver_HDMI Driver_HDMI0(
        .clk(clk_system),        //时钟
        .Rst(1),                 //复位信号,低电平复位
        .Video_Mode(0),          //视频格式
        .RGB_In(RGB_In),         //输入数据
        .RGB_Data(RGB_Data),     //输出数据
        .RGB_HSync(RGB_HSync),   //行信号
        .RGB_VSync(RGB_VSync),   //场信号
        .RGB_VDE(RGB_VDE),       //数据有效信号
        .Set_X(Set_X),           //图像坐标X
        .Set_Y(Set_Y)            //图像坐标Y
        );
        
        
        
   video video0(
            .hit_unknown(hit_unknown),
             .game_status(game_status),
             
            .cat_x(cat_x),//是否可以赋初值？？？？？？？？？？？？？？？？？？？12'd352
            .cat_y(cat_y),//=12'd840,12'd672
            .clk(clk_system),
            .RGB_VDE(RGB_VDE),
            .Set_X(Set_X),
            .Set_Y(Set_Y),
            .RGB_Data(RGB_In)    //RBG
            );
endmodule

