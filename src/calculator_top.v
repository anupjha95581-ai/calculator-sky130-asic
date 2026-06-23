module calculator_top (
    input  wire clk,
    input  wire rst,
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [3:0] opcode,
    output reg  [7:0] result,
    output reg        carry_out
);

    // Internal registers to hold inputs
    reg [7:0] A_reg;
    reg [7:0] B_reg;
    reg [3:0] opcode_reg;

    // Internal wires to catch ALU output before registering
    wire [7:0] alu_result;
    wire       alu_carry;

    // Instantiate the combinational ALU
    alu my_alu (
        .A(A_reg),
        .B(B_reg),
        .opcode(opcode_reg),
        .result(alu_result),
        .carry_out(alu_carry)
    );

    // Sequential logic: Triggered ONLY on clock edge or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear all registers on reset (Active-High)
            A_reg      <= 8'd0;
            B_reg      <= 8'd0;
            opcode_reg <= 4'd0;
            result     <= 8'd0;
            carry_out  <= 1'b0;
        end else begin
            // Capture inputs into registers
            A_reg      <= A;
            B_reg      <= B;
            opcode_reg <= opcode;
            
            // Capture ALU outputs into final output registers
            result     <= alu_result;
            carry_out  <= alu_carry;
        end
    end


endmodule