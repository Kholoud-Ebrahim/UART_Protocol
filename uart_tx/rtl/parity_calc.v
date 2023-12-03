/*###################################################################*\
##              Module Name:  parity_calc                            ##
##              Project Name: uart_protocl                           ##
##              Date:   28/11/2023                                   ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module parity_calc #(parameter DWIDTH = 8)(clk, rst, data, parity_type, parity_bit);
    input clk, rst;
    input [DWIDTH-1:0]data;
    input parity_type;
    output reg parity_bit;
    
    wire even_parity;
    
    localparam EVEN =0, ODD =1;
        
    assign even_parity = ^data;
    
    always @(posedge clk, negedge rst) begin
        if(!rst) // active low asynch rst
            parity_bit <= 1'b0;
        else begin
            case(parity_type) 
                EVEN:    parity_bit <=  even_parity;
                ODD :    parity_bit <= ~even_parity;
                default: parity_bit <= 1'b0;
            endcase
        end
    end
endmodule
    
/*
module parity_test;
    reg clk, rst;
    reg [7:0]data;
    reg parity_type;
    wire parity_bit;
    
    parity_calc #(8)dut(clk, rst, data, parity_type, parity_bit);
    
    initial begin
        clk = 0; 
        forever begin
            #5ns;  clk = ~clk;
        end
    end
    initial begin
        rst = 0; #25ns; rst = 1;
        parity_type = 1; //odd
        data = 8'b1100_1001;  //1
        #20ns;
        data = 8'b1100_1000; //0
        #40ns;
        parity_type = 0; //even
        data = 8'b1100_1000;  //1
        #20ns;
        data = 8'b1100_1001; //0
        #40ns;
        $finish;
    end
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end   
endmodule
*/
