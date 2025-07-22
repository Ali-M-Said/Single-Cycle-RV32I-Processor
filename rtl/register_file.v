module register_file(
    input CLK,areset,WE3,
    input [4:0]A1,A2,A3,
    input [31:0]WD3,
    output reg [31:0]RD1,RD2
);
reg [31:0]regfile[0:31] ;
integer i;

always @(*)begin
    RD1=regfile[A1];//no nonblocking assignments because they act like combinationL LOGIC so needs to be updated immediatl
    RD2=regfile[A2];//leh mesh bara el always zai el comb 3ady ?? because the output is of type reg so i need it to act each time anything changes 
end
always @(posedge CLK or negedge areset)begin
    if(!areset)begin
        for(i=0;i<32;i=i+1)regfile[i]<=0;
    end
    else if (WE3) regfile[A3]<=WD3;///a3!==0??????
end
endmodule
