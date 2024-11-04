from os import walk, mkdir
from os.path import dirname, abspath, exists


def list_all_files(path):
    lst_file = []
    for (_, _, filenames) in walk(path):
        lst_file.extend(filenames)
    return lst_file


def parse_line(line):
    return line.strip().replace(' ', '').split('OR')


def normalize_list(s):
    s = sorted(list(set(s)), key=lambda k: k[-1])
    for i in range(len(s) - 1):
        if s[i][-1] == s[i + 1][-1]:
            return [True]
    return s


def PL_resolve(clause1, clause2):
    dual_literals = []
    for lit1 in clause1:
        for lit2 in clause2:
            if lit1[-1] == lit2[-1] and len(lit1) != len(lit2):
                dual_literals.append(lit1[-1])

    if len(dual_literals) == 1:
        result = list(set(clause1) | set(clause2))
        result.remove(dual_literals[0])
        result.remove('-' + dual_literals[0])
        return sorted(result, key=lambda k: k[-1])
    return [True]


def PL_resolution(KB, alpha):
    global output

    # 1 - add KB and -alpha to clauses
    clauses = set()
    # add all clauses of KB to clauses
    for line in KB:
        c = normalize_list(parse_line(line))
        # transform clause from list to tuple -> add into a set
        clauses.add(tuple(c))

    # add negative of alpha to clauses
    alpha = normalize_list(parse_line(alpha))
    if alpha == [True]:
        output = []
        return True
    for literal in alpha:
        if len(literal) == 1:
            clauses.add(tuple(['-' + literal]))
        else:
            clauses.add(tuple([literal[-1]]))

    # 2 - loop
    while True:
        empty = False
        new_clauses = set()
        for c1 in clauses:
            for c2 in clauses:
                result = PL_resolve(c1, c2)
                if len(result) == 0:
                    empty = True
                    new_clauses.add(tuple(['{}']))
                elif result == [True]:
                    continue
                else:
                    new_clauses.add(tuple(result))
        # put new clauses generated in this loop to output
        # for file writing
        output.append(new_clauses.difference(clauses))
        # check loop stop
        if empty:
            return True
        if new_clauses.issubset(clauses):
            return False
        # continue to next loop
        clauses = clauses | new_clauses


def test(input_file, output_file):
    global output
    # reading input file
    alpha = ''
    n = 0
    KB = []
    with open(input_file) as file:
        alpha = file.readline()
        n = int(file.readline())
        for _ in range(n):
            KB.append(file.readline())

    # main
    res = PL_resolution(KB, alpha)

    # writing result
    with open(output_file, 'w') as file:
        for clauses in output:
            file.write(str(len(clauses)) + '\n')
            for clause in clauses:
                s = ' OR '.join(clause)
                file.write(s + '\n')
        if res:
            file.write('YES')
        else:
            file.write('NO')


if __name__ == "__main__":
    global output
    INPUT = 'input'
    OUTPUT = 'output'

    # get file list for queries
    if exists(INPUT):
        files = list_all_files(INPUT)
        if not exists(OUTPUT):
            mkdir(OUTPUT)

        for i in range(len(files)):
            output = []
            input_file = INPUT + '/' + files[i]
            output_file = input_file.replace(INPUT, OUTPUT)

            # reading input file
            with open(input_file) as file:
                alpha = file.readline()
                n = int(file.readline())
                KB = [file.readline() for _ in range(n)]

            # main algorithm
            res = PL_resolution(KB, alpha)

            # writing result
            with open(output_file, 'w') as file:
                for clauses in output:
                    file.write(str(len(clauses)) + '\n')
                    for clause in clauses:
                        s = ' OR '.join(clause)
                        file.write(s + '\n')
                if res:
                    file.write('YES')
                else:
                    file.write('NO')
