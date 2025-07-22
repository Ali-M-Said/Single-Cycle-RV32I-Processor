module PC_Next_logic(
    input PCsrc,
    input [31:0]PC,immExt,
    output [31:0]PCNext
);

wire[31:0]PCPlus4,PCTarget;

assign PCPlus4 = PC + 4;
assign PCTarget = PC + immExt;

assign PCNext=(PCsrc)? PCTarget : PCPlus4 ;

endmodule