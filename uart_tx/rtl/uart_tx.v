/*###################################################################*\
##              Module Name:  uart_tx                                ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module uart_tx #(parameter DWIDTH = 8)(clk, rst, p_data, data_valid, parity_en, parity_type, s_data, busy);
    input [DWIDTH-1:0]p_data;
    input data_valid, parity_en, parity_type;
    input clk, rst;
    output s_data, busy;

    wire parity_bit, ser_en, ser_done, ser_data;
    wire [2:0] mux_sel;

    parity_calc #(DWIDTH) par_c(
            .clk(clk), 
            .rst(rst), 
            .data(p_data),
            .parity_type(parity_type), 
            .parity_bit(parity_bit)
    );

    serializer #(DWIDTH) ser(
            .clk(clk), 
            .rst(rst), 
            .p_data(p_data), 
            .ser_en(ser_en), 
            .s_data(ser_data), 
            .ser_done(ser_done)
    );

    tx_fsm fsm(
            .clk(clk), 
            .rst(rst), 
            .valid_data(data_valid), 
            .parity_en(parity_en), 
            .ser_done(ser_done), 
            .ser_en(ser_en), 
            .mux_sel(mux_sel), 
            .busy(busy)
    );

    mux m(
            .clk(clk), 
            .rst(rst), 
            .mux_sel(mux_sel), 
            .start_bit(1'b0), 
            .ser_data(ser_data), 
            .parity_bit(parity_bit), 
            .stop_bit(1'b1),
            .tx_out(s_data)
    );

endmodule
