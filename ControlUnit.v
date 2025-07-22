module MainDecoder (
    input wire [6:0] op,
    output reg Branch,
    output reg ResultSrc,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg [1:0] ALUOp
);
    localparam loadWord  = 7'b000_0011,
               storeWord = 7'b010_0011,
               R_Type    = 7'b011_0011,
               I_type    = 7'b001_0011,
               Branch_instructions= 7'b1100011;

    always @(*) begin
        case(op)
            loadWord: begin
                RegWrite  = 1;
                ImmSrc    = 2'b00;
                ALUSrc    = 1;
                MemWrite  = 0;
                ResultSrc = 1;
                Branch    = 0;
                ALUOp     = 2'b00;
            end 
            storeWord: begin
                RegWrite  = 0;
                ImmSrc    = 2'b01;
                ALUSrc    = 1;
                MemWrite  = 1;
                ResultSrc = 0;
                Branch    = 0;
                ALUOp     = 2'b00;
            end 
            R_Type: begin
                RegWrite  = 1;
                ImmSrc    = 2'b00;
                ALUSrc    = 0;
                MemWrite  = 0;
                ResultSrc = 0;
                Branch    = 0;
                ALUOp     = 2'b10;
            end 
            I_type: begin
                RegWrite  = 1;
                ImmSrc    = 2'b00;
                ALUSrc    = 1;
                MemWrite  = 0;
                ResultSrc = 0;
                Branch    = 0;
                ALUOp     = 2'b10;
            end 
            Branch_instructions: begin
                RegWrite  = 0;
                ImmSrc    = 2'b10;
                ALUSrc    = 0;
                MemWrite  = 0;
                ResultSrc = 0;
                Branch    = 1;
                ALUOp     = 2'b01;
            end 
            default: begin
                RegWrite  = 0;
                ImmSrc    = 2'b00;
                ALUSrc    = 0;
                MemWrite  = 0;
                ResultSrc = 0;
                Branch    = 0;
                ALUOp     = 2'b00;
            end 
        endcase
    end
endmodule

module ALU_Decoder (
    input wire op,
    input wire [2:0] funct3,
    input wire funct7,
    input wire [1:0] ALUOp,
    output reg [2:0] ALUControl
);
    
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = 3'b000;
            2'b01: begin
                case(funct3)
                    3'b000: ALUControl = 3'b010;
                    3'b001: ALUControl = 3'b010;
                    3'b100: ALUControl = 3'b010;
                    default: ALUControl = 3'b000;
                endcase
            end
            2'b10: begin
                case(funct3)
                3'b000: begin
                    if({op,funct7} == 2'b11)
                        ALUControl = 3'b010;
                    else
                        ALUControl = 3'b000;
                end
                3'b001: ALUControl = 3'b001;
                3'b100: ALUControl = 3'b100;
                3'b101: ALUControl = 3'b101;
                3'b110: ALUControl = 3'b110;
                3'b111: ALUControl = 3'b111;
                default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule

module PCSrcMUX (
    input wire Branch,
    input wire zero,
    input wire signflag,
    input wire [2:0] funct3,
    output reg PCSrc
);      

    always @(*) begin
        case(funct3)
            3'b000: PCSrc = Branch & zero;      
            3'b001: PCSrc = Branch & ~zero;     
            3'b100: PCSrc = Branch & signflag;
        endcase
    end

endmodule

module ControlUnit (
    input wire zero,
    input wire signflag,
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7,
    output wire ResultSrc,
    output wire MemWrite,
    output wire ALUSrc,
    output wire [1:0] ImmSrc,
    output wire RegWrite,
    output wire [2:0] ALUControl,
    output wire PCSrc
);

    wire Branch;
    wire [1:0] ALUOp;

    MainDecoder DUT1 (
        .op(op),
        .Branch(Branch),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    ALU_Decoder DUT2 (
        .ALUOp(ALUOp),
        .op(op[5]),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );
    
    PCSrcMUX DUT3 (
        .Branch(Branch),
        .zero(zero),
        .signflag(signflag),
        .funct3(funct3),
        .PCSrc(PCSrc)
    );

endmodule