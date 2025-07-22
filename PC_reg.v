module PC_reg(
    input [31:0]PCNext,
    input CLK,areset,load,
    output reg[31:0]PC
);

always @(posedge CLK or negedge areset )begin
    if(!areset) PC<=32'b0;
    else if(load)PC<=PCNext;
end
endmodule
