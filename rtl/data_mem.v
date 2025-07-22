module data_mem(
    input CLK,WE,
    input [31:0]A,WD,
    output reg[31:0]RD
);
reg[31:0]data_memory[0:63];

always @(posedge CLK)begin
    if(WE)data_memory[A[31:2]]<=WD;
end

always @(*)begin
    RD=data_memory[A[31:2]];
end

endmodule
