`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 06:01:24 PM
// Design Name: 
// Module Name: gameProcess
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



module gameProcess( input logic clk, btn1, btn2, btn3, btn4, bttnRst,
                    input logic [63:0] bus,
                    output logic [15:0] count,
                    output logic [63:0] out);
 
    logic [63:0] internal;
    int locations[63:0];
    logic cs;
    typedef enum logic [1:0] {S0, S1, S2} statetype;
    statetype [1:0] state, nextstate;

    initial begin 
        internal = 64'b0;
        count = 16'b0;
        locations = '{ 3'b010, 3'b001, 3'b010, 3'b001, 3'b100, 3'b011, 3'b100, 3'b011,
					   3'b100, 3'b011, 3'b100, 3'b011, 3'b001, 3'b010, 3'b001, 3'b010,
					   3'b010, 3'b001, 3'b010, 3'b001, 3'b100, 3'b011, 3'b100, 3'b011,
					   3'b100, 3'b011, 3'b100, 3'b011, 3'b001, 3'b010, 3'b001, 3'b010,
					   3'b100, 3'b011, 3'b100, 3'b011, 3'b011, 3'b010, 3'b011, 3'b010,
					   3'b001, 3'b010, 3'b001, 3'b010, 3'b100, 3'b001, 3'b100, 3'b001, 
					   3'b100, 3'b011, 3'b100, 3'b011, 3'b011, 3'b010, 3'b011, 3'b010,
					   3'b001, 3'b010, 3'b001, 3'b010, 3'b100, 3'b001, 3'b100, 3'b001
					   };
        
    end

    always @( posedge clk) 
    begin 
        logic left, up, right, down;
        state <= nextstate;
        case(state)
        S0:
        begin
            if(btn1 || btn2 || btn3 || btn4 )
            begin
                nextstate <= S1;
            end
        end
        S1:
        begin
            count <= count + 1;
            if(btn1 || btn2 || btn3 || btn4 )
            begin
                nextstate <= S2;
            end
        end
        S2:
        begin
        if(btn1 || btn2 || btn3 || btn4 )
            begin
                nextstate <= S2;
            end
        else 
            begin
                nextstate <= S0;
            end
        end
        endcase
        if( bttnRst )
        begin
            count <= 16'b0;
        end
        internal <= bus;
        if( state == S1 && btn1)
        begin
            for( int i = 0; i < 64; i ++)
            begin
                if( locations[i] == 3'b001)
                begin
                    if( i % 8 == 0)
                    begin
                        left <= bus[i + 7];
                        right <= bus[i + 1];
                    end
                    else if( i % 8 == 7 )
                    begin
                        left <= bus[i-1];
                        right <= bus[i-7];
                    end  
                    else
                    begin  
                        left <= bus[i-1]; 
                        right <= bus[i+1];
                    end
                    if( i < 8)
                    begin
                        up <= bus[ i + 56];
                        down <= bus[ i + 8];
                    end
                    else if( i > 55)
                    begin
                        up <= bus[i - 8];
                        down <= bus[ i - 56];
                    end
                    else
                    begin 
                        up <= bus[i - 8];
                        down <= bus[i + 8];
                    end
                    if( left == 1 && up == 1 && right == 1 && down == 0 )
                    begin
                        internal[i] <= 1;
                    end
            
                    else if( left == 1 && up == 1 && right == 0 && down == 0 )
                    begin
                        internal[i]  <= 1;
                    end
            
                    else if( left == 0 && up == 1 && right == 0 && down == 1 )
                    begin
                        internal[i]  <= 1;
                    end
                    
            
                    else if( left == 0 && up == 1 && right == 0 && down == 0 )
                    begin
                        internal[i]  <= 1;
                    end
                    
                    else if( left == 1 && up == 0 && right == 1 && down == 1 )
                    begin
                        internal[i]  <= 1;
                    end
                    
            
                    else if( left == 1 && up == 0 && right == 1 && down == 0 )
                    begin
                        internal[i]  <= 1;
                    end

            
                    else if( left == 1 && up == 0 && right == 0 && down == 1 )
                    begin
                        internal[i]  <= 1;
                    end

                    else if( left == 1 && up == 0 && right == 0 && down == 0 )
                    begin
                        internal[i]  <= 1;
                    end

            
                    else if( left == 0 && up == 0 && right == 1 && down == 0 )
                    begin
                        internal[i]  <= 1;
                    end
                    
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
            
                    else 
                    begin
                    end
                end
                else
                begin
                end
            end
        end
    
        else if( state == S1 && btn2)
        begin
            count <= count + 1;
            for( int i = 0; i < 64; i ++)
            begin
                if( locations[i] == 3'b010)
                begin
                    if( i % 8 == 1'b0)
                    begin
                        left <= bus[i + 7];
                        right <= bus[i + 1];
                    end
                    else if( i % 8 == 3'b111 )
                    begin
                        left <= bus[i-1];
                        right <= bus[i-7];
                    end  
                    else
                    begin  
                        left <= bus[i-1]; 
                        right <= bus[i+1];
                    end
                    if( i < 8)
                    begin
                        up <= bus[ i + 56];
                        down <= bus[ i + 8];
                    end
                    else if( i > 55)
                    begin
                        up <= bus[i - 8];
                        down <= bus[ i - 56];
                    end
                    else
                    begin 
                        up <= bus[i - 8];
                        down <= bus[i + 8];
                    end
                    if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i] <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
            
                    else 
                    begin
                    end
                end
                else
                begin
                end
            end
        end
    
        else if(state == S1 && btn3)
        begin  
            count <= count + 1;
            for( int i = 0; i < 64; i ++)
            begin
                if( locations[i] == 3'b011)
                begin
                    if( i % 8 == 1'b0)
                    begin
                        left <= bus[i + 7];
                        right <= bus[i + 1];
                    end
                    else if( i % 8 == 3'b111 )
                    begin
                        left <= bus[i-1];
                        right <= bus[i-7];
                    end  
                    else
                    begin  
                        left <= bus[i-1]; 
                        right <= bus[i+1];
                    end
                    if( i < 8)
                    begin
                        up <= bus[ i + 56];
                        down <= bus[ i + 8];
                    end
                    else if( i > 55)
                    begin
                        up <= bus[i - 8];
                        down <= bus[ i - 56];
                    end
                    else
                    begin 
                        up <= bus[i - 8];
                        down <= bus[i + 8];
                    end
                    if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i] <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else 
                    begin
                    end
                end
                else
                begin
                end
            end
        end
    
        else if( state == S1 && btn4)
        begin  
            count <= count + 1;
            for( int i = 0; i < 64; i ++)
            begin
                if( locations[i] == 3'b100)
                begin
                    if( i % 8 == 1'b0)
                    begin
                        left <= bus[i + 7];
                        right <= bus[i + 1];
                    end
                    else if( i % 8 == 3'b111 )
                    begin
                        left <= bus[i-1];
                        right <= bus[i-7];
                    end  
                    else
                    begin  
                        left <= bus[i-1]; 
                        right <= bus[i+1];
                    end
                    if( i < 8)
                    begin
                        up <= bus[ i + 56];
                        down <= bus[ i + 8];
                    end
                    else if( i > 55)
                    begin
                        up <= bus[i - 8];
                        down <= bus[ i - 56];
                    end
                    else
                    begin 
                        up <= bus[i - 8];
                        down <= bus[i + 8];
                    end
                    if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i] <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b1 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b1;
                    end
            
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b1;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b1 && up == 1'b1 && right == 1'b0 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b1 && right == 1'b1 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b1 && down == 1'b1 )
                    begin
                        internal[i]  <= 1'b0;
                    end
                    
                    else if( left == 1'b0 && up == 1'b0 && right == 1'b0 && down == 1'b0 )
                    begin
                        internal[i]  <= 1'b0;
                    end
            
                    else 
                    begin
                    end
                end
                else
                begin
                end
            end
        end
        out <= internal;
        
    end 
endmodule