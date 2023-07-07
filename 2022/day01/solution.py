import sys
import heapq


def main():
    with open(sys.argv[1]) as f:
        lines = f.read()

    top3 = []

    for block in lines.split("\n\n"):
        foods = [int(food) for food in block.rstrip("\n").split("\n")]
        heapq.heappush(top3, sum(foods))
        while len(top3) > 3:
            heapq.heappop(top3)

    # if a min heap has 3 items, the maximum value will be put in the last position
    print(f"The max calories: {top3[-1]}")
    print(f"The sum of the top 3: {sum(top3)}")


if __name__ == "__main__":
    main()
