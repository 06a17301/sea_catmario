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
    input clk,                          //ʱ��
    input Rst,                          //��λ�ź�,�͵�ƽ��λ
    input Video_Mode,                   //��Ƶ��ʽ
    input [23:0]RGB_In,                 //��������
    output [23:0]RGB_Data,              //�������
    output reg RGB_HSync=0,            //���ź�
    output reg RGB_VSync=0,            //���ź�
    output reg RGB_VDE=0,              //������Ч�ź�
    output reg [11:0]Set_X=0,          //ͼ������X
    output reg [11:0]Set_Y=0           //ͼ������Y
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
    
    reg [11:0]H_ACTIVE=0;   //����Ч���ȣ�����ʱ�����ڸ�����
    reg [11:0]H_FP=0;       //��ͬ��ǰ�糤��
    reg [11:0]H_SYNC=0;     //��ͬ������
    reg [11:0]H_BP=0;       //��ͬ����糤��
    reg [11:0]V_ACTIVE=0;   //����Ч���ȣ��еĸ�����
    reg [11:0]V_FP=0;       //��ͬ��ǰ�糤��
    reg [11:0]V_SYNC= 0;    //��ͬ������
    reg [11:0]V_BP=0;       //��ͬ����糤��
    reg [11:0]H_TOTAL=0;    //���ܳ���
    reg [11:0]V_TOTAL=0;    //���ܳ���
    
    //��,���źż���
    reg [11:0]HSync_Cnt=0;
    reg [11:0]VSync_Cnt=0;
    //��,����Ч�ź�
    reg H_De=0;
    reg V_De=0;
    
    //RGB�ź�����
    assign RGB_Data=RGB_In;
    //ͼ��X,Y�����ȡ
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                begin
                    Set_X<=0;
                    Set_Y<=0;
                end
            else
                begin
                    //���ź���Чʱ,��ʼ��ȡX����
                    if(HSync_Cnt>=H_FP + H_SYNC + H_BP - 1)
                        Set_X <= HSync_Cnt-(H_FP + H_SYNC + H_BP - 1);
                    //���ź���Чʱ,��ʼ��ȡY����
                    if(VSync_Cnt>=V_FP + V_SYNC + V_BP - 1)
                        Set_Y<=VSync_Cnt-(V_FP + V_SYNC + V_BP - 1);
                end
        end
    //ͼ���ʽ��ȡ
    always@(*)
        begin
            case(Video_Mode)
                `Video_Mode_1920_1080:
                    begin
                        H_ACTIVE=H_ACTIVE_1920_1080;   //����Ч���ȣ�����ʱ�����ڸ�����
                        H_FP=H_FP_1920_1080;           //��ͬ��ǰ�糤��
                        H_SYNC=H_SYNC_1920_1080;       //��ͬ������
                        H_BP=H_BP_1920_1080;           //��ͬ����糤��
                        V_ACTIVE=V_ACTIVE_1920_1080;   //����Ч���ȣ��еĸ�����
                        V_FP=V_FP_1920_1080;           //��ͬ��ǰ�糤��
                        V_SYNC=V_SYNC_1920_1080;       //��ͬ������
                        V_BP=V_BP_1920_1080;           //��ͬ����糤��
                        H_TOTAL=H_TOTAL_1920_1080;     //���ܳ���
                        V_TOTAL=V_TOTAL_1920_1080;     //���ܳ���
                    end
                `Video_Mode_1280_720:
                    begin
                        H_ACTIVE=H_ACTIVE_1280_720;    //����Ч���ȣ�����ʱ�����ڸ�����
                        H_FP=H_FP_1280_720;            //��ͬ��ǰ�糤��
                        H_SYNC=H_SYNC_1280_720;        //��ͬ������
                        H_BP=H_BP_1280_720;            //��ͬ����糤��
                        V_ACTIVE=V_ACTIVE_1280_720;    //����Ч���ȣ��еĸ�����
                        V_FP=V_FP_1280_720;            //��ͬ��ǰ�糤��
                        V_SYNC=V_SYNC_1280_720;        //��ͬ������
                        V_BP=V_BP_1280_720;            //��ͬ����糤��
                        H_TOTAL=H_TOTAL_1280_720;      //���ܳ���
                        V_TOTAL=V_TOTAL_1280_720;      //���ܳ���
                    end
            endcase
        end
    //�м���
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                HSync_Cnt<=0;
            else
                begin
                    //�м��������ֵ����
                    if(HSync_Cnt==H_TOTAL-1)
                        HSync_Cnt<=0;
                    else
                        HSync_Cnt<=HSync_Cnt+1;
                end
        end
    //������
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                VSync_Cnt<=0;
            else
                begin
                    //�м�����H_FP-1ʱ,������
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //�����������ֵ����
                            if(VSync_Cnt==V_TOTAL-1)
                                VSync_Cnt<=0;
                            else
                                VSync_Cnt<=VSync_Cnt+1;
                        end
                end
        end
    //���ź���Ч
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                H_De<=0;
            else
                begin
                    //�м�������һ������,���źſ�ʼ��Ч
                    if(HSync_Cnt==H_FP + H_SYNC + H_BP - 1)
                        H_De<=1;
                    //�м��������ֵ,���źſ�ʼ��Ч
                    else if(HSync_Cnt==H_TOTAL-1)
                        H_De<=0;                    
                end
        end
    //���ź���Ч
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                V_De<=0;
            else
                begin
                    //�м���ΪH_FP-1������ͬ����ʼʱ
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //����������һ������,���ź���Ч
                            if(VSync_Cnt==V_FP + V_SYNC + V_BP - 1)
                                V_De<=1;
                            //�����������ֵ,���źſ�ʼ��Ч
                            else if(VSync_Cnt==V_TOTAL-1)
                                V_De<=0;
                        end    
                end
        end
    //������Ч�ź����
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                RGB_VDE<=0;
            else
                //������Ч�ź����
                RGB_VDE<=H_De&V_De;                
        end  
    //���ź����
    always@(posedge clk or negedge Rst)
        begin
            //�͵�ƽ��λ
            if(!Rst)
                RGB_HSync<=0;
            else
                begin
                    //��ͬ����ʼʱ,���źſ�ʼΪ��
                    if(HSync_Cnt==H_FP-1)
                        RGB_HSync<=1;
                    //��ͬ������ʱ,���źſ�ʼΪ��
                    else if(HSync_Cnt==H_FP + H_SYNC - 1)
                        RGB_HSync<=0;
                end                
        end   
    //���ź����
    always@(posedge clk or negedge Rst)           
        begin
            //�͵�ƽ��λ
            if(!Rst)
                RGB_VSync<=0;
            else
                begin
                    //��ͬ����ʼʱ
                    if(HSync_Cnt==H_FP-1)
                        begin
                            //��ͬ����ʼʱ,���ź�Ϊ��
                            if(VSync_Cnt==V_FP-1)
                                RGB_VSync<=1;
                            //��ͬ������ʱ,���źſ�ʼΪ��
                            else if(VSync_Cnt==V_FP + V_SYNC - 1)
                                RGB_VSync<=0;
                        end
                end
        end
endmodule

