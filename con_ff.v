module con_ff (
    input clk,
    input reset,
    input CONin,                    // Enable signal from Control Unit
    input [31:0] register_value,    // From Ra
    input [3:0] condition_code,     // From IR[22:19]
    output reg CON_FF_out            // The captured condition (goes to Control Unit)
);

	//Creating a wire for the con value 
    wire current_CON;
    
    // Instantiate the combinational logic
    con_logic con_check (
        .register_value(register_value),
        .condition_code(condition_code),
        .CON(current_CON)
    );
    
    // Flip-flop to capture CON when enabled
    always @(posedge clk or posedge reset ) begin
	 //When reset the Con_FF_out gets reset to 0
        if (reset) begin
            CON_FF_out <= 1'b0;
				//When CONin = 1, store the result of the condition.
        end else if (CONin) begin
            CON_FF_out <= current_CON;
        end
        // Otherwise, CON_FF_out holds its previous value
    end
    
endmodule