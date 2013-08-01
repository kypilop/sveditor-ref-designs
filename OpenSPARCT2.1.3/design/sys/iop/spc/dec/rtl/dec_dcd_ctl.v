// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: dec_dcd_ctl.v
// Copyright (C) 1995-2007 Sun Microsystems, Inc. All Rights Reserved
// 4150 Network Circle, Santa Clara, California 95054, U.S.A.
//
// * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER. 
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; version 2 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 
// For the avoidance of doubt, and except that if any non-GPL license 
// choice is available it will apply instead, Sun elects to use only 
// the General Public License version 2 (GPLv2) at this time for any 
// software where a choice of GPL license versions is made 
// available with the language indicating that GPLv2 or any later version 
// may be used, or where a choice of which version of the GPL is applied is 
// otherwise unspecified. 
//
// Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara, 
// CA 95054 USA or visit www.sun.com if you need additional information or 
// have any questions. 
// 
// ========== Copyright Header End ============================================
module dec_dcd_ctl (
  dec_inst_d, 
  ded_perr_d, 
  ded_ferr_d, 
  dcd_lsu_sign_ext_d, 
  dcd_sethi_d, 
  dcd_priv_d, 
  dcd_fsrc_rs1_d, 
  dcd_fsrc_rs2_d, 
  dcd_fpdest_single_d, 
  dcd_fp_rs1_single_d, 
  dcd_fp_rs2_single_d, 
  dcd_fsrsync_d, 
  dcd_callclass_d, 
  dcd_specbr_d, 
  dcd_specfp_d, 
  dcd_tcc_d, 
  dcd_done_d, 
  dcd_retry_d, 
  dcd_load_d, 
  dcd_store_d, 
  dcd_lsdouble_d, 
  dcd_prefetch_d, 
  dcd_flush_d, 
  dcd_memstbar_d, 
  dcd_sr_d, 
  dcd_pr_d, 
  dcd_hpr_d, 
  dcd_casa_d, 
  dcd_ldstub_d, 
  dcd_alt_d, 
  dcd_alti_d, 
  dcd_swap_d, 
  dcd_lsize_d, 
  dcd_killfgu_d, 
  dcd_exu_src_d, 
  dcd_save_restore_d, 
  dcd_sir_d, 
  dcd_stdfa_d, 
  dcd_fpdisable_d, 
  dcd_wrtick_d);
wire priv_u;
wire [31:0] i;
wire casa_u;
wire lsdouble_u;
wire fsrc_rs1_u;
wire fsrc_rs2_u;
wire fpdest_single_u;
wire fp_rs1_single_u;
wire fp_rs2_single_u;
wire fsrsync_u;
wire callclass_u;
wire specbr_u;
wire specfp_u;
wire tcc_u;
wire done_u;
wire retry_u;
wire load_u;
wire store_u;
wire prefetch_u;
wire flush_u;
wire memstbar_u;
wire sr_u;
wire pr_u;
wire hpr_u;
wire ldstub_u;
wire alt_u;
wire alti_u;
wire swap_u;
wire [1:0] lsize_u;
wire killfgu_u;
wire exu_src_u;
wire save_restore_u;
wire sir_u;
wire stdfa_u;
wire fpdisable_u;
wire wrtick_u;
wire kill_decode_d;
wire illegal_d;


 input [31:0] dec_inst_d;       // inst to decode

 input ded_perr_d;		// parity error
 
 input ded_ferr_d;		// ifetch error

 output dcd_lsu_sign_ext_d;	// is a signed load

 output dcd_sethi_d;		// inst is a special sethi inst

		
 output dcd_priv_d;		// autogenerated outputs
 output dcd_fsrc_rs1_d;		
 output dcd_fsrc_rs2_d;
 output dcd_fpdest_single_d;
 output dcd_fp_rs1_single_d;
 output dcd_fp_rs2_single_d;
 output dcd_fsrsync_d;
 output dcd_callclass_d;
 output dcd_specbr_d;
 output dcd_specfp_d;
 output dcd_tcc_d;
 output dcd_done_d;
 output dcd_retry_d;
 output dcd_load_d;
 output dcd_store_d;
 output dcd_lsdouble_d;
 output dcd_prefetch_d;
 output dcd_flush_d;
 output dcd_memstbar_d;
 output dcd_sr_d;
 output dcd_pr_d;
 output dcd_hpr_d;
 output dcd_casa_d;
 output dcd_ldstub_d;
 output dcd_alt_d;
 output dcd_alti_d;
 output dcd_swap_d;
 output [1:0] dcd_lsize_d;
 output dcd_killfgu_d;
 output dcd_exu_src_d;
 output dcd_save_restore_d;
 output dcd_sir_d;
 output dcd_stdfa_d;
 output dcd_fpdisable_d;
 output dcd_wrtick_d;

