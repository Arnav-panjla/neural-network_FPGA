module Layer_3 #(
    parameter NN = 10,  
    parameter numWeight = 784,
    parameter dataWidth = 16,
    parameter layerNum = 3,  
    parameter sigmoidSize = 10,
    parameter weightIntWidth = 4,
    parameter actType = "relu"
)(
    input                       clk,
    input                       rst,
    input                       weightValid,
    input                       biasValid,
    input [31:0]                weightValue,
    input [31:0]                biasValue,
    input [31:0]                config_layer_num,
    input [31:0]                config_neuron_num,
    input                       x_valid,
    input [dataWidth-1:0]       x_in,
    output [NN-1:0]             o_valid,
    output [NN*dataWidth-1:0]   x_out
);

    function [128*8-1:0] get_weight_file;
        input integer neuron_idx;
        begin
            case(neuron_idx)
                0: get_weight_file = "w_3_0.mif";
                1: get_weight_file = "w_3_1.mif";
                2: get_weight_file = "w_3_2.mif";
                3: get_weight_file = "w_3_3.mif";
                4: get_weight_file = "w_3_4.mif";
                5: get_weight_file = "w_3_5.mif";
                6: get_weight_file = "w_3_6.mif";
                7: get_weight_file = "w_3_7.mif";
                8: get_weight_file = "w_3_8.mif";
                9: get_weight_file = "w_3_9.mif";
                default: get_weight_file = "w_3_0.mif";
            endcase
        end
    endfunction

    function [128*8-1:0] get_bias_file;
        input integer neuron_idx;
        begin
            case(neuron_idx)
                0: get_bias_file = "b_3_0.mif";
                1: get_bias_file = "b_3_1.mif";
                2: get_bias_file = "b_3_2.mif";
                3: get_bias_file = "b_3_3.mif";
                4: get_bias_file = "b_3_4.mif";
                5: get_bias_file = "b_3_5.mif";
                6: get_bias_file = "b_3_6.mif";
                7: get_bias_file = "b_3_7.mif";
                8: get_bias_file = "b_3_8.mif";
                9: get_bias_file = "b_3_9.mif";
                default: get_bias_file = "b_3_0.mif";
            endcase
        end
    endfunction

    genvar i;
    generate
        for (i = 0; i < NN; i = i + 1) begin : neuron_gen
            neuron #(
                .numWeight(numWeight),
                .layerNo(layerNum),
                .neuronNo(i),
                .dataWidth(dataWidth),
                .sigmoidSize(sigmoidSize),
                .weightIntWidth(weightIntWidth),
                .actType(actType),
                .weightFile(get_weight_file(i)),
                .biasFile(get_bias_file(i))
            ) n (
                .clk(clk),
                .rst(rst),
                .myinput(x_in),
                .weightValid(weightValid),
                .biasValid(biasValid),
                .weightValue(weightValue),
                .biasValue(biasValue),
                .config_layer_num(config_layer_num),
                .config_neuron_num(config_neuron_num),
                .myinputValid(x_valid),
                .out(x_out[i*dataWidth +: dataWidth]),
                .outvalid(o_valid[i])
            );
        end
    endgenerate

endmodule