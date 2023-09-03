class uart_tx_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_tx_scoreboard)

    uvm_analysis_imp #(uart_tx_sequence_item, uart_tx_scoreboard) uart_scb_imp;

    uart_tx_sequence_item data_queue[$];
    bit s_data_queue[$:DWIDTH+3];

    // constructor
    function new(string name = "uart_tx_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        
        uart_scb_imp = new("uart_scb_imp", this);
    endfunction :build_phase
    
    function void write (uart_tx_sequence_item item);
        if(item.busy_tx) 
            data_queue.push_front(item);
        else
            $display("idle");
    endfunction :write

    // run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            uart_tx_sequence_item item;
            bit start_bit, parity_bit, parity_bit_expected, stop_bit;
            bit data_q[DWIDTH];
            bit[DWIDTH-1:0] data;
            
            wait(data_queue.size() != 0) begin
                item = data_queue.pop_back();
                s_data_queue.push_front(item.s_data_tx);
                if(item.parity_en_tx) begin
                    if(s_data_queue.size()== DWIDTH+3) begin
                        start_bit = s_data_queue.pop_back();
                        foreach (data_q[i]) begin
                            data_q[DWIDTH-(i+1)] = s_data_queue.pop_back();
                        end
                        parity_bit = s_data_queue.pop_back();
                        stop_bit   = s_data_queue.pop_back();
                        data = {>>{data_q}};

                        $display("start = %0b", start_bit);
                        $display("data = %0b", data);
                        $display("parity = %0b", parity_bit);
                        $display("stop = %0b", stop_bit);
                        
                        if(start_bit == 0)
                            `uvm_info("PASSED START", $sformatf("The start bit = %0b", start_bit), UVM_NONE)
                        else
                            `uvm_error("FAILED START", $sformatf("The start bit = %0b", start_bit))

                        if(item.p_data_tx == data)
                            `uvm_info("PASSED DATA", $sformatf("The data = %8b, p_data_tx = %8b", data, item.p_data_tx), UVM_NONE)
                        else
                            `uvm_error("FAILED DATA", $sformatf("The data = %8b, p_data_tx = %8b", data, item.p_data_tx))
    
                        if(item.parity_type_tx == 0) // even parity
                            parity_bit_expected = ^item.p_data_tx;
                        else
                            parity_bit_expected = ~(^item.p_data_tx);
                        
                        if(parity_bit == parity_bit_expected)
                            `uvm_info("PASSED PARITY", $sformatf("The parity bit = %0b, The expected parity bit = %0b", parity_bit, parity_bit_expected), UVM_NONE)
                        else
                            `uvm_error("FAILED PARITY", $sformatf("The parity bit = %0b, The expected parity bit = %0b", parity_bit, parity_bit_expected))

                        if(stop_bit == 1)
                            `uvm_info("PASSED STOP", $sformatf("The stop bit = %0b", stop_bit), UVM_NONE)
                        else
                            `uvm_error("FAILED STOP", $sformatf("The stop bit = %0b", stop_bit))
    
                    end
                    item.print();
                end

                else begin
                    if(s_data_queue.size()== DWIDTH+2) begin
                        start_bit = s_data_queue.pop_back();
                        foreach (data_q[i]) begin
                            data_q[DWIDTH-(i+1)] = s_data_queue.pop_back();
                        end
                        stop_bit   = s_data_queue.pop_back();
                        data = {>>{data_q}};

                        $display("start = %0b", start_bit);
                        $display("data = %0b", data);
                        $display("stop = %0b", stop_bit);
                        
                        if(start_bit == 0)
                            `uvm_info("PASSED START", $sformatf("The start bit = %0b", start_bit), UVM_NONE)
                        else
                            `uvm_error("FAILED START", $sformatf("The start bit = %0b", start_bit))

                        if(item.p_data_tx == data)
                            `uvm_info("PASSED DATA", $sformatf("The data = %8b, p_data_tx = %8b", data, item.p_data_tx), UVM_NONE)
                        else
                            `uvm_error("FAILED DATA", $sformatf("The data = %8b, p_data_tx = %8b", data, item.p_data_tx))
    
                        if(stop_bit == 1)
                            `uvm_info("PASSED STOP", $sformatf("The stop bit = %0b", stop_bit), UVM_NONE)
                        else
                            `uvm_error("FAILED STOP", $sformatf("The stop bit = %0b", stop_bit))
    
                    end
                    item.print();
                end
            end
        end

    endtask :run_phase
endclass :uart_tx_scoreboard