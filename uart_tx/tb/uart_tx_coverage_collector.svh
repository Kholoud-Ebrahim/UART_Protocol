/*###################################################################*\
##              Class Name:   uart_tx_coverage_collector             ##
##              Project Name: uart_tx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

class uart_tx_coverage_collector extends uvm_subscriber #(uart_tx_sequence_item);
    `uvm_component_utils(uart_tx_coverage_collector)

    uvm_analysis_imp #(uart_tx_sequence_item, uart_tx_coverage_collector) uart_cov_imp;

    uart_tx_sequence_item uart_item;
    uart_tx_sequence_item uart_queue[$];

    covergroup cov_group_1;
        option.per_instance = 1; 

        cov_data_valid : coverpoint uart_item.data_valid_tx {
            bins data_valid[]   = {1'b1}; 
        }

        cov_parity_en : coverpoint uart_item.parity_en_tx {
            bins parity_en_1_0[] = (1'b1 => 1'b0);
            bins parity_en_0_1[] = (1'b0 => 1'b1);
        }

        cov_parity_type : coverpoint uart_item.parity_type_tx {
            bins parity_type_1_0[] = (1'b1 => 1'b0);
            bins parity_type_0_1[] = (1'b0 => 1'b1);
        }

    endgroup :cov_group_1

    // constructor
    function new(string name = "uart_tx_coverage_collector", uvm_component parent);
        super.new(name, parent);

        cov_group_1 = new();
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        uart_cov_imp = new("uart_cov_imp", this);
    endfunction :build_phase

    function void write (uart_tx_sequence_item t);
        uart_queue.push_front(t);
    endfunction :write

    //run phase
	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
        forever begin
            uart_item = uart_tx_sequence_item::type_id::create("uart_item");
          wait(uart_queue.size!=0);
          uart_item  = uart_queue.pop_back();
          cov_group_1.sample();  
        end 
    endtask :run_phase
endclass :uart_tx_coverage_collector