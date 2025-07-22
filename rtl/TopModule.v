module TopModule (
    input clk,
    input reset
);
    wire [31:0] PC, PCNext, Instr;
    wire [31:0] ImmExt;
    wire [31:0] SrcA, SrcB;
    wire [31:0] ALUResult;
    wire [31:0] RD2, ReadData, Result;

    wire zero, signflag;
    wire [2:0] ALUControl;
    wire [1:0] ImmSrc;
    wire ResultSrc, MemWrite, ALUSrc, RegWrite, PCSrc;

    // PC Register
    PC_reg pc_reg (
        .PCNext(PCNext),
        .CLK(clk),
        .areset(reset),
        .load(1'b1),     // always load unless halted (not supported yet)
        .PC(PC)
    );

    // Instruction Memory (word-aligned)
    instruction_memory instr_mem (
        .PC(PC),
        .instr(Instr)
    );

    // Control Unit
    ControlUnit control_unit (
        .zero(zero),
        .signflag(signflag),
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[30]),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl),
        .PCSrc(PCSrc)
    );

    // Register File
    register_file reg_file (
        .CLK(clk),
        .areset(reset), // active-low reset
        .WE3(RegWrite),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(Result),
        .RD1(SrcA),
        .RD2(RD2)
    );

    // Sign Extension
    SignExtender sign_extender (
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    // ALU Source MUX
    Mux2x1 alu_mux (
        .In1(RD2),
        .In2(ImmExt),
        .sel(ALUSrc),
        .out(SrcB)
    );

    // ALU
    ALU alu (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .zero(zero),
        .signflag(signflag)
    );

    // Data Memory
    data_mem data_memory (
        .CLK(clk),
        .WE(MemWrite),
        .A(ALUResult),
        .WD(RD2),
        .RD(ReadData)
    );

    // Result MUX (ALU or Memory)
    Mux2x1 result_mux (
        .In1(ALUResult),
        .In2(ReadData),
        .sel(ResultSrc),
        .out(Result)
    );

    // PC Next Logic (PC + 4 or PC + ImmExt)
    PC_Next_logic pc_next_logic (
        .PCsrc(PCSrc),
        .PC(PC),
        .immExt(ImmExt),
        .PCNext(PCNext)
    );

endmodule
