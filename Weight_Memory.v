`include "include.v"

module Weight_Memory #(parameter numWeight = 3, neuronNo = 5, weightNo = 3, dataWidth = 16, addressWidth = 5, weightFile = "weights_1.mif")
    (
        input clk,
        input wen,
        input ren,
        input [addressWidth-1:0] wadd,
        input [addressWidth-1:0] radd,
        input [dataWidth-1:0] win,
        output reg [dataWidth-1:0] wout
    );

    reg [dataWidth-1:0] mem [numWeight-1:0];

    `ifdef pretrained
        initial begin
            $readmemb(weightFile, mem); // b for binary, h for hex
        end
    `else
        always @(posedge clk) 
        begin
            if (wen) begin
                mem[wadd] <= win;
            end            
        end
    `endif 
    always @(posedge clk)
    begin
        if (ren) begin
            wout <= mem[radd];
        end
        else begin
            wout <= 0;
        end
    end 

endmodule
