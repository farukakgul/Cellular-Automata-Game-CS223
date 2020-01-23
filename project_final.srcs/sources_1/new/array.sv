`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 06:00:33 PM
// Design Name: 
// Module Name: arrayCreator
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


module arrayCreator( input logic [63:0] array,
                     input logic clk,
                     output logic [7:0][7:0] out);
                     
    always@( posedge clk)                 
    begin 
        out[0][0] <= array[0];
        out[0][1] <= array[1];
        out[0][2] <= array[2];
        out[0][3] <= array[3];
        out[0][4] <= array[4];
        out[0][5] <= array[5];
        out[0][6] <= array[6];
        out[0][7] <= array[7];
        out[1][0] <= array[8];
        out[1][1] <= array[9];
        out[1][2] <= array[10];
        out[1][3] <= array[11];
        out[1][4] <= array[12];
        out[1][5] <= array[13];
        out[1][6] <= array[14];
        out[1][7] <= array[15];
        out[2][0] <= array[16];
        out[2][1] <= array[17];
        out[2][2] <= array[18];
        out[2][3] <= array[19];
        out[2][4] <= array[20];
        out[2][5] <= array[21];
        out[2][6] <= array[22];
        out[2][7] <= array[23];
        out[3][0] <= array[24];
        out[3][1] <= array[25];
        out[3][2] <= array[26];
        out[3][3] <= array[27];
        out[3][4] <= array[28];
        out[3][5] <= array[29];
        out[3][6] <= array[30];
        out[3][7] <= array[31];
        out[4][0] <= array[32];
        out[4][1] <= array[33];
        out[4][2] <= array[34];
        out[4][3] <= array[35];
        out[4][4] <= array[36];
        out[4][5] <= array[37];
        out[4][6] <= array[38];
        out[4][7] <= array[39];
        out[5][0] <= array[40];
        out[5][1] <= array[41];
        out[5][2] <= array[42];
        out[5][3] <= array[43];
        out[5][4] <= array[44];
        out[5][5] <= array[45];
        out[5][6] <= array[46];
        out[5][7] <= array[47];
        out[6][0] <= array[48];
        out[6][1] <= array[49];
        out[6][2] <= array[50];
        out[6][3] <= array[51];
        out[6][4] <= array[52];
        out[6][5] <= array[53];
        out[6][6] <= array[54];
        out[6][7] <= array[55];
        out[7][0] <= array[56];
        out[7][1] <= array[57];
        out[7][2] <= array[58];
        out[7][3] <= array[59];
        out[7][4] <= array[60];
        out[7][5] <= array[61];
        out[7][6] <= array[62];
        out[7][7] <= array[63];
            
    end
endmodule