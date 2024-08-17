module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output [3:0] Q,       // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 

reg carry = 1'b0; 
reg [3:0] counter;

/* Counter out ..*/
assign Q = counter;
assign RCO = carry;

always @(posedge CLK or negedge CLR_n) begin
    if (!CLR_n)
        counter <= 4'b0000;
    else if (!LOAD_n)
        counter <= D;
    else if (ENP && ENT)
        counter <= counter + 1;
end

always @(posedge CLK or negedge CLR_n) begin
    if (!CLR_n)
        carry <= 1'b0;
    else
        carry <= (ENT == 1 && counter == 4'hF) ? 1 : 0;
end

endmodule
