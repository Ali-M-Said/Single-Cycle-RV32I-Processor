module ALU #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] SrcA, SrcB,
    input [2:0] ALUControl,
    output reg [WIDTH-1:0] ALUResult,
    output wire zero,
    output wire signflag
);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;          // A + B
            3'b001: ALUResult = SrcA << SrcB;         // A SHL B
            3'b010: ALUResult = SrcA - SrcB;          // A - B
            3'b100: ALUResult = SrcA ^ SrcB;          // A XOR B
            3'b101: ALUResult = SrcA >> SrcB;         // A SHR B
            3'b110: ALUResult = SrcA | SrcB;          // A OR B
            3'b111: ALUResult = SrcA & SrcB;          // A AND B
            default: ALUResult = 0;                   // default to 0
        endcase
    end

    assign zero = (ALUResult == 0);                   // Zero flag
    assign signflag = ALUResult[WIDTH-1];             // Sign flag (MSB)

endmodule
