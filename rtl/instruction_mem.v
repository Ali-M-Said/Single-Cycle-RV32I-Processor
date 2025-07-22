module instruction_memory(
    input [31:0] PC,
    output reg [31:0] instr
);
    reg [31:0] instr_mem[0:63];

    initial begin
        $readmemh("program.txt", instr_mem); // Load machine code
    end

    always @(*) begin
        instr = instr_mem[PC[31:2]];
    end
endmodule
