/*###################################################################*\
##              Module Name:  mux                                    ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module mux (clk, rst, mux_sel, start_bit, ser_data, parity_bit, stop_bit, tx_out);
    input clk, rst;
    input [2:0] mux_sel;
    input start_bit, ser_data, parity_bit, stop_bit;
    output reg tx_out;
    
    localparam IDLE_BIT =0, START_BIT =1, SER_DATA =2, PARITY_BIT =3, STOP_BIT =4; 
    
    always @(posedge clk, negedge rst) begin
        if(!rst)
            tx_out <= 1'b1;  
                
        else begin
            case (mux_sel)
                IDLE_BIT:   tx_out <= 1'b1;
                START_BIT:  tx_out <= start_bit;
                SER_DATA:   tx_out <= ser_data;
                PARITY_BIT: tx_out <= parity_bit;
                STOP_BIT:   tx_out <= stop_bit;
                default:    tx_out <= 1'b1;
            endcase
        end
    end
endmodule
