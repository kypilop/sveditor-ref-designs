/*
* ========== Copyright Header Begin ==========================================
* 
* OpenSPARC T2 Processor File: tso_n1_self_mod103.s
* Copyright (C) 1995-2007 Sun Microsystems, Inc. All Rights Reserved
* 4150 Network Circle, Santa Clara, California 95054, U.S.A.
*
* DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER. 
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 2 of the License.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*
* For the avoidance of doubt, and except that if any non-GPL license 
* choice is available it will apply instead, Sun elects to use only 
* the General Public License version 2 (GPLv2) at this time for any 
* software where a choice of GPL license versions is made 
* available with the language indicating that GPLv2 or any later version 
* may be used, or where a choice of which version of the GPL is applied is 
* otherwise unspecified. 
*
* Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara, 
* CA 95054 USA or visit www.sun.com if you need additional information or 
* have any questions. 
*
* 
* ========== Copyright Header End ============================================
*/
#define MAIN_BASE_DATA_ADDR     0x160000
#define MAIN_BASE_TEXT_ADDR     0x150000
#define MAIN_BASE_DATA_ADDR_RA  0x100160000
#define MAIN_BASE_TEXT_ADDR_RA  0x100150000

#define USER_PAGE_CUSTOM_MAP
#include "hboot.s"

SECTION .MAIN  TEXT_VA=0x150000, DATA_VA=0x160000

attr_text {
        Name = .MAIN,
        VA=MAIN_BASE_TEXT_ADDR,
        RA=MAIN_BASE_TEXT_ADDR_RA,
        PA=ra2pa(MAIN_BASE_TEXT_ADDR_RA,0),
part_0_ctx_nonzero_tsb_config_0,
        TTE_G=0, TTE_Context=PCONTEXT, TTE_V=1, TTE_Size=0, TTE_NFO=0,
        TTE_IE=0, TTE_Soft2=0, TTE_Diag=0, TTE_Soft=0,
        TTE_L=0, TTE_CP=1, TTE_CV=1, TTE_E=0, TTE_EP=1, TTE_P=0, TTE_W=1
        }
attr_data {
        Name = .MAIN,
        VA=MAIN_BASE_DATA_ADDR,
        RA=MAIN_BASE_DATA_ADDR_RA,
        PA=ra2pa(MAIN_BASE_DATA_ADDR_RA,0),
part_0_ctx_nonzero_tsb_config_0,
        TTE_G=0, TTE_Context=PCONTEXT, TTE_V=1, TTE_Size=0, TTE_NFO=0,
        TTE_IE=0, TTE_Soft2=0, TTE_Diag=0, TTE_Soft=0,
        TTE_L=0, TTE_CP=1, TTE_CV=1, TTE_E=0, TTE_P=0, TTE_W=1
        }

.text
.global main

main:	clr	%l0

	th_fork(main)

main_0:

      	add     %g0, 0x20, %i3             ! loop counter

loop0:
	clr	%l1
execute1:
	set	main01,%i0
	jmpl	%i0,%o7
        nop 
	add	%l1, %l0, %l1
        nop
        nop

modify1:
	set	main02,%i0    	!get some known data into the store reg.
	set	main01,%i1   	!change the data at main1
	ld	[%i1],%l0       
	ld	[%i0],%l0       
	st	%l0,[%i1]
	flush	%i1 		!update the I$ to be consistent with the l2

execute2:
        set     main01,%i0
        jmpl    %i0,%o7    	!the jump causes a new cache line to be
        nop               	!loaded into the l2 and the icache.
	add	%l1, %l0, %l1
        nop
        nop

modify2:
	set	main03,%i0    	!get some known data into the store reg.
	set	main01,%i1   	!change the data at main1
	ld	[%i1],%l0       
	ld	[%i0],%l0       
	st	%l0,[%i1]
	flush	%i1 		!update the I$ to be consistent with the l2

execute3:
        set     main01,%i0
        jmpl    %i0,%o7     	!the jump causes a new cache line to be
        nop              	!loaded into the l2 and the icache.
	add	%l1, %l0, %l1
        nop
        nop

modify3:
	set	main04,%i0    	! get some known data into the store reg.
	set	main01,%i1   	! change the data at main1
	ld	[%i1],%l0       
	ld	[%i0],%l0       
	st	%l0,[%i1]
	flush	%i1 		! update the I$ to be consistent with the l2

execute4:
        set     main01,%i0
        jmpl    %i0,%o7      	! the jump causes a new cache line to be
        nop             	! loaded into the l2 and the icache.
	add	%l1, %l0, %l1
        nop
        nop

modify4:
	set	main05,%i0    	! get some known data into the store reg.
	set	main01,%i1   	! change the data at main1
	ld	[%i1],%l0       
	ld	[%i0],%l0       
	st	%l0,[%i1]
	flush	%i1 		! update the I$ to be consistent with the l2

execute5:
        set     main01,%i0
        jmpl    %i0,%o7		! the jump causes a new cache line to be
        nop               	! loaded into the l2 and the icache.
	add	%l1, %l0, %l1
        nop
        nop

	set	15, %i0
	subcc	%i0, %l1, %i0
	bnz	bad_end
	nop

modify5:
	set	main06,%i0    	! get some known data into the store reg.
	set	main01,%i1    	! change the data at main1
	ld	[%i1],%l0       
	ld	[%i0],%l0       
	st	%l0,[%i1]
	flush   %i1		! flush

        dec %i3
        brnz %i3, loop0
        nop

normal_end:
        ta      T_GOOD_TRAP
bad_end:
        ta      T_BAD_TRAP

! the point of these next two pages is to have text pages that
! can be written and read
! The first page holds 2 cache lines worth, the second page has 1 cache line.

ALIGN_PAGE_8K
user_text2_start:

main01:
        mov     1,%l0           ! Replaced with copied_code second pass
	jmpl	%o7+8, %g0
	nop
main02:
	mov	2,%l0
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
main03:
	mov	3,%l0
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

main04:
	mov	4,%l0
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
main05:
	mov	5,%l0
        nop
        nop
        nop
        nop
        nop

main06:
	mov	1,%l0
        nop
        nop
        nop
        nop
        nop
user_text2_end:

main_1:
main_4:
	set	main01,%i1   		! look at main1
	set	main02,%i2   		! look at main1
	set	main03,%i3   		! look at main1
	set	main04,%i4   		! look at main1
	set	main05,%i5   		! look at main1
	set	main06,%i6   		! look at main1

      	setx    0x100, %o2, %o3	! loop counter

loop1or4_2:
	ld	[%i1], %l0
	ld	[%i1 + 0x10], %l1	
	nop
	ld	[%i2], %l0
	ld	[%i2 + 0x10], %l1	
	nop
	ld	[%i3], %l0
	ld	[%i3 + 0x10], %l1	
	nop
	ld	[%i4], %l0
	ld	[%i4 + 0x10], %l1	
	nop
	ld	[%i5], %l0
	ld	[%i5 + 0x10], %l1	
	nop
	ld	[%i6], %l0
	ld	[%i6 + 0x10], %l1	
	nop

        dec %o3
        brnz %o3, loop1or4_2
        nop

        ta      T_GOOD_TRAP

/***********************************************************************
   Test case data start
 ***********************************************************************/
.data
user_data_start:
	.word 0x0
user_data_end:
