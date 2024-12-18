uint32_t encodeLUI (uint32_t rd, uint32_t imm, uint32_t DEBUG) {
    uint32_t instruction = 0;
    uint32_t opcode = 0x37;
    instruction |= (opcode & 0x7F);
    instruction |= ((rd & 0x1F) << 7);
    instruction |= ((imm & 0xFFFFF) << 12);
    if (DEBUG)
        printf("lui x%0d, %0d: %x\n", rd, imm, instruction);
    return instruction;
}

uint32_t encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm, uint32_t DEBUG) {
    uint32_t instruction = 0;
    uint32_t opcode = 0x13;
    instruction |= (opcode & 0x7F);
    instruction |= ((rd & 0x1F) << 7);
    instruction |= (0 << 12);
    instruction |= ((rs1 & 0x1F) << 15);
    instruction |= ((imm & 0xFFF) << 20);
    if (DEBUG)
        printf("addi x%0d, x%0d, %0d: %x\n", rd, rs1, imm, instruction);
    return instruction;
}