dec_dcd_ctl_spare_ctl_macro__flops_0__num_2 spares  (
);


// --- autogenerated by n2decode view=dec Wed Aug 10 15:04:27 CDT 2005

assign priv_u = (i[31]&i[24]&i[23]&!i[22]&!i[21]&!i[20]&i[19]) | (i[31]&i[24]
    &!i[23]&i[22]&!i[21]&!i[19]&i[18]&i[16]) | (i[31]&i[24]&!i[23]&i[22]
    &!i[21]&!i[19]&i[17]&!i[15]&i[14]) | (i[31]&!i[30]&i[28]&!i[26]&i[25]
    &i[24]&i[23]&!i[22]&!i[21]&!i[19]) | (i[31]&!i[30]&i[29]&i[27]&i[24]
    &i[23]&!i[22]&!i[21]&!i[19]) | (i[31]&!i[30]&i[29]&!i[28]&!i[25]
    &i[24]&i[23]&!i[22]&!i[21]&!i[19]) | (!i[30]&i[24]&i[23]&i[22]&i[21]
    &i[20]) | (i[31]&i[24]&!i[23]&i[22]&!i[21]&!i[19]&i[18]&!i[17]&!i[14]) | (
    i[31]&i[24]&!i[23]&i[22]&!i[21]&i[20]&!i[19]) | (i[31]&i[24]&i[23]
    &!i[22]&!i[21]&i[20]&!i[19]);

assign casa_u = (i[31]&i[30]&i[24]&i[22]&!i[19]);

assign lsdouble_u = (i[31]&i[30]&!i[22]&i[20]&i[19]);

assign fsrc_rs1_u = (i[31]&!i[30]&!i[13]&!i[11]&i[10]&i[9]&!i[7]&!i[6]) | (
    i[31]&!i[30]&!i[13]&!i[12]&i[9]&!i[8]&i[5]) | (i[31]&!i[30]&i[20]
    &!i[13]&i[10]&!i[9]&i[8]) | (i[31]&!i[30]&i[20]&!i[13]&i[11]&!i[9]
    &i[8]&!i[5]) | (i[31]&!i[30]&!i[19]&!i[13]&i[11]&i[10]&i[7]&!i[6]) | (
    i[31]&!i[30]&i[20]&!i[13]&i[11]&!i[7]&i[6]) | (i[31]&!i[30]&i[20]
    &!i[19]&!i[13]&!i[11]&i[10]&!i[5]) | (i[31]&!i[30]&!i[22]&!i[20]
    &!i[19]&!i[13]&!i[12]&i[11]) | (i[31]&!i[30]&!i[13]&!i[12]&i[11]&i[9]
    &!i[8]);

assign fsrc_rs2_u = (i[31]&!i[30]&!i[13]&i[11]&!i[8]&i[6]) | (i[31]&!i[30]&!i[13]
    &i[11]&i[9]&!i[7]) | (i[31]&!i[30]&!i[13]&i[11]&i[8]&!i[6]) | (i[31]
    &!i[30]&!i[19]&!i[13]&!i[11]&i[10]) | (i[31]&!i[30]&!i[13]&i[11]&!i[9]
    &i[7]) | (i[31]&!i[30]&i[24]&i[23]&!i[22]&i[21]&!i[20]) | (i[31]
    &!i[30]&!i[22]&!i[13]&i[11]&!i[10]);

assign fpdest_single_u = (i[31]&!i[30]&!i[19]&!i[13]&i[12]&i[7]) | (i[31]&!i[30]
    &!i[13]&i[9]&i[8]&i[6]&i[5]) | (i[31]&!i[30]&!i[13]&i[9]&i[8]&i[7]
    &i[5]) | (i[31]&!i[30]&!i[20]&!i[13]&!i[11]&i[10]&i[5]) | (i[31]
    &!i[30]&!i[22]&!i[19]&!i[13]&i[12]&i[11]&!i[8]) | (i[31]&!i[30]&!i[19]
    &!i[13]&i[11]&!i[8]&i[5]) | (i[31]&i[24]&i[23]&!i[22]&!i[20]&i[19]
    &!i[9]&i[5]) | (i[31]&!i[30]&!i[20]&!i[19]&!i[13]&!i[12]&!i[10]&i[5]) | (
    i[31]&!i[30]&i[20]&!i[13]&i[11]&i[10]&i[5]) | (i[31]&i[30]&i[24]
    &!i[22]&!i[19]);

