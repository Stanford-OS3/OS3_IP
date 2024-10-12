module CNN_FSM #(
    NUM_PE = 64
    SPI_BYTE_WIDTH = 8
    MAC_SIZE = 3
)
(
    input logic rstn_,
    input logic clk,
    input logic [7:0] logic spi_packets [SPI_BYTE_WIDTH-1:0],
    output logic [NUM_PE-1:0] conv_eng_ex_en,
    output logic [$clog2(8)-1:0] conv_reg_en [MAC_SIZE**2:0][NUM_PE-1:0][1:0]
);

logic [($clog2(NUM_PACKETS)/8)-1: 0] i_num; //maybe track the number of packets
localparam NUM_PACKETS $clog2(Number of bytes)/8;
// ceiling(Exact number of bytes / SPI_BYTE_WIDTH) = number of packets

always @(posedge clk) begin
    if (~rstn_) begin
        //reset all registers
    end
    //check for enable bit
    else if (spi_packets[0][0] == 1'b1) begin
        
    end
    else if (i!=0) begin

        //determine if SPI packets are sending IMG or WEIGHTS 
        conv_reg_en[$clog2(8)-1:0][i%MAC_SIZE][][] <= i; //could be doing this wrong





        if (i%9 == $clog2(NUM_PACKETS)/8) begin

        end
    end
end