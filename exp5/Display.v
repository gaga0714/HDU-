`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:41 05/15/2024 
// Design Name: 
// Module Name:    Display 
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
// 8λ �߶������ɨ����ʾģ��
module Display(
    input clk,                  //ʱ��Դ20MHz
    input rst,                  //��λ�ź�
    input [31:0] data,          //32λ����ʾ����
    output enable,              //�������ʾʹ�ܣ�=1��ĳ����whichָ��������ܵ�����=0��ȫ��
    output reg [2:0] which,     //Ƭѡ���루������һλ����ܵ�����
    output reg [7:0] seg        // ��ѡ�źţ�������Щ�Σ�����ʾ���Σ�
    );
    
    reg [14:0] count = 0;       // ��Ƶɨ�裬��������ѭ������ÿһλ�����
    always @(posedge rst  or posedge clk) 
    begin
      if(rst)   count <= 0;
      else      count <= count + 1'b1;
    end
    
    always @(posedge rst  or posedge count[14]) 
    begin
      if(rst)   which <= 0; 
      else  which <= which + 1'b1;
    end
      
    reg [3:0] digit; // ѡ��ǰ����������ܶ�Ӧ��ʾ������
    always @* case (which)
        0: digit = data[31:28]; // ���λ�����
        1: digit = data[27:24];
        2: digit = data[23:20];
        3: digit = data[19:16];
        4: digit = data[15:12];
        5: digit = data[11:8];
        6: digit = data[7:4];
        7: digit = data[3:0]; // ���λ�����
    endcase

    always @* case (digit) // ���ݵ�ǰҪ��ʾ�����֣���������ܵĶ�Ӧ�Σ���ʾ����
        4'h0: seg = 8'b0000_0011; // ��g��dp��ȫ������ʾ����0
        4'h1: seg = 8'b1001_1111; // ��b��c������ʾ����1
        4'h2: seg = 8'b0010_0101;
        4'h3: seg = 8'b0000_1101;
        4'h4: seg = 8'b1001_1001;
        4'h5: seg = 8'b0100_1001;
        4'h6: seg = 8'b0100_0001;
        4'h7: seg = 8'b0001_1111;
        4'h8: seg = 8'b0000_0001;
        4'h9: seg = 8'b0000_1001;
        4'hA: seg = 8'b0001_0001;
        4'hB: seg = 8'b1100_0001;
        4'hC: seg = 8'b0110_0011;
        4'hD: seg = 8'b1000_0101;
        4'hE: seg = 8'b0110_0001;
        4'hF: seg = 8'b0111_0001;
    endcase

endmodule // Display

