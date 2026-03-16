module con_logic (
	//The input from Ra
    input [31:0] register_value,  
	 //The IR for [22:19]
    input [3:0] condition_code, 
	 //Outputs the CON value as 1 if met or 0 if not met
    output reg CON                  
);

    // First, compute the status bits of the register value
    wire zero = (register_value == 32'b0);           // Is it zero?
    wire negative = register_value[31];               // Is it negative? (MSB)
    wire positive = ~zero & ~negative;                 //
    
	 //Checking which branch instruction should be executed (branch type from IR)
    always @(*) begin
        case(condition_code)
            4'b0000: CON = zero;                      // brzr
            4'b0001: CON = ~zero;                      // brnz
				4'b0010: CON = positive;   // brpl
				4'b0011: CON = negative;   // brmi
            default: CON = 1'b0;                        // Invalid condition
        endcase
    end
    
endmodule