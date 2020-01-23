`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2019 03:09:37 AM
// Design Name: 
// Module Name: clockDivider
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


module timer( input logic clk, input logic reset, 
                output logic clk_out);
    logic [20:0] counter = 21'b0;
    
    always@( posedge clk)
    begin
        counter <= counter + 1;
        clk_out <= ( counter == 21'd2000000);
        if( counter == 21'b111101000010010000000 || reset) counter <= 21'b0;
    end

endmodule

module CounterMaster( input logic clk2, input logic reset2,
                      output logic clk3_out );
                      
    logic clk2_out;                  
    timer timer1( clk2, reset2, clk2_out);
    logic [5:0] counter2 = 6'b0;
      
    always@( posedge clk2_out)
    begin
        counter2 <= counter2 + 1;
        clk3_out <= ( counter2 == 6'b110010);
        if( counter2 == 6'b110010 || reset2) counter2 <= 6'b0;
    end
endmodule
