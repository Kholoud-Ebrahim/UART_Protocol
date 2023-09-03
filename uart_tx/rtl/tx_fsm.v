module tx_fsm (clk, rst, valid_data, parity_en, ser_done, ser_en, mux_sel, busy);
    input clk, rst;
    input valid_data, parity_en, ser_done;
    output reg ser_en, busy;
    output reg [2:0] mux_sel;
    
    reg [2:0] current_state, next_state;
    reg busy_reg;
    
    localparam IDLE =0, START =1, DATA =2, PARITY =3, STOP =4; 
    
    always @(posedge clk, negedge rst) begin
        if(!rst) begin
            current_state <= IDLE;
            busy <= 1'b0;
        end
        else begin
            current_state <= next_state;
            busy <= busy_reg;
        end
    end
    
    always @(*) begin
        case(current_state)
            IDLE: begin
                ser_en  = 1'b0;
                mux_sel = 3'b000;
                busy_reg    = 1'b0;
                    
                if (valid_data) 
                    next_state = START;
 
                else 
                    next_state = IDLE;
            end
    
            START: begin
                ser_en  = 1'b1;
                mux_sel = 3'b001;
                busy_reg    = 1'b1;  
                    
                next_state = DATA;
            end

            DATA: begin
                mux_sel = 3'b010;
                busy_reg    = 1'b1; 
    
                if(ser_done) begin
                    ser_en =1'b0;
    
                    if(parity_en)
                        next_state = PARITY;
                        
                    else
                        next_state = STOP;
                end
                else begin
                    ser_en  = 1'b1;
                        
                    next_state = DATA;
                end
            end
    
            PARITY: begin
                ser_en  = 1'b0;
                mux_sel = 3'b011;
                busy_reg    = 1'b1; 
    
                next_state = STOP;
            end
    
            STOP: begin
                ser_en  = 1'b0;
                mux_sel = 3'b100;
                busy_reg    = 1'b1;

                next_state = IDLE;
            end
    
            default: begin
                ser_en  = 1'b0;
                mux_sel = 2'b00;
                busy_reg    = 1'b0; 
    
                next_state = IDLE;
            end
        endcase
    end
endmodule