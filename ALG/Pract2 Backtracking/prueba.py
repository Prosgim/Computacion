def langford(N):
    def backtrack(seq, num):
        if num == 0:
            yield "-".join(map(str, seq))
        else:
            for i in range(len(seq) - num - 1):
                if seq[i] == 0 and seq[i + num + 1] == 0:
                    seq[i] = seq[i + num + 1] = num
                    yield from backtrack(seq, num - 1)
                    seq[i] = seq[i + num + 1] = 0

    seq = [0] * (2 * N)
    yield from backtrack(seq, N)

N = 4  # Cambia N al valor deseado
for solution in langford(N):
    print(solution)
