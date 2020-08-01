`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 17:25:23
// Design Name: 
// Module Name: Driver_HDMI
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


`define Video_Mode_1920_1080 0
`define Video_Mode_1280_720 1

module Driver_HDMI(
    input clk,                          //时钟
    input Rst,                          //复位信号,低电平复位
    input Video_Mode,                   //视频格式
    input [23:0]RGB_In,                 //输入数据
    output [23:0]RGB_Data,              //输出数据
    output reg RGB_HSync=0,            //行信号
    output reg RGB_VSync=0,            //场信号
    output reg RGB_VDE=0,              //数据有效信号
    output reg [11:0]Set_X=0,          //图像坐标X
    output reg [11:0]Set_Y=0           //图像坐标Y
    );
    parameter H_ACTIVE_1280_720 = 16'd1280;
    parameter H_FP_1280_720 = 16'd110;
    parameter H_SYNC_1280_720 = 16'd40;
    parameter H_BP_1280_720 = 16'd220; 
    parameter V_ACTIVE_1280_720 = 16'd720;
    parameter V_FP_1280_720     = 16'd5;
    parameter V_SYNC_1280_720  = 16'd5;
    parameter V_BP_1280_720    = 16'd20;
    parameter H_TOTAL_1280_720 = H_ACTIVE_1280_720 + H_FP_1280_720 + H_SYNC_1280_720 + H_BP_1280_720;
    parameter V_TOTAL_1280_720 = V_ACTIVE_1280_720 + V_FP_1280_720 + V_SYNC_1280_720 + V_BP_1280_720;
    
    parameter H_ACTIVE_1920_1080 = 16'd1920;
    parameter H_FP_1920_1080 = 16'd88;
    parameter H_SYNC_1920_1080 = 16'd44;
    parameter H_BP_1920_1080 = 16'd148; 
    parameter V_ACTIVE_1920_1080 = 16'd1080;
    parameter V_FP_1920_1080     = 16'd4;
    parameter V_SYNC_1920_1080  = 16'd5;
    parameter V_BP_1920_1080    = 16'd36;
    parameter H_TOTAL_1920_1080 = H_ACTIVE_1920_1080 + H_FP_1920_1080 + H_SYNC_1920_1080 + H_BP_1920_1080;
    parameter V_TOTAL_1920_1080 = V_ACTIVE_1920_1080 + V_FP_1920_1080 + V_SYNC_1920_1080 + V_BP_1920_1080;
    
    reg [11:0]H_ACTIVE=0;   //行有效长度（像素时钟周期个数）
    reg [11:0]H_FP=0;       //行同步前肩长度
    reg [11:0]H_SYNC=0;     //行同步长度
    reg [11:0]H_BP=0;       //行同步后肩长度
    reg [11:0]V_ACTIVE=0;   //场有效长度（行的个数）
    reg [11:0]V_FP=0;       //场同步前肩长度
    reg [11:0]V_SYNC= 0;    //场同步长度
    reg [11:0]V_BP=0;       //场同步后肩长度
    reg [11:0]H_TOTAL=0;    //行总长度
    reg [11:0]V_TOTAL=0;    //场总长度
    
    //行,场信号计数
    reg [11:0]HSync_Cnt=0;
    reg [11:0]VSync_Cnt=0;
    //行,场有效信号
    reg H_De=0;
    reg V_De=0;
    
    //RGB信号连线
    assign RGB_Data=RGB_In;
    //图像X,Y坐标获取
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                begin
                    Set_X<=0;
                    Set_Y<=0;
                end
            else
                begin
                    //行信号有效时,开始获取X坐标
                    if(HSync_Cnt>=H_FP + H_SYNC + H_BP - 1)
                        Set_X <= HSync_Cnt-(H_FP + H_SYNC + H_BP - 1);
                    //场信号有效时,开始获取Y坐标
                    if(VSync_Cnt>=V_FP + V_SYNC + V_BP - 1)
                        Set_Y<=VSync_Cnt-(V_FP + V_SYNC + V_BP - 1);
                end
        end
    //图像格式获取
    always@(*)
        begin
            case(Video_Mode)
                `Video_Mode_1920_1080:
                    begin
                        H_ACTIVE=H_ACTIVE_1920_1080;   //行有效长度（像素时钟周期个数）
                        H_FP=H_FP_1920_1080;           //行同步前肩长度
                        H_SYNC=H_SYNC_1920_1080;       //行同步长度
                        H_BP=H_BP_1920_1080;           //行同步后肩长度
                        V_ACTIVE=V_ACTIVE_1920_1080;   //场有效长度（行的个数）
                        V_FP=V_FP_1920_1080;           //场同步前肩长度
                        V_SYNC=V_SYNC_1920_1080;       //场同步长度
                        V_BP=V_BP_1920_1080;           //场同步后肩长度
                        H_TOTAL=H_TOTAL_1920_1080;     //行总长度
                        V_TOTAL=V_TOTAL_1920_1080;     //场总长度
                    end
                `Video_Mode_1280_720:
                    begin
                        H_ACTIVE=H_ACTIVE_1280_720;    //行有效长度（像素时钟周期个数）
                        H_FP=H_FP_1280_720;            //行同步前肩长度
                        H_SYNC=H_SYNC_1280_720;        //行同步长度
                        H_BP=H_BP_1280_720;            //行同步后肩长度
                        V_ACTIVE=V_ACTIVE_1280_720;    //场有效长度（行的个数）
                        V_FP=V_FP_1280_720;            //场同步前肩长度
                        V_SYNC=V_SYNC_1280_720;        //场同步长度
                        V_BP=V_BP_1280_720;            //场同步后肩长度
                        H_TOTAL=H_TOTAL_1280_720;      //行总长度
                        V_TOTAL=V_TOTAL_1280_720;      //场总长度
                    end
            endcase
        end
    //行计数
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                HSync_Cnt<=0;
            else
                begin
                    //行计数到最大值清零
                    if(HSync_Cnt==H_TOTAL-1)
                        HSync_Cnt<=0;
                    else
                        HSync_Cnt<=HSync_Cnt+1;
                end
        end
    //场计数
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                VSync_Cnt<=0;
            else
                begin
                    //行计数到H_FP-1时,场计数
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //场计数到最大值清零
                            if(VSync_Cnt==V_TOTAL-1)
                                VSync_Cnt<=0;
                            else
                                VSync_Cnt<=VSync_Cnt+1;
                        end
                end
        end
    //行信号有效
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                H_De<=0;
            else
                begin
                    //行计数满足一个周期,行信号开始有效
                    if(HSync_Cnt==H_FP + H_SYNC + H_BP - 1)
                        H_De<=1;
                    //行计数到最大值,行信号开始无效
                    else if(HSync_Cnt==H_TOTAL-1)
                        H_De<=0;                    
                end
        end
    //场信号有效
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                V_De<=0;
            else
                begin
                    //行计数为H_FP-1，即行同步开始时
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //场计数满足一个周期,场信号有效
                            if(VSync_Cnt==V_FP + V_SYNC + V_BP - 1)
                                V_De<=1;
                            //场计数到最大值,场信号开始无效
                            else if(VSync_Cnt==V_TOTAL-1)
                                V_De<=0;
                        end    
                end
        end
    //数据有效信号输出
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                RGB_VDE<=0;
            else
                //数据有效信号输出
                RGB_VDE<=H_De&V_De;                
        end  
    //行信号输出
    always@(posedge clk or negedge Rst)
        begin
            //低电平复位
            if(!Rst)
                RGB_HSync<=0;
            else
                begin
                    //行同步开始时,行信号开始为高
                    if(HSync_Cnt==H_FP-1)
                        RGB_HSync<=1;
                    //行同步结束时,行信号开始为低
                    else if(HSync_Cnt==H_FP + H_SYNC - 1)
                        RGB_HSync<=0;
                end                
        end   
    //场信号输出
    always@(posedge clk or negedge Rst)           
        begin
            //低电平复位
            if(!Rst)
                RGB_VSync<=0;
            else
                begin
                    //行同步开始时
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //场同步开始时,场信号为高
                            if(VSync_Cnt==V_FP-1)
                                RGB_VSync<=1;
                            //场同步结束时,场信号开始为低
                            else if(VSync_Cnt==V_FP + V_SYNC - 1)
                                RGB_VSync<=0;
                        end
                end
        end
endmodule

