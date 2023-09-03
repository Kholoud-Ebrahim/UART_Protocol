package uart_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import param_pkg::*;

    import tx_pkg::*;
    import rx_pkg::*;
    `include "uart_scoreboard.svh"

    `include "uart_env_config.svh"   
    `include "uart_env.svh"
    
    `include "base_seq.svh"
    `include "uart_test.svh"
           
endpackage