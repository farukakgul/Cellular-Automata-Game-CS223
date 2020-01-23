`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 01:22:20 PM
// Design Name: 
// Module Name: part_a
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
module part1( input logic switch0, switch1, switch2, switch3, switch4, switch14, switch15, clock, reset,
              output logic [15:0] hexaNumber);
    
    always_ff@( posedge clock)
    begin
        if( reset == 1'b1 && switch4 == 1'b1)
        begin
            hexaNumber <= 16'b0;
        end
              
        else if( switch15 == 1'b0 && switch14 == 1'b0 && switch4 == 1'b1)
        begin
            hexaNumber[0] <= switch0;
            hexaNumber[1] <= switch1;
            hexaNumber[2] <= switch2;
            hexaNumber[3] <= switch3;
        end
        
        else if( switch15 == 1'b0 && switch14 == 1'b1 && switch4 == 1'b1)   
        begin
            hexaNumber[4] <= switch0;
            hexaNumber[5] <= switch1;
            hexaNumber[6] <= switch2;
            hexaNumber[7] <= switch3;
        end
        
        else if( switch15 == 1'b1 && switch14 == 1'b0 && switch4 == 1'b1)   
        begin
            hexaNumber[8] <= switch0;
            hexaNumber[9] <= switch1;
            hexaNumber[10] <= switch2;
            hexaNumber[11] <= switch3;     
        end
          
        else if( switch15 == 1'b1 && switch14 == 1'b1 && switch4 == 1'b1)   
        begin
            hexaNumber[12] <= switch0;
            hexaNumber[13] <= switch1;
            hexaNumber[14] <= switch2;
            hexaNumber[15] <= switch3;     
        end      
        else
        begin
        end                   
    end  
endmodule          