// RUN: clspv -int8 %s -o %t.spv -vec3-to-vec4
// RUN: spirv-dis -o %t2.spvasm %t.spv
// RUN: FileCheck %s < %t2.spvasm
// RUN: spirv-val --target-env vulkan1.0 %t.spv

// CHECK-DAG: %[[ushort:[0-9a-zA-Z_]+]] = OpTypeInt 16 0
// CHECK-DAG: %[[v4ushort:[0-9a-zA-Z_]+]] = OpTypeVector %[[ushort]] 4
// CHECK-DAG: %[[void:[0-9a-zA-Z_]+]] = OpTypeVoid
// CHECK-DAG: %[[uint:[0-9a-zA-Z_]+]] = OpTypeInt 32 0
// CHECK-DAG: %[[bool:[0-9a-zA-Z_]+]] = OpTypeBool
// CHECK-DAG: %[[v4bool:[0-9a-zA-Z_]+]] = OpTypeVector %[[bool]] 4
// CHECK:     %[[__original_id_23:[0-9]+]] = OpISub %[[v4ushort]] %[[__original_id_21:[0-9]+]] %[[__original_id_22:[0-9]+]]
// CHECK:     %[[__original_id_24:[0-9]+]] = OpISub %[[v4ushort]] %[[__original_id_22]] %[[__original_id_21]]
// CHECK:     %[[__original_id_25:[0-9]+]] = OpUGreaterThan %[[v4bool]] %[[__original_id_22]] %[[__original_id_21]]
// CHECK:     %[[__original_id_26:[0-9]+]] = OpSelect %[[v4ushort]] %[[__original_id_25]] %[[__original_id_24]] %[[__original_id_23]]


kernel void __attribute__((reqd_work_group_size(1, 1, 1))) foo(global ushort3* a, global ushort3* b, global ushort3* c)
{
    *a = abs_diff(*b, *c);
}

