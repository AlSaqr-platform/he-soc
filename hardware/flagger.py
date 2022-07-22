start = 0
bingo = 0

with open('compile.tcl','r') as fi:
    for (idx,line) in enumerate(fi):
        if ('if {' in line):
            start = idx
        
        if (bingo):
                break

        if ('noc_axi4' in line):
            bingo = 1

with open('compile.tcl','r') as fi:
    new_file = fi.readlines(-1)
    temp_line = new_file[start][:-2]
    temp_line = temp_line + '-mfcu \\' + '\n'
    new_file[start] = temp_line

    with open('compile.tcl','w') as fiw:
        for line in new_file:
            fiw.write(line)


    

