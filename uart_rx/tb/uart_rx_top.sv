`timescale 1ns/100ps
// 200 MHz clk frequency == 5 ns clk time period 

module uart_rx_top;
    parameter DWIDTH =8, PWIDTH =6;
    parameter SCALE = 8;
    parameter PERIOD = 5;

    bit clk, rst;
    bit data_q[$:DWIDTH];
    bit parity_bit_tb;
    uart_rx_intf #(DWIDTH, PWIDTH)rx_if (.clk(clk), .rst(rst));
    uart_rx #(DWIDTH, PWIDTH)rtl (
        .clk(clk),
        .rst(rst),
        .s_data(rx_if.s_data_rx), 
        .parity_type(rx_if.parity_type_rx), 
        .parity_en(rx_if.parity_en_rx), 
        .prescale(rx_if.prescale_rx), 
        .p_data(rx_if.p_data_rx), 
        .data_valid(rx_if.data_valid_rx)
    );

    initial begin
        clk = 1;
        forever begin
            #(PERIOD/2.0)  clk = ~clk;
        end
    end

    initial begin
        rst = 0; 
        repeat(3) @(posedge clk);
        rst = 1;
        // no parity
        @(posedge clk)begin
            rx_if.prescale_rx = SCALE;
            rx_if.parity_en_rx = 0;
            rx_if.parity_type_rx = 0; 
            rx_if.s_data_rx = 0; 
            repeat(SCALE)@(posedge clk);   
            repeat(DWIDTH) begin
                rx_if.s_data_rx = $random();
                repeat(SCALE)@(posedge clk);
            end
            repeat(2) begin
                rx_if.s_data_rx = 1;
                repeat(SCALE)@(posedge clk);
            end
            repeat(2)@(posedge clk);
            if (rx_if.data_valid_rx == 1) begin
                $display("@%6t: PASS NO Partity Bit Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            else begin
                $error("@%6t: FAIL NO Partity Bit Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            repeat(SCALE) @(posedge clk);
        end
        $display("-----------------------------------------------------");
        // even parity
        @(posedge clk)begin
            rx_if.prescale_rx = SCALE;
            rx_if.parity_en_rx = 1;
            rx_if.parity_type_rx = 0; 
            rx_if.s_data_rx = 0; 
            repeat(SCALE)@(posedge clk);   
            repeat(DWIDTH) begin
                rx_if.s_data_rx = $random();
                data_q.push_front(rx_if.s_data_rx);
                repeat(SCALE)@(posedge clk);
            end

            rx_if.s_data_rx = parity_bit_tb;
            @(posedge clk);

            repeat(2) begin
                rx_if.s_data_rx = 1;
                repeat(SCALE)@(posedge clk);
            end
            repeat(1)@(posedge clk);
            if (rx_if.data_valid_rx == 1) begin
                $display("@%6t: PASS Even Partity Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            else begin
                $error("@%6t: FAIL Even Partity Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            data_q.delete();
            repeat(SCALE) @(posedge clk);
        end
        $display("-----------------------------------------------------");
        // odd parity
        @(posedge clk)begin
            rx_if.prescale_rx = SCALE;
            rx_if.parity_en_rx = 1;
            rx_if.parity_type_rx = 1; 
            rx_if.s_data_rx = 0; 
            repeat(SCALE)@(posedge clk);   
            repeat(DWIDTH) begin
                rx_if.s_data_rx = $random();
                data_q.push_front(rx_if.s_data_rx);
                repeat(SCALE)@(posedge clk);
            end

            rx_if.s_data_rx = parity_bit_tb;
            @(posedge clk);

            repeat(2) begin
                rx_if.s_data_rx = 1;
                repeat(SCALE)@(posedge clk);
            end
            repeat(1)@(posedge clk);
            if (rx_if.data_valid_rx == 1) begin
                $display("@%6t: PASS Odd Partity Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            else begin
                $error("@%6t: FAIL Odd Partity Check, The valid data = %0b", $time, rx_if.data_valid_rx);
            end
            data_q.delete();
            repeat(SCALE) @(posedge clk);
        end
        $display("-----------------------------------------------------");
        $finish;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end
endmodule :uart_rx_top