assign fp_rs1_single_u = (i[31]&!i[30]&!i[13]&!i[11]&i[9]&!i[8]&!i[7]&i[5]) | (
    i[31]&!i[30]&!i[13]&!i[11]&i[10]&i[9]&!i[7]&!i[6]) | (i[31]&!i[30]
    &i[20]&!i[13]&i[11]&i[9]&!i[8]&i[5]) | (i[31]&!i[30]&i[20]&!i[13]
    &i[10]&!i[9]&i[8]&i[5]) | (i[31]&!i[30]&!i[20]&!i[19]&!i[13]&!i[12]
    &i[11]&i[5]) | (i[31]&!i[30]&!i[19]&!i[13]&i[11]&i[10]&i[7]&!i[6]
    &i[5]) | (i[31]&!i[30]&!i[13]&i[11]&!i[7]&i[6]&i[5]) | (i[31]&!i[30]
    &!i[13]&!i[12]&i[9]&!i[8]&!i[6]&i[5]) | (i[31]&i[30]&i[24]&!i[21]
    &!i[19]);

assign fp_rs2_single_u = (i[31]&!i[30]&!i[22]&!i[13]&i[12]&i[11]&!i[6]) | (
    i[31]&!i[30]&!i[13]&i[9]&!i[8]&!i[7]&i[6]&i[5]) | (i[31]&!i[30]&!i[13]
    &!i[11]&i[10]&!i[8]&i[7]&!i[6]&i[5]) | (i[31]&!i[30]&!i[13]&!i[11]
    &i[10]&i[9]&i[8]&!i[7]&!i[6]) | (i[31]&!i[30]&!i[13]&i[11]&!i[9]&i[7]
    &i[5]) | (i[31]&!i[30]&!i[13]&i[11]&!i[8]&i[6]&i[5]) | (i[31]&!i[30]
    &!i[13]&i[11]&i[8]&!i[6]&i[5]) | (i[31]&!i[30]&!i[13]&i[11]&i[9]&!i[7]
    &i[5]) | (i[31]&!i[30]&!i[13]&i[11]&!i[10]&i[5]) | (i[31]&i[24]&i[23]
    &!i[22]&i[21]&!i[20]&i[5]) | (i[31]&i[30]&i[24]&!i[22]&!i[19]) | (
    i[31]&i[30]&!i[25]&i[24]&!i[22]&i[21]&!i[20]);

assign fsrsync_u = (i[31]&!i[30]&!i[13]&!i[11]&i[9]&i[8]&i[7]&!i[5]) | (i[31]
    &i[30]&i[24]&!i[22]&!i[20]&i[19]);

assign callclass_u = (i[24]&i[23]&i[22]&!i[21]&!i[20]) | (!i[31]&i[30]);

assign specbr_u = (!i[31]&!i[30]&i[22]) | (!i[31]&!i[30]&i[23]);

assign specfp_u = (i[31]&!i[30]&!i[13]&i[12]&i[5]) | (i[31]&!i[30]&!i[13]&i[10]
    &i[9]) | (i[31]&!i[30]&!i[22]&!i[13]&i[11]) | (i[31]&!i[30]&i[24]
    &i[23]&!i[22]&i[21]&!i[20]);

assign tcc_u = (!i[30]&i[24]&i[23]&i[22]&!i[21]&i[20]&!i[19]);

assign done_u = (!i[30]&!i[25]&i[24]&i[23]&i[22]&i[21]&i[20]);

assign retry_u = (!i[30]&i[25]&i[24]&i[23]&i[22]&i[21]&i[20]);

assign load_u = (i[31]&i[24]&!i[23]&i[22]&i[20]&!i[19]&i[16]) | (i[31]&i[24]
    &!i[23]&i[22]&!i[21]&!i[17]&i[16]) | (i[31]&i[24]&!i[23]&i[22]&!i[21]
    &!i[20]&i[19]) | (i[31]&i[24]&!i[23]&i[22]&!i[21]&!i[19]&!i[16]) | (
    i[31]&i[30]&i[24]&i[22]) | (i[31]&i[30]&i[22]&i[19]) | (i[31]&i[30]
    &!i[21]);

