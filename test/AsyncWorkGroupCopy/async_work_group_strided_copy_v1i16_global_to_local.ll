
; RUN: clspv-opt -ReplaceOpenCLBuiltin %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by async_work_group_strided_copy_test_gen.py.
; Please modify that file and regenate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

%opencl.event_t = type opaque



define dso_local spir_func %opencl.event_t* @foo(i16 addrspace(3)* %dst, i16 addrspace(1)* %src, i32 %num_gentypes, i32 %stride, %opencl.event_t* %event) {
entry:
  %call = call spir_func %opencl.event_t* @_Z29async_work_group_strided_copyPU3AS3sPU3AS1Ksjj9ocl_event(i16 addrspace(3)* %dst, i16 addrspace(1)* %src, i32 %num_gentypes, i32 %stride, %opencl.event_t* %event)
  ret %opencl.event_t* %call
}

declare spir_func %opencl.event_t* @_Z29async_work_group_strided_copyPU3AS3sPU3AS1Ksjj9ocl_event(i16 addrspace(3)*, i16 addrspace(1)*, i32, i32, %opencl.event_t*)

; CHECK: [[localid0:%[a-zA-Z0-9_.]+]] = load i32, i32 addrspace(5)* getelementptr (<3 x i32>, <3 x i32> addrspace(5)* @__spirv_LocalInvocationId, i32 0, i32 0), align
; CHECK: [[localid1:%[a-zA-Z0-9_.]+]] = load i32, i32 addrspace(5)* getelementptr (<3 x i32>, <3 x i32> addrspace(5)* @__spirv_LocalInvocationId, i32 0, i32 1), align
; CHECK: [[localid2:%[a-zA-Z0-9_.]+]] = load i32, i32 addrspace(5)* getelementptr (<3 x i32>, <3 x i32> addrspace(5)* @__spirv_LocalInvocationId, i32 0, i32 2), align
; CHECK: [[groupsizevec:%[a-zA-Z0-9_.]+]] = load <3 x i32>, <3 x i32> addrspace(8)* @__spirv_WorkgroupSize, align 16
; CHECK: [[groupsize0:%[a-zA-Z0-9_.]+]] = extractelement <3 x i32> [[groupsizevec]], i32 0
; CHECK: [[groupsize1:%[a-zA-Z0-9_.]+]] = extractelement <3 x i32> [[groupsizevec]], i32 1
; CHECK: [[groupsize2:%[a-zA-Z0-9_.]+]] = extractelement <3 x i32> [[groupsizevec]], i32 2
; CHECK: [[tmp7:%[a-zA-Z0-9_.]+]] = mul i32 [[localid2]], [[groupsize1]]
; CHECK: [[tmp8:%[a-zA-Z0-9_.]+]] = add i32 [[tmp7]], [[localid1]]
; CHECK: [[tmp9:%[a-zA-Z0-9_.]+]] = mul i32 [[tmp8]], [[groupsize0]]
; CHECK: [[startid:%[a-zA-Z0-9_.]+]] = add i32 [[tmp9]], [[localid0]]
; CHECK: [[tmp11:%[a-zA-Z0-9_.]+]] = mul i32 [[groupsize0]], [[groupsize1]]
; CHECK: [[incr:%[a-zA-Z0-9_.]+]] = mul i32 [[tmp11]], [[groupsize2]]
; CHECK: br label %[[cmp:[a-zA-Z0-9_.]+]]
; CHECK: [[cmp]]:
; CHECK: [[phiiterator:%[a-zA-Z0-9_.]+]] = phi i32 [ [[startid]], %[[entry:[a-zA-Z0-9_.]+]] ], [ [[nextiterator:%[a-zA-Z0-9_.]+]], %[[loop:[a-zA-Z0-9_.]+]] ]
; CHECK: [[icmp:%[a-zA-Z0-9_.]+]] = icmp ult i32 [[phiiterator]], %num_gentypes
; CHECK: br i1 [[icmp]], label %[[loop]], label %[[exit:[a-zA-Z0-9_.]+]]
; CHECK: [[loop]]:

; CHECK: [[srciterator:%[a-zA-Z0-9_.]+]] = mul i32 [[phiiterator]], %stride
; CHECK: [[dsti:%[a-zA-Z0-9_.]+]] = getelementptr i16, i16 addrspace(3)* %dst, i32 [[phiiterator]]
; CHECK: [[srci:%[a-zA-Z0-9_.]+]] = getelementptr i16, i16 addrspace(1)* %src, i32 [[srciterator]]

; CHECK: [[nextiterator]] = add i32 [[phiiterator]], [[incr]]
; CHECK: call void @_Z8spirv.op.63.PU3AS3tPU3AS1t(i32 63, i16 addrspace(3)* [[dsti]], i16 addrspace(1)* [[srci]])
; CHECK: br label %[[cmp]]
