// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: user.org:user:Montgomery_Interface:1.0
// IP Revision: 12

(* X_CORE_INFO = "Montgomery_Interface_v1_0,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "rsa_project_Montgomery_Interface_0_0,Montgomery_Interface_v1_0,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module rsa_project_Montgomery_Interface_0_0 (
  s01_axi_awaddr,
  s01_axi_awprot,
  s01_axi_awvalid,
  s01_axi_awready,
  s01_axi_wdata,
  s01_axi_wstrb,
  s01_axi_wvalid,
  s01_axi_wready,
  s01_axi_bresp,
  s01_axi_bvalid,
  s01_axi_bready,
  s01_axi_araddr,
  s01_axi_arprot,
  s01_axi_arvalid,
  s01_axi_arready,
  s01_axi_rdata,
  s01_axi_rresp,
  s01_axi_rvalid,
  s01_axi_rready,
  bram_addr,
  bram_din,
  bram_dout,
  bram_we,
  bram_en,
  mw_clk,
  mw_resetn,
  mw_bram_din1,
  mw_bram_din2,
  mw_bram_din_valid,
  mw_bram_dout1,
  mw_bram_dout2,
  mw_bram_dout1_valid,
  mw_bram_dout2_valid,
  mw_bram_dout_read,
  mw_port1_din,
  mw_port1_valid,
  mw_port1_read,
  mw_port2_valid,
  mw_port2_read,
  s01_axi_aclk,
  s01_axi_aresetn,
  s00_axi_awaddr,
  s00_axi_awprot,
  s00_axi_awvalid,
  s00_axi_awready,
  s00_axi_wdata,
  s00_axi_wstrb,
  s00_axi_wvalid,
  s00_axi_wready,
  s00_axi_bresp,
  s00_axi_bvalid,
  s00_axi_bready,
  s00_axi_araddr,
  s00_axi_arprot,
  s00_axi_arvalid,
  s00_axi_arready,
  s00_axi_rdata,
  s00_axi_rresp,
  s00_axi_rvalid,
  s00_axi_rready,
  s00_axi_aclk,
  s00_axi_aresetn
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWADDR" *)
input wire [31 : 0] s01_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWPROT" *)
input wire [2 : 0] s01_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWVALID" *)
input wire s01_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWREADY" *)
output wire s01_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WDATA" *)
input wire [31 : 0] s01_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WSTRB" *)
input wire [3 : 0] s01_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WVALID" *)
input wire s01_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WREADY" *)
output wire s01_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BRESP" *)
output wire [1 : 0] s01_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BVALID" *)
output wire s01_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BREADY" *)
input wire s01_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARADDR" *)
input wire [31 : 0] s01_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARPROT" *)
input wire [2 : 0] s01_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARVALID" *)
input wire s01_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARREADY" *)
output wire s01_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RDATA" *)
output wire [31 : 0] s01_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RRESP" *)
output wire [1 : 0] s01_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RVALID" *)
output wire s01_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RREADY" *)
input wire s01_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram ADDR" *)
input wire [9 : 0] bram_addr;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram DIN" *)
input wire [31 : 0] bram_din;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram DOUT" *)
output wire [31 : 0] bram_dout;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram WE" *)
input wire bram_we;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 bram EN" *)
input wire bram_en;
output wire mw_clk;
output wire mw_resetn;
output wire [511 : 0] mw_bram_din1;
output wire [511 : 0] mw_bram_din2;
output wire mw_bram_din_valid;
input wire [511 : 0] mw_bram_dout1;
input wire [511 : 0] mw_bram_dout2;
input wire mw_bram_dout1_valid;
input wire mw_bram_dout2_valid;
output wire mw_bram_dout_read;
output wire [31 : 0] mw_port1_din;
output wire mw_port1_valid;
input wire mw_port1_read;
input wire mw_port2_valid;
output wire mw_port2_read;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S01_AXI_CLK CLK" *)
input wire s01_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S01_AXI_RST RST" *)
input wire s01_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *)
input wire [31 : 0] s00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *)
input wire [2 : 0] s00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *)
input wire s00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *)
output wire s00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *)
input wire [31 : 0] s00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *)
input wire [3 : 0] s00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *)
input wire s00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *)
output wire s00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *)
output wire [1 : 0] s00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *)
output wire s00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *)
input wire s00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *)
input wire [31 : 0] s00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *)
input wire [2 : 0] s00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *)
input wire s00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *)
output wire s00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *)
output wire [31 : 0] s00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *)
output wire [1 : 0] s00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *)
output wire s00_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *)
input wire s00_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *)
input wire s00_axi_aresetn;

  Montgomery_Interface_v1_0 #(
    .C_S01_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S01_AXI_ADDR_WIDTH(32),  // Width of S_AXI address bus
    .C_S00_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S00_AXI_ADDR_WIDTH(32),  // Width of S_AXI address bus
    .C_S00_AXI_ID_WIDTH(1),
    .C_S00_AXI_AWUSER_WIDTH(0),
    .C_S00_AXI_ARUSER_WIDTH(0),
    .C_S00_AXI_WUSER_WIDTH(0),
    .C_S00_AXI_RUSER_WIDTH(0),
    .C_S00_AXI_BUSER_WIDTH(0),
    .C_S01_AXI_ID_WIDTH(1),
    .C_S01_AXI_AWUSER_WIDTH(0),
    .C_S01_AXI_ARUSER_WIDTH(0),
    .C_S01_AXI_WUSER_WIDTH(0),
    .C_S01_AXI_RUSER_WIDTH(0),
    .C_S01_AXI_BUSER_WIDTH(0),
    .BRAM_ADDR_WIDTH(10),
    .BRAM_DATA_WIDTH(32),
    .BRAM_WORD_COUNT(32),
    .BRAM_CLK_LATENCY(1),
    .NUM_OF_CORES(1)
  ) inst (
    .s01_axi_awaddr(s01_axi_awaddr),
    .s01_axi_awprot(s01_axi_awprot),
    .s01_axi_awvalid(s01_axi_awvalid),
    .s01_axi_awready(s01_axi_awready),
    .s01_axi_wdata(s01_axi_wdata),
    .s01_axi_wstrb(s01_axi_wstrb),
    .s01_axi_wvalid(s01_axi_wvalid),
    .s01_axi_wready(s01_axi_wready),
    .s01_axi_bresp(s01_axi_bresp),
    .s01_axi_bvalid(s01_axi_bvalid),
    .s01_axi_bready(s01_axi_bready),
    .s01_axi_araddr(s01_axi_araddr),
    .s01_axi_arprot(s01_axi_arprot),
    .s01_axi_arvalid(s01_axi_arvalid),
    .s01_axi_arready(s01_axi_arready),
    .s01_axi_rdata(s01_axi_rdata),
    .s01_axi_rresp(s01_axi_rresp),
    .s01_axi_rvalid(s01_axi_rvalid),
    .s01_axi_rready(s01_axi_rready),
    .bram_addr(bram_addr),
    .bram_din(bram_din),
    .bram_dout(bram_dout),
    .bram_we(bram_we),
    .bram_en(bram_en),
    .mw_clk(mw_clk),
    .mw_resetn(mw_resetn),
    .mw_bram_din1(mw_bram_din1),
    .mw_bram_din2(mw_bram_din2),
    .mw_bram_din_valid(mw_bram_din_valid),
    .mw_bram_dout1(mw_bram_dout1),
    .mw_bram_dout2(mw_bram_dout2),
    .mw_bram_dout1_valid(mw_bram_dout1_valid),
    .mw_bram_dout2_valid(mw_bram_dout2_valid),
    .mw_bram_dout_read(mw_bram_dout_read),
    .mw_port1_din(mw_port1_din),
    .mw_port1_valid(mw_port1_valid),
    .mw_port1_read(mw_port1_read),
    .mw_port2_valid(mw_port2_valid),
    .mw_port2_read(mw_port2_read),
    .s01_axi_aclk(s01_axi_aclk),
    .s01_axi_aresetn(s01_axi_aresetn),
    .s00_axi_awaddr(s00_axi_awaddr),
    .s00_axi_awprot(s00_axi_awprot),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata(s00_axi_wdata),
    .s00_axi_wstrb(s00_axi_wstrb),
    .s00_axi_wvalid(s00_axi_wvalid),
    .s00_axi_wready(s00_axi_wready),
    .s00_axi_bresp(s00_axi_bresp),
    .s00_axi_bvalid(s00_axi_bvalid),
    .s00_axi_bready(s00_axi_bready),
    .s00_axi_araddr(s00_axi_araddr),
    .s00_axi_arprot(s00_axi_arprot),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata(s00_axi_rdata),
    .s00_axi_rresp(s00_axi_rresp),
    .s00_axi_rvalid(s00_axi_rvalid),
    .s00_axi_rready(s00_axi_rready),
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn)
  );
endmodule
