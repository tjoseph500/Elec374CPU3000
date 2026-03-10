module divider(
    input  [31:0] Q,      // Dividend
	 input  [31:0] M,      // Divisor
    output reg [63:0] Result  // {Remainder, Quotient}
);

reg signed [32:0] A;
reg [31:0] Q_reg;

reg signQ;
reg signM;
reg signResult;
reg [31:0] absQ;
reg [31:0] absM;

integer i;

always @(*) begin

    // Divide-by-zero protection
    if (M == 0) begin
        Result = 64'd0;
    end
    else begin

    // Save signs
	 //The MSB of a 32-bit signed number is the sign bit, so if it's 1 , then its negative 
    signQ = Q[31];
    signM = M[31];
	 //This is XOR.That means the quotient is negative only if exactly one input is negative.
    signResult = signQ ^ signM;

    // Convert inputs to absolute values
    absQ = signQ ? (~Q + 1'b1) : Q;
    absM = signM ? (~M + 1'b1) : M;

    A     = 33'd0;
    Q_reg = absQ;

	 //This runs 32 times, once for each bit.
    for (i = 0; i < 32; i = i + 1) begin
        
        // Shift left combined {A, Q}
		  //Taking the lower 32 bits of A and appends the top bit of Q_reg
        A     = {A[31:0], Q_reg[31]};
		  //Shift left by 1 because in binary long division, each step brings down the next bit, updates the remainder decide whether the quotient bit is 0 or 1 
        Q_reg = Q_reg << 1;
		  
		
        // Subtract divisor
		 //subtracting the divisor from the current remainder
        A = A - {1'b0, absM};
			
			//If the subtraction fails because the divisor is too big, the quotient bit is set to 0 and the value of $A$ is restored; otherwise, the subtraction is successful and the quotient bit is set to 1.
		  
        if (A < 0) begin
            Q_reg[0] = 1'b0;
            A = A + {1'b0, absM};   // Restore
        end
        else begin
            Q_reg[0] = 1'b1;
        end
    end

    // Apply correct sign to quotient
    if (signResult)
        Q_reg = ~Q_reg + 1'b1;

    // Apply dividend sign to remainder
    if (signQ)
        A = -A;

    // Remainder must be 32 bits
    Result = {A[31:0], Q_reg};

    end

end

endmodule