assign store_u = (i[31]&!i[30]&!i[26]&i[24]&i[23]&!i[22]&!i[21]&!i[19]) | (
    i[31]&i[30]&i[21]&!i[19]) | (i[31]&!i[30]&!i[28]&i[24]&i[23]&!i[22]
    &!i[21]&!i[19]) | (i[31]&!i[30]&i[24]&i[23]&!i[22]&!i[21]&i[20]) | (
    i[31]&i[30]&!i[22]&i[21]) | (i[31]&i[30]&!i[24]&i[21]);

assign prefetch_u = (i[31]&i[30]&i[24]&i[22]&i[19]);

assign flush_u = (!i[30]&i[24]&i[23]&i[22]&i[20]&i[19]);

assign memstbar_u = (i[31]&i[24]&!i[23]&i[22]&!i[21]&i[1]) | (i[31]&i[24]&!i[23]
    &i[22]&!i[21]&i[5]) | (i[31]&i[24]&!i[23]&i[22]&!i[21]&i[6]);

assign sr_u = (i[31]&i[24]&!i[23]&i[22]&!i[21]&!i[20]&!i[19]&!i[17]) | (i[31]
    &i[24]&!i[23]&i[22]&!i[21]&!i[20]&!i[19]&!i[16]) | (i[31]&!i[30]
    &!i[28]&i[24]&i[23]&!i[22]&!i[21]&!i[20]&!i[19]) | (i[31]&!i[30]
    &!i[27]&i[24]&i[23]&!i[22]&!i[21]&!i[20]&!i[19]);

assign pr_u = (i[31]&i[24]&!i[23]&i[22]&!i[21]&i[20]&!i[19]) | (i[31]&i[24]
    &i[23]&!i[22]&!i[21]&i[20]&!i[19]);

assign hpr_u = (i[31]&i[24]&!i[23]&i[22]&!i[21]&!i[20]&i[19]) | (i[31]&!i[30]
    &i[24]&i[23]&!i[22]&i[20]&i[19]);

assign ldstub_u = (i[31]&i[30]&!i[24]&i[22]&i[21]&!i[20]);

assign alt_u = (i[31]&i[30]&i[23]&!i[13]);

assign alti_u = (i[31]&i[30]&i[23]&i[13]);

assign swap_u = (i[31]&i[30]&i[22]&i[21]&i[20]&i[19]);

assign lsize_u[1] = (i[22]&i[21]&!i[19]) | (i[24]) | (i[20]&i[19]) | (!i[20]
    &!i[19]);

assign lsize_u[0] = (i[20]&!i[19]) | (!i[30]) | (i[25]&i[24]&i[19]) | (!i[22]
    &i[20]) | (!i[21]&i[20]);

assign killfgu_u = (i[31]&!i[30]&!i[13]&!i[10]&i[9]&i[8]);

assign exu_src_u = (i[31]&i[24]&!i[23]&i[22]&i[21]&i[20]&!i[19]) | (i[31]&!i[30]
    &i[24]&!i[23]&!i[22]&i[21]&!i[20]&!i[19]) | (!i[30]&i[24]&i[23]&i[22]
    &i[21]&!i[20]) | (i[31]&!i[30]&i[22]&i[21]&!i[20]&i[19]) | (i[31]
    &!i[30]&!i[24]&i[22]&i[20]) | (i[31]&!i[30]&!i[24]&i[22]&i[19]);

assign save_restore_u = (!i[30]&i[24]&i[23]&i[22]&i[21]&!i[20]);

assign sir_u = (i[31]&!i[30]&i[28]&i[26]&i[24]&i[23]&!i[22]&!i[21]&!i[20]);

assign stdfa_u = (i[31]&i[24]&i[23]&i[21]&i[20]&i[19]&!i[13]);

assign fpdisable_u = (i[31]&!i[30]&!i[13]&i[12]&i[5]) | (!i[30]&i[24]&!i[23]
    &i[22]&!i[21]&!i[20]&!i[19]&i[18]&!i[16]&i[15]) | (!i[30]&i[29]&!i[27]
    &i[26]&i[24]&i[23]&!i[22]&!i[20]) | (i[31]&!i[30]&!i[13]&i[9]&i[8]) | (
    i[31]&i[24]&!i[22]&!i[13]&i[11]) | (i[31]&i[24]&!i[22]&!i[13]&i[10]) | (
    !i[30]&i[24]&!i[23]&i[22]&i[21]&!i[20]&!i[19]&!i[18]) | (!i[30]&i[24]
    &i[23]&!i[22]&i[21]&!i[20]) | (i[31]&i[30]&i[24]&!i[22]) | (!i[31]
    &!i[30]&i[24]&i[22]) | (!i[31]&!i[30]&i[24]&i[23]);

