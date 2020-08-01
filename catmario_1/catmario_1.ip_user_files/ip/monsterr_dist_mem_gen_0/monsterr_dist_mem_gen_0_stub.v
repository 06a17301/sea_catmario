// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Aug  1 10:04:45 2020
// Host        : LAPTOP-SQODOUTU running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/a_summer_xilinx/catmario_1/catmario_1.srcs/sources_1/ip/monsterr_dist_mem_gen_0/monsterr_dist_mem_gen_0_stub.v
// Design      : monsterr_dist_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module monsterr_dist_mem_gen_0(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[9:0],spo[7:0]" */;
  input [9:0]a;
  output [7:0]spo;
endmodule
