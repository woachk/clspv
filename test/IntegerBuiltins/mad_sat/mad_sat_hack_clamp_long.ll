
; RUN: clspv-opt -ReplaceOpenCLBuiltin -hack-clamp-width %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by mad_sat_hack_clamp_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define i64 @mad_sat_long(i64 %a, i64 %b, i64 %c) {
entry:
 %call = call i64 @_Z7mad_satlll(i64 %a, i64 %b, i64 %c)
 ret i64 %call
}

declare i64 @_Z7mad_satlll(i64, i64, i64)

; CHECK: [[mul_ext:%[a-zA-Z0-9_.]+]] = call { i64, i64 } @_Z8spirv.op.152.{{.*}}(i32 152, i64 %a, i64 %b)
; CHECK: [[mul_lo:%[a-zA-Z0-9_.]+]] = extractvalue { i64, i64 } [[mul_ext]], 0
; CHECK: [[mul_hi:%[a-zA-Z0-9_.]+]] = extractvalue { i64, i64 } [[mul_ext]], 1
; CHECK: [[add:%[a-zA-Z0-9_.]+]] = add i64 [[mul_lo]], %c
; CHECK: [[xor:%[a-zA-Z0-9_.]+]] = xor i64 %a, %b
; CHECK: [[same_sign:%[a-zA-Z0-9_.]+]] = icmp sgt i64 [[xor]], -1
; CHECK: [[diff_sign:%[a-zA-Z0-9_.]+]] = xor i1 [[same_sign]], true
; CHECK: [[hi_eq_0:%[a-zA-Z0-9_.]+]] = icmp eq i64 [[mul_hi]], 0
; CHECK: [[hi_ne_0:%[a-zA-Z0-9_.]+]] = xor i1 [[hi_eq_0]], true
; CHECK: [[lo_ge_max:%[a-zA-Z0-9_.]+]] = icmp uge i64 [[mul_lo]], 9223372036854775807
; CHECK: [[c_gt_0:%[a-zA-Z0-9_.]+]] = icmp sgt i64 %c, 0
; CHECK: [[c_lt_0:%[a-zA-Z0-9_.]+]] = icmp slt i64 %c, 0
; CHECK: [[add_gt_max:%[a-zA-Z0-9_.]+]] = icmp ugt i64 [[add]], 9223372036854775807
; CHECK: [[hi_eq_m1:%[a-zA-Z0-9_.]+]] = icmp eq i64 [[mul_hi]], -1
; CHECK: [[hi_ne_m1:%[a-zA-Z0-9_.]+]] = xor i1 [[hi_eq_m1]], true
; CHECK: [[lo_le_max_plus_1:%[a-zA-Z0-9_.]+]] = icmp ule i64 [[mul_lo]], -9223372036854775808
; CHECK: [[max_sub_lo:%[a-zA-Z0-9_.]+]] = sub i64 9223372036854775807, [[mul_lo]]
; CHECK: [[c_lt_max_sub_lo:%[a-zA-Z0-9_.]+]] = icmp ult i64 %c, [[max_sub_lo]]
; CHECK: [[max_clamp1:%[a-zA-Z0-9_.]+]] = and i1 [[same_sign]], [[hi_ne_0]]
; CHECK: [[tmp:%[a-zA-Z0-9_.]+]] = or i1 [[c_gt_0]], [[add_gt_max]]
; CHECK: [[tmp2:%[a-zA-Z0-9_.]+]] = and i1 [[hi_eq_0]], [[lo_ge_max]]
; CHECK: [[max_clamp2:%[a-zA-Z0-9_.]+]] = and i1 [[tmp2]], [[tmp]]
; CHECK: [[max_clamp:%[a-zA-Z0-9_.]+]] = or i1 [[max_clamp1]], [[max_clamp2]]
; CHECK: [[min_clamp1:%[a-zA-Z0-9_.]+]] = and i1 [[diff_sign]], [[hi_ne_m1]]
; CHECK: [[tmp:%[a-zA-Z0-9_.]+]] = or i1 [[c_lt_0]], [[c_lt_max_sub_lo]]
; CHECK: [[tmp2:%[a-zA-Z0-9_.]+]] = and i1 [[hi_eq_m1]], [[lo_le_max_plus_1]]
; CHECK: [[min_clamp2:%[a-zA-Z0-9_.]+]] = and i1 [[tmp2]], [[tmp]]
; CHECK: [[min_clamp:%[a-zA-Z0-9_.]+]] = or i1 [[min_clamp1]], [[min_clamp2]]
; CHECK: [[sel1:%[a-zA-Z0-9_.]+]] = select i1 [[min_clamp]], i64 -9223372036854775808, i64 [[add]]
; CHECK: [[sel2:%[a-zA-Z0-9_.]+]] = select i1 [[max_clamp]], i64 9223372036854775807, i64 [[sel1]]
; CHECK: ret i64 [[sel2]]
