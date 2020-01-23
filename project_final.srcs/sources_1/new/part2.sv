`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 06:03:47 PM
// Design Name: 
// Module Name: part2
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


module part2( input logic switch13, switch12, switch11, switch10, switch5, clk,
              input logic switch0, switch1, switch2, switch3, switch4, switch14, switch15, reset,
              output logic [63:0] sixtyFourBit,
              output logic [15:0] led,
              output logic [15:0] sixteenBit1
              );
    
    part1 p1( switch0, switch1, switch2, switch3, switch4, switch14, switch15, clk, reset, sixteenBit1) ;   
          
    always@( posedge clk)       
    begin
        if( switch13 == 1'b0 && switch12 == 1'b0 && switch5 == 1'b1)
        begin
            sixtyFourBit[ 63:48] <= sixteenBit1;
        end
        
        else if( switch13 == 1'b0 && switch12 == 1'b1 && switch5 == 1'b1)
        begin
            sixtyFourBit[ 47:32] <= sixteenBit1;
        end  
          
        else if( switch13 == 1'b1 && switch12 == 1'b0 && switch5 == 1'b1)
        begin
            sixtyFourBit[ 31:16] <= sixteenBit1;
        end 
          
        else if( switch13 == 1'b1 && switch12 == 1'b1 && switch5 == 1'b1)
        begin
            sixtyFourBit[ 15:0] <= sixteenBit1;
        end
        else
        begin
        end 
    end   
          
    always@( posedge clk)       
    begin
        if( switch11 == 1'b0 && switch10 == 1'b0)
        begin
            led <= sixtyFourBit[63: 48];
        end  
          
        else if( switch11 == 1'b0 && switch10 == 1'b1)
        begin
            led <= sixtyFourBit[47: 32];
        end  
        
        else if( switch11 == 1'b1 && switch10 == 1'b0)
        begin
            led <= sixtyFourBit[31: 16];
        end  
        
        else if( switch11 == 1'b1 && switch10 == 1'b1)
        begin
            led <= sixtyFourBit[15: 0];
        end
        else
        begin
        end
          
    end   
          
endmodule 