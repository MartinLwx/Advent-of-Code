import sys


def shape(me: str) -> int:
    match me:
        # rock
        case "X":
            return 1
        # paper
        case "Y":
            return 2
        # scissor
        case "Z":
            return 3


def compute_score(you: str, me: str) -> int:
    match [you, me]:
        case ["A", "Z"] | ["B", "X"] | ["C", "Y"]:
            return 0 + shape(me)
        case ["A", "X"] | ["B", "Y"] | ["C", "Z"]:
            return 3 + shape(me)
        case ["A", "Y"] | ["B", "Z"] | ["C", "X"]:
            return 6 + shape(me)


def get_strategy(you: str, target: str) -> str:
    # x - lose, y - draw, Z - win
    match [you, target]:
        case ["A", "X"] | ["C", "Y"] | ["B", "Z"]:
            return "Z"
        case ["B", "X"] | ["A", "Y"] | ["C", "Z"]:
            return "X"
        case ["C", "X"] | ["B", "Y"] | ["A", "Z"]:
            return "Y"


def main():
    with open(sys.argv[1]) as f:
        lines = f.read()

    part1_score, part2_score = 0, 0
    for line in lines.strip().split("\n"):
        you, me = line.strip().split(' ')
        # for part1
        part1_score += compute_score(you, me)
        # for part2
        part2_score += compute_score(you, get_strategy(you, me))

    print(f"part1 score: {part1_score}")
    print(f"part2 score: {part2_score}")


if __name__ == "__main__":
    main()
