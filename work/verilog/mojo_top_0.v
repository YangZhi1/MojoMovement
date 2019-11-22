/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input cclk,
    output reg spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  reg [23:0] M_player_pos_d, M_player_pos_q = 8'h80;
  reg [1:0] M_row_selector_d, M_row_selector_q = 2'h0;
  
  wire [1-1:0] M_up_out;
  reg [1-1:0] M_up_in;
  edge_detector_2 up (
    .clk(clk),
    .in(M_up_in),
    .out(M_up_out)
  );
  
  wire [1-1:0] M_down_out;
  reg [1-1:0] M_down_in;
  edge_detector_2 down (
    .clk(clk),
    .in(M_down_in),
    .out(M_down_out)
  );
  
  wire [1-1:0] M_left_out;
  reg [1-1:0] M_left_in;
  edge_detector_2 left (
    .clk(clk),
    .in(M_left_in),
    .out(M_left_out)
  );
  
  wire [1-1:0] M_right_out;
  reg [1-1:0] M_right_in;
  edge_detector_2 right (
    .clk(clk),
    .in(M_right_in),
    .out(M_right_out)
  );
  
  wire [1-1:0] M_upb_out;
  reg [1-1:0] M_upb_in;
  button_conditioner_6 upb (
    .clk(clk),
    .in(M_upb_in),
    .out(M_upb_out)
  );
  
  wire [1-1:0] M_downb_out;
  reg [1-1:0] M_downb_in;
  button_conditioner_6 downb (
    .clk(clk),
    .in(M_downb_in),
    .out(M_downb_out)
  );
  
  wire [1-1:0] M_leftb_out;
  reg [1-1:0] M_leftb_in;
  button_conditioner_6 leftb (
    .clk(clk),
    .in(M_leftb_in),
    .out(M_leftb_out)
  );
  
  wire [1-1:0] M_rightb_out;
  reg [1-1:0] M_rightb_in;
  button_conditioner_6 rightb (
    .clk(clk),
    .in(M_rightb_in),
    .out(M_rightb_out)
  );
  
  reg [7:0] checker;
  
  always @* begin
    M_row_selector_d = M_row_selector_q;
    M_player_pos_d = M_player_pos_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    M_upb_in = io_button[0+0-:1];
    M_downb_in = io_button[2+0-:1];
    M_leftb_in = io_button[3+0-:1];
    M_rightb_in = io_button[4+0-:1];
    M_up_in = M_upb_out;
    M_down_in = M_downb_out;
    M_left_in = M_leftb_out;
    M_right_in = M_rightb_out;
    M_player_pos_d = M_player_pos_q;
    M_row_selector_d = M_row_selector_q;
    if (M_up_out) begin
      
      case (M_row_selector_q)
        2'h0: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
        2'h1: begin
          M_player_pos_d[0+7-:8] = M_player_pos_q[8+7-:8];
          M_player_pos_d[8+7-:8] = 8'h00;
          M_row_selector_d = 2'h0;
        end
        2'h2: begin
          M_player_pos_d[8+7-:8] = M_player_pos_q[16+7-:8];
          M_player_pos_d[16+7-:8] = 8'h00;
          M_row_selector_d = 2'h1;
        end
        default: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
      endcase
    end
    if (M_down_out) begin
      
      case (M_row_selector_q)
        2'h0: begin
          M_player_pos_d[8+7-:8] = M_player_pos_q[0+7-:8];
          M_player_pos_d[0+7-:8] = 8'h00;
          M_row_selector_d = 2'h1;
        end
        2'h1: begin
          M_player_pos_d[16+7-:8] = M_player_pos_q[8+7-:8];
          M_player_pos_d[8+7-:8] = 8'h00;
          M_row_selector_d = 2'h2;
        end
        2'h2: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
        default: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
      endcase
    end
    if (M_left_out) begin
      
      case (M_row_selector_q)
        2'h0: begin
          checker = M_player_pos_q[0+7-:8] << 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[0+7-:8] = checker;
          end
        end
        2'h1: begin
          checker = M_player_pos_q[8+7-:8] << 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[8+7-:8] = checker;
          end
        end
        2'h2: begin
          checker = M_player_pos_q[16+7-:8] << 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[16+7-:8] = checker;
          end
        end
        2'h3: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
      endcase
    end
    if (M_right_out) begin
      
      case (M_row_selector_q)
        2'h0: begin
          checker = M_player_pos_q[0+7-:8] >> 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[0+7-:8] = checker;
          end
        end
        2'h1: begin
          checker = M_player_pos_q[8+7-:8] >> 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[8+7-:8] = checker;
          end
        end
        2'h2: begin
          checker = M_player_pos_q[16+7-:8] >> 1'h1;
          if (checker == 8'h00) begin
            M_player_pos_d = M_player_pos_q;
            M_row_selector_d = M_row_selector_q;
          end else begin
            M_player_pos_d[16+7-:8] = checker;
          end
        end
        2'h3: begin
          M_player_pos_d = M_player_pos_q;
          M_row_selector_d = M_row_selector_q;
        end
      endcase
    end
    io_led[0+7-:8] = M_player_pos_q[0+7-:8];
    io_led[8+7-:8] = M_player_pos_q[8+7-:8];
    io_led[16+7-:8] = M_player_pos_q[16+7-:8];
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_player_pos_q <= 8'h80;
      M_row_selector_q <= 2'h0;
    end else begin
      M_player_pos_q <= M_player_pos_d;
      M_row_selector_q <= M_row_selector_d;
    end
  end
  
endmodule