module alu (
    input  [7:0] A,          // 8-bit input A
    input  [7:0] B,          // 8-bit input B
    input  [3:0] opcode,     // 4-bit instruction
    output reg [7:0] result,
    output reg carry_out
);

    always @(*) begin
        // Default values
        result = 8'd0;
        carry_out = 1'b0;

        case (opcode)
            4'b0000: {carry_out, result} = A + B;          // Addition
            4'b0001: result = A - B;                       // Subtraction
            4'b0010: result = A * B;                       // Multiplication (auto-truncates to 8 bits)
            4'b0011: result = A & B;                       // Bitwise AND
            4'b0100: result = A | B;                       // Bitwise OR
            4'b0101: result = A ^ B;                       // Bitwise XOR
            4'b0110: result = A << 1;                      // Shift Left
            4'b0111: result = A >> 1;                      // Shift Right
            4'b1000: result = ~(A & B);                    // NAND
            4'b1001: result = ~(A | B);                    // NOR
            4'b1010: result = ~(A ^ B);                    // XNOR
            4'b1011: result = ~A;                          // NOT A
            4'b1100: result = {A[6:0], A[7]};              // Rotate Left
            4'b1101: result = {A[0], A[7:1]};              // Rotate Right
            4'b1110: result = (A == B) ? 8'd1 : 8'd0;      // Equality
            4'b1111: result = A;                           // Pass A
            default: result = 8'd0;
        endcase
    end

endmodule