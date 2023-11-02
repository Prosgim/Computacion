# -*- coding: utf-8 -*-

# AUTORES: PAU ROS GIMENO

import sys

def langford(N):
    seq  = [0]*(2*N)
    def backtracking(seq, num):
        if num==0:
            yield "-".join(map(str, seq))
        else:
            for i in range(len(seq) - num - 1):
                if seq[i] == 0 and seq[i + num + 1] == 0:
                    seq[i] = seq[i + num + 1] = num
                    yield from backtracking(seq, num - 1)
                    seq[i] = seq[i + num + 1] = 0

    if N%4 in (0,3):
        yield from backtracking(seq, N)

if __name__ == "__main__":
    if len(sys.argv) not in (2,3):
        print('\nUsage: %s N [maxsoluciones]\n' % (sys.argv[0],))
        sys.exit()
    try:
        N = int(sys.argv[1])
    except ValueError:
        print('First argument must be an integer')
        sys.exit()
    numSolutions = None
    if len(sys.argv) == 3:
        try:
            numSolutions = int(sys.argv[2])
        except ValueError:
            print('Second (optional) argument must be an integer')
            sys.exit()

    i = 0
    for sol in langford(N):
        if numSolutions is not None and i>=numSolutions:
            break
        i += 1
        print(f'sol {i:4} ->',sol)
        
    # N = 4
    # for solution in langford(N):
    #     print(solution)