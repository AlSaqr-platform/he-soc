# Script: extract_instr_and_opcodes_separate.py

def extract_instr_values(input_file, output_file):
    instr_values = []

    with open(input_file, 'r') as infile:
        for line in infile:
            if line.startswith("# Mock uart"):
                parts = line.split("INSTR:")
                if len(parts) > 1:
                    instr_part = parts[1]
                    value = instr_part.split(';')[0].strip()
                    # Pad the value to 8 hex digits (32 bits)
                    try:
                        value_int = int(value, 16)
                        value_padded = f"{value_int:08x}"
                        instr_values.append(value_padded)
                    except ValueError:
                        continue  # Skip lines where the value is not a valid hex number

    with open(output_file, 'w') as outfile:
        for idx, value in enumerate(instr_values):
            if idx < len(instr_values) - 1:
                outfile.write(f"{value},\n")
            else:
                outfile.write(f"{value}\n")

def extract_opcodes_from_trace(input_file, output_file, start_pc, end_pc):
    opcodes = []
    start_processing = False

    with open(input_file, 'r') as infile:
        for line in infile:
            tokens = line.strip().split()
            if len(tokens) >= 6:
                pc_str = tokens[3]
                try:
                    # Remove leading zeros and '0x' if present
                    pc_int = int(pc_str, 16)
                    pc_hex = f"{pc_int:x}"

                    if not start_processing:
                        if pc_hex == start_pc.lower():
                            start_processing = True

                    if start_processing:
                        opcode = tokens[5]
                        opcodes.append(opcode)
                        if pc_hex == end_pc.lower():
                            break  # Stop processing after reaching the end PC
                except ValueError:
                    continue  # Skip lines where PC is not a valid hex number

    with open(output_file, 'w') as outfile:
        for idx, opcode in enumerate(opcodes):
            if idx < len(opcodes) - 1:
                outfile.write(f"{opcode},\n")
            else:
                outfile.write(f"{opcode}\n")

if __name__ == "__main__":
    # Input and output file names
    input_filename1 = 'transcript'          # First input file
    input_filename2 = 'trace_hart_0.log'        # Second input file
    output_filename1 = 'instr_values.txt'       # Output file for first input
    output_filename2 = 'opcodes.txt'            # Output file for second input

    # PC values for the second input file
    start_pc = '80000000'                       # PC value to start processing
    end_pc = '80000f80'                         # PC value to stop processing

    # Extract values from the first input file and write to output
    extract_instr_values(input_filename1, output_filename1)

    # Extract opcodes from the second input file and write to output
    extract_opcodes_from_trace(input_filename2, output_filename2, start_pc, end_pc)
