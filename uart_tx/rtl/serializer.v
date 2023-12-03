/*###################################################################*\
##              Module Name:  serializer                             ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module serializer #(parameter DWIDTH =8)(clk, rst, p_data, ser_en, s_data, ser_done);
    input clk, rst;
    input [DWIDTH-1:0]p_data;
    input ser_en;
    output reg s_data, ser_done;
    
    integer check_done;
    
    always @(posedge clk, negedge rst) begin
           
        if(!rst) begin
            s_data     <= 1'b1;
            ser_done   <= 1'b0;
            check_done <= 0;
        end
        else begin
            if (ser_en) begin
                if (check_done == DWIDTH-1) begin
                    s_data     <= p_data[check_done];
                    ser_done   <= 1'b1;
                    check_done <= 0;
                end
                else begin
                    s_data     <= p_data[check_done];
                    ser_done   <= 1'b0;
                    check_done <= check_done+1;
                end
            end
            else begin
                s_data   <= 1'b1;
                ser_done <= 1'b0;
            end
        end
    end
endmodule    
    
/*
module ser_test;
    reg clk, rst;
    reg [7:0]p_data;
    reg ser_en;
    wire s_data, ser_done;
    
    serializer #(8)dut(clk, rst, p_data, ser_en, s_data, ser_done);
    
    initial begin
        clk = 0; 
        forever begin
            #5ns;  clk = ~clk;
        end
    end
    initial begin
        rst = 0; #25ns; rst = 1;
        ser_en = 0; 
        #10ns; ser_en = 1;
        p_data = 8'b1011_0010;
        #80ns;
        ser_en = 0; 
        #10ns; ser_en = 1;
        p_data = 8'b1000_0011;
        #80ns;
        ser_en = 0;
        #40ns;
        $finish;
    end
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end
endmodule
*/
