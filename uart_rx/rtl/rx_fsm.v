/*###################################################################*\
##              Module Name:  rx_fsm                                 ##
##              Project Name: uart_rx_protocl                        ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module rx_fsm #(parameter PWIDTH =6)(clk, rst, prescale, edge_counter, bit_counter, rx_in, parity_en, stop_error, start_error, parity_error, data_sampling_en, deser_en, start_check_en, stop_check_en, parity_check_en, enable, data_valid);
    input clk, rst;
    input [PWIDTH-1:0]prescale, edge_counter;
    input [PWIDTH-2:0]bit_counter;
    input rx_in, parity_en;
    input stop_error, start_error, parity_error;
    
    output reg data_sampling_en, deser_en;
    output reg start_check_en, stop_check_en, parity_check_en;
    output reg enable, data_valid;
    
    reg [2:0] current_state, next_state;
    
    localparam IDLE =0, START =1, DATA =2, PARITY =3, STOP =4, CERROR =5, DVALID =6;
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            current_state <= IDLE;
        else 
            current_state <= next_state;   
    end
    
    always @(*) begin
        case (current_state) 
            IDLE: begin
                if(!rx_in) begin
                    data_sampling_en = 1;
                    enable           = 1;
                    deser_en         = 0;
                    data_valid       = 0;
                    stop_check_en    = 0;
                    start_check_en   = 1;
                    parity_check_en  = 0;
    
                    next_state = START;
                end
                else begin
                    data_sampling_en = 0;
                    enable           = 0;
                    deser_en         = 0;
                    data_valid       = 0;
                    stop_check_en    = 0;
                    start_check_en   = 0;
                    parity_check_en  = 0;
    
                    next_state = IDLE;
                end
            end
    
            START: begin
                data_sampling_en = 1;
                enable           = 1;
                deser_en         = 0;
                data_valid       = 0;
                stop_check_en    = 0;
                start_check_en   = 1;
                parity_check_en  = 0;
                            
                if((bit_counter ==0) && (edge_counter == prescale-1)) begin
                    if(!start_error) begin  
                        next_state = DATA;
                    end
                    else begin
                        next_state = IDLE;       
                    end              
                end
                else begin
                    next_state = START; 	
                end
            end
    
            DATA: begin
                data_sampling_en = 1;
                enable           = 1;
                deser_en         = 1;
                data_valid       = 0;
                stop_check_en    = 0;
                start_check_en   = 0;
                parity_check_en  = 0;
                            
                if((bit_counter ==8) && (edge_counter == prescale-1)) begin
                    if(parity_en) begin
                        next_state = PARITY;
                    end
                    else begin  
                        next_state = STOP;
                    end
                end
                else begin
                        next_state = DATA;
                end
            end
    
            PARITY: begin
                data_sampling_en = 1;
                enable           = 1;
                deser_en         = 0;
                data_valid       = 0;
                stop_check_en    = 0;
                start_check_en   = 0;
                parity_check_en  = 1;
                            
                if((bit_counter ==9) && (edge_counter == prescale-1)) begin        
                    next_state = STOP;
                end
                else begin
                    next_state = PARITY;
                end
            end
    
            STOP: begin
                data_sampling_en = 1;
                enable           = 1;
                deser_en         = 0;
                data_valid       = 0;
                stop_check_en    = 1;
                start_check_en   = 0;
                parity_check_en  = 0;
                            
                if((bit_counter ==10) && (edge_counter == prescale-1)) begin        
                    next_state = CERROR;
                end
                else begin
                    next_state = STOP;
                end
            end
    
            CERROR: begin
                data_sampling_en = 1;
                enable           = 0;
                deser_en         = 0;
                data_valid       = 0;
                stop_check_en    = 0;
                start_check_en   = 0;
                parity_check_en  = 0;                        
    
                if(parity_error || stop_error) begin        
                    next_state = IDLE; 
                end
                else begin            
                    next_state = DVALID;
                end 	
            end
    
            DVALID: begin
                data_sampling_en = 0;
                enable           = 0;
                deser_en         = 0;
                data_valid       = 1;
                stop_check_en    = 0;
                start_check_en   = 0;
                parity_check_en  = 0;
                            
                if(!rx_in) begin
                    next_state = START; 
                end
                else begin
                    next_state = IDLE;
                end 
            end
    
            default: begin
                data_sampling_en = 0;
                enable           = 0;
                deser_en         = 0;
                data_valid       = 0;
                stop_check_en    = 0;
                start_check_en   = 0;
                parity_check_en  = 0;
                            
                next_state = IDLE; 
            end
        endcase
    end
endmodule