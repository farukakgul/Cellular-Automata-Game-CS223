`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 06:02:26 PM
// Design Name: 
// Module Name: game
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

module game( input logic clk, 
    input logic switch0, switch1, switch2, switch3, switch4, switch5, switch6, switch10, switch11, switch12, switch13, switch14, switch15,
    input logic bttn1, bttn2, bttn3, bttn4, bttnRst,
    output logic [15:0] led,
    output logic [6:0]seg, logic dp, 
    output [3:0] an,
    output logic [7:0] rowsOut,
    output logic shcp, stcp, mr, oe, ds )  ;
    
    logic [15:0] sixteenBit;
    logic [15:0] count;
    logic [15:0] chosenDisplay;
    
   // logic [3:0] anKeep;
        
    logic [63:0] sixtyFourBit;
    logic [63:0] carry;
    logic [15:0] led_tmp;
    logic [63:0] out;
    logic [63:0] outKeep;
    
    logic [7:0][7:0] matrix;
    logic [7:0][7:0] matrixKeep;
    
    logic btn1, btn2, btn3, btn4, btnRst;

    part2           p2( switch13, switch12, switch11,  switch10,  switch5,  clk,  switch0, switch1,  switch2,  switch3,  switch4,  switch14,  switch15,  bttnRst,
                        sixtyFourBit, led_tmp, sixteenBit) ;
             
    gameProcess     gp1( clk,  bttn1, bttn2, bttn3, bttn4, bttnRst, carry,
                        count, out);

    SevSeg_4digit   ss( clk, chosenDisplay[3:0],  chosenDisplay[7:4], chosenDisplay[11:8] ,chosenDisplay[15:12], 
                        seg, dp, an);
    
    arrayCreator    ar( outKeep, clk, 
                        matrix );

    converter       c1( clk, matrixKeep,
                        rowsOut, shcp, stcp, mr, oe, ds );
     
    typedef enum logic [1:0] {S0, S1, S2} statetype;
    statetype [1:0] state, nextstate;

    always @( posedge clk)
    begin
        state <= nextstate;
        case(state)
        S0: 
        begin
            carry <= 64'b0;
            chosenDisplay <= 16'b0;
            outKeep <= 16'b0;
            matrixKeep <= 16'b0;
            nextstate <= S1;
        end
        S1: 
        begin
            carry <= sixtyFourBit;
            chosenDisplay <= sixteenBit;
            led <= led_tmp;
            outKeep <= out;
            matrixKeep <= matrix;
            if( switch6 == 1'b1) nextstate <= S2;
            else nextstate <= S1;
        end

        S2: 
        begin
            carry <= out;
            outKeep <= out;
            chosenDisplay <= count;
            led <= led_tmp;
            matrixKeep <= matrix;
            if( out == 64'b0 && bttn1 == 1'b1 ) nextstate <= S1;
            else if( bttnRst == 1'b1) nextstate <= S0;
            //else if( out == 64'b0 ) nextstate <= S3;
            else nextstate <= S2;
        end
//        S3:
//        begin
            
//            counter <= counter + 1;
//            if( counter > 21'b011110100001001000000 )
//            begin
//                anKeep <= 4'b1;
//            end
//            else if( counter < 21'b011110100001001000000 )
//            begin
//                anKeep <= 4'b1;
//            end
//            if( counter == 21'b111101000010010000000 )          
//            begin
//                counter <= 21'b0;
//            end 
//            else if( bttnRst == 1'b1) nextstate <= S0;
            
//        end
        
        default: nextstate <= S0;
    endcase       
    end
endmodule


