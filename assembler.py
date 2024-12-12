def assemble(x, xopnd):

    def get_register_bin(register):
        reg_map = {
            "r0": "000", "r1": "001", "r2": "010", "r3": "011",
            "r4": "100", "r5": "101", "r6": "110", "r7": "111"
        }
        return reg_map.get(register.lower(), "")

    def format_immediate(value, bits):
        value_bin = bin(int(value) & ((1 << bits) - 1))[2:]  #Negative values
        return value_bin.zfill(bits)

    opcode_map = {
        "add": "0000", "sub": "0001", "not": "0010", "and": "0011", "or": "0100",
        "ld": "0101", "str": "0110", "mov": "0111", "movi": "1000", "jmp": "1001",
        "cmp": "1100", "b": "1101", "hlt": "1111"
    }

    operation = x[0].lower()
    opcode = opcode_map.get(operation, None)
    if not opcode:
        return "Please re-enter your code."

    if operation == "hlt":
        return f"16'b{opcode}000000000000"

    if not xopnd:
        print('Re-Enter your code please.')
        return

    rd, rs1, rs2 = "", "", ""

    if operation in ["add", "sub", "and", "or"]:
        rd = get_register_bin(xopnd[0])
        rs1 = get_register_bin(xopnd[1])
        rs2 = get_register_bin(xopnd[2])
        return f"16'b{opcode}{rs1}{rs2}{rd}000"

    elif operation == "not":
        rd = get_register_bin(xopnd[0])
        rs1 = get_register_bin(xopnd[1])
        return f"16'b{opcode}{rs1}000{rd}000"

    elif operation in ["ld", "str"]:
        rd = get_register_bin(xopnd[0])
        rs1 = get_register_bin(xopnd[1])
        offset = format_immediate(xopnd[2], 6)
        return f"16'b{opcode}{rs1}{rd}{offset}"

    elif operation == "mov":
        rd = get_register_bin(xopnd[0])
        rs1 = get_register_bin(xopnd[1])
        return f"16'b{opcode}{rs1}{rd}000000"

    elif operation == "movi":
        rd = get_register_bin(xopnd[0])
        imm = format_immediate(xopnd[1], 9)
        return f"16'b{opcode}{rd}{imm}"

    elif operation == "jmp":
        address = format_immediate(xopnd[0], 12)
        return f"16'b{opcode}{address}"

    elif operation == "cmp":
        rd = get_register_bin(xopnd[0])
        rs1 = get_register_bin(xopnd[1])
        return f"16'b{opcode}{rd}{rs1}000000"

    elif operation == "b":
        cond_map = {
            "eq": "000", "ne": "001", "lt": "010", "le": "011",
            "gt": "100", "ge": "101"
        }
        cond = cond_map.get(xopnd[0].lower(), "")
        offset = format_immediate(xopnd[1], 9)
        return f"16'b{opcode}{cond}{offset}"

    return "Please re-enter your code."

print("Enter assembly code:")
while True:
    try:
        x = input().split()
    except Exception:
        print('Re-Enter your code please.')
        continue

    xopnd = x[1].split(',') if len(x) > 1 else []
    print(assemble(x, xopnd))