assign wrtick_u = (i[31]&!i[30]&i[28]&!i[25]&i[24]&i[23]&!i[22]&!i[21]&!i[20]) | (
    i[31]&!i[30]&!i[29]&i[27]&!i[26]&i[24]&i[23]&!i[22]&!i[21]&!i[20]
    &!i[19]);

// end autogeneration


// force decode to zeroes when the instruction is invalid
 assign kill_decode_d = illegal_d | ded_perr_d | ded_ferr_d;

 assign dcd_priv_d              = priv_u & ~kill_decode_d;
 assign dcd_fsrc_rs1_d		= fsrc_rs1_u & ~kill_decode_d;		
 assign dcd_fsrc_rs2_d		= fsrc_rs2_u & ~kill_decode_d;
 assign dcd_fpdest_single_d	= fpdest_single_u & ~kill_decode_d;
 assign dcd_fp_rs1_single_d	= fp_rs1_single_u & ~kill_decode_d;
 assign dcd_fp_rs2_single_d	= fp_rs2_single_u & ~kill_decode_d;
 assign dcd_fsrsync_d		= fsrsync_u & ~kill_decode_d;
 assign dcd_callclass_d		= callclass_u & ~kill_decode_d;
 assign dcd_specbr_d		= specbr_u & ~kill_decode_d;
 assign dcd_specfp_d		= specfp_u & ~kill_decode_d;
 assign dcd_tcc_d		= tcc_u & ~kill_decode_d;
 assign dcd_done_d		= done_u & ~kill_decode_d;
 assign dcd_retry_d		= retry_u & ~kill_decode_d;
 assign dcd_load_d              = load_u & ~kill_decode_d;         
 assign dcd_store_d             = store_u & ~kill_decode_d;        
 assign dcd_lsdouble_d          = lsdouble_u & ~kill_decode_d;    
 assign dcd_prefetch_d          = prefetch_u & ~kill_decode_d;     
 assign dcd_flush_d             = flush_u & ~kill_decode_d;        
 assign dcd_memstbar_d          = memstbar_u & ~kill_decode_d;     
 assign dcd_sr_d                = sr_u & ~kill_decode_d;           
 assign dcd_pr_d                = pr_u & ~kill_decode_d;           
 assign dcd_hpr_d               = hpr_u & ~kill_decode_d;          
 assign dcd_casa_d              = casa_u & ~kill_decode_d;         
 assign dcd_ldstub_d            = ldstub_u & ~kill_decode_d;       
 assign dcd_alt_d               = alt_u & ~kill_decode_d;          
 assign dcd_alti_d              = alti_u & ~kill_decode_d;         
 assign dcd_swap_d              = swap_u & ~kill_decode_d;         
 assign dcd_lsize_d[1:0]        = lsize_u[1:0] & {2{~kill_decode_d}};   
 assign dcd_killfgu_d           = killfgu_u & ~kill_decode_d;      
 assign dcd_exu_src_d           = exu_src_u & ~kill_decode_d;      
 assign dcd_save_restore_d 	= save_restore_u & ~kill_decode_d; 
 assign dcd_sir_d               = sir_u & ~kill_decode_d;          
 assign dcd_stdfa_d             = stdfa_u & ~kill_decode_d;        
 assign dcd_fpdisable_d         = fpdisable_u & ~kill_decode_d;    
 assign dcd_wrtick_d            = wrtick_u & ~kill_decode_d;       


assign dcd_sethi_d =  ~i[31] & ~i[30] & i[24] & ~i[23] & ~i[22] & i[21:0]==22'h0003f0;

assign i[31:0] = dec_inst_d[31:0];

// all illegals are mapped to this before they are written into the icache
assign illegal_d = ~i[31] & ~i[30] & ~i[24] & ~i[23] & ~i[22];

assign dcd_lsu_sign_ext_d = i[22] & ~i[21];   // op3[3:2]==10

supply0 vss;
supply1 vdd;

endmodule


//  Description:        Spare gate macro for control blocks
//
//  Param num controls the number of times the macro is added
//  flops=0 can be used to use only combination spare logic


