
import matplotlib.pyplot as plt
from pandas import read_csv
import sys


def main(args):
    plt.figure()
    for csv_file in args:
        data = read_csv(csv_file, delimiter=",")

        plt.plot(data["Max"], label=csv_file)
        plt.plot(data["Mean"], label=csv_file)

    plt.show()

if __name__ == "__main__":
    main(sys.argv[1:])