`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:50 04/24/2024 
// Design Name: 
// Module Name:    Board_Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//��������߰�������ʼ��ϵͳ
//�������أ�LED�ƻ�ʵʱ��ʾ����ֵ��
//����ߵİ���swb[1]��rst�������º������ʵʱ��ʾ����ֵ��
//����������2������swb[2]���������Ϩ�𣬵���������ܳ�����
//����������3-6������swb[3:6]���κ�һ�����������ʾ��ֵ+1��

module Board_Top(
    input clk,         //ʱ��Դ,20MHz
    //input rst,       //��λ�ź�
    input [31:0] sw,   //����
    input [1:6] swb,    //����
    output [31:0] led,  //LED��
    //����ܵ��ź�
    output enable,          //����ܵ�ʹ���ź�
    output [2:0] which,     //����ܵ�λѡ
    output [7:0] seg        //����ܵĶ�ѡ,��ʾ����
    ); 
    assign led = sw;        // �����������ݣ�ֱ�������LED
    wire rst;  
    assign rst=swb[1];      //ʹ������ߵİ�����Ϊrst���� 
    assign enable=~swb[2];   //ʹ��������2������ȡ������Ϊenable�������������Ϩ��
    //���ֱ��ʹ���������ʾ��ֵ������������ֱ�Ӹ�ֵΪ1��assign enable=1;
    //�����Ҫ�������˸��������������п��ƣ�Ҳ���Խ�enableֱ�Ӵ���Displayģ�飬�����н��п���
       
    // ��rst�����������ʾ���ص�ֵ���������ⰴ�����ұ�4����֮һ�����������+1
    wire toggle;
    assign toggle = |swb[3:6];
    reg [31:0] Data;  
    always @(posedge rst or posedge toggle) 
    begin
      if(rst) Data <= sw;           //�������ʾ���ص�ֵ 
      else    Data <= Data + 1;     //�������ʾ��ֵ+1
    end
    
    Display Display_Instance(
      .clk(clk),
      .rst(rst),
      .data(Data),          //��ʾ����
      .enable(enable),    
      .which(which),
      .seg(seg)
    );

endmodule