module dec_dcd_ctl_spare_ctl_macro__flops_0__num_2;
wire spare0_buf_32x_unused;
wire spare0_nand3_8x_unused;
wire spare0_inv_8x_unused;
wire spare0_aoi22_4x_unused;
wire spare0_buf_8x_unused;
wire spare0_oai22_4x_unused;
wire spare0_inv_16x_unused;
wire spare0_nand2_16x_unused;
wire spare0_nor3_4x_unused;
wire spare0_nand2_8x_unused;
wire spare0_buf_16x_unused;
wire spare0_nor2_16x_unused;
wire spare0_inv_32x_unused;
wire spare1_buf_32x_unused;
wire spare1_nand3_8x_unused;
wire spare1_inv_8x_unused;
wire spare1_aoi22_4x_unused;
wire spare1_buf_8x_unused;
wire spare1_oai22_4x_unused;
wire spare1_inv_16x_unused;
wire spare1_nand2_16x_unused;
wire spare1_nor3_4x_unused;
wire spare1_nand2_8x_unused;
wire spare1_buf_16x_unused;
wire spare1_nor2_16x_unused;
wire spare1_inv_32x_unused;


cl_u1_buf_32x   spare0_buf_32x (.in(1'b1),
                                   .out(spare0_buf_32x_unused));
cl_u1_nand3_8x spare0_nand3_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .in2(1'b1),
                                   .out(spare0_nand3_8x_unused));
cl_u1_inv_8x    spare0_inv_8x (.in(1'b1),
                                  .out(spare0_inv_8x_unused));
cl_u1_aoi22_4x spare0_aoi22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare0_aoi22_4x_unused));
cl_u1_buf_8x    spare0_buf_8x (.in(1'b1),
                                  .out(spare0_buf_8x_unused));
cl_u1_oai22_4x spare0_oai22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare0_oai22_4x_unused));
cl_u1_inv_16x   spare0_inv_16x (.in(1'b1),
                                   .out(spare0_inv_16x_unused));
cl_u1_nand2_16x spare0_nand2_16x (.in0(1'b1),
                                     .in1(1'b1),
                                     .out(spare0_nand2_16x_unused));
cl_u1_nor3_4x spare0_nor3_4x (.in0(1'b0),
                                 .in1(1'b0),
                                 .in2(1'b0),
                                 .out(spare0_nor3_4x_unused));
cl_u1_nand2_8x spare0_nand2_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .out(spare0_nand2_8x_unused));
cl_u1_buf_16x   spare0_buf_16x (.in(1'b1),
                                   .out(spare0_buf_16x_unused));
cl_u1_nor2_16x spare0_nor2_16x (.in0(1'b0),
                                   .in1(1'b0),
                                   .out(spare0_nor2_16x_unused));
cl_u1_inv_32x   spare0_inv_32x (.in(1'b1),
                                   .out(spare0_inv_32x_unused));

cl_u1_buf_32x   spare1_buf_32x (.in(1'b1),
                                   .out(spare1_buf_32x_unused));
cl_u1_nand3_8x spare1_nand3_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .in2(1'b1),
                                   .out(spare1_nand3_8x_unused));
cl_u1_inv_8x    spare1_inv_8x (.in(1'b1),
                                  .out(spare1_inv_8x_unused));
cl_u1_aoi22_4x spare1_aoi22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare1_aoi22_4x_unused));
cl_u1_buf_8x    spare1_buf_8x (.in(1'b1),
                                  .out(spare1_buf_8x_unused));
cl_u1_oai22_4x spare1_oai22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare1_oai22_4x_unused));
cl_u1_inv_16x   spare1_inv_16x (.in(1'b1),
                                   .out(spare1_inv_16x_unused));
cl_u1_nand2_16x spare1_nand2_16x (.in0(1'b1),
                                     .in1(1'b1),
                                     .out(spare1_nand2_16x_unused));
cl_u1_nor3_4x spare1_nor3_4x (.in0(1'b0),
                                 .in1(1'b0),
                                 .in2(1'b0),
                                 .out(spare1_nor3_4x_unused));
cl_u1_nand2_8x spare1_nand2_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .out(spare1_nand2_8x_unused));
cl_u1_buf_16x   spare1_buf_16x (.in(1'b1),
                                   .out(spare1_buf_16x_unused));
cl_u1_nor2_16x spare1_nor2_16x (.in0(1'b0),
                                   .in1(1'b0),
                                   .out(spare1_nor2_16x_unused));
cl_u1_inv_32x   spare1_inv_32x (.in(1'b1),
                                   .out(spare1_inv_32x_unused));



endmodule
