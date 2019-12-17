import numpy as np
import matplotlib.pyplot as plt

from scipy.stats import norm,gamma
import sys

from tifffile import imread

def background_data(data,fun,quants):

    # Fit a normal distribution to the data:
    pars = fun.fit(data)

    # Plot the histogram.
    plt.hist(data, bins=25, alpha=0.6, normed=1)

    # Plot the PDF.
    xmin, xmax = plt.xlim()
    x = np.linspace(xmin, xmax, 100)
    p = fun.pdf(x, *pars)
    my_fun = fun(*pars)
    plt.plot(x, my_fun.pdf(x), 'k', linewidth=2)

    # title = "Fit results: mu = %.2f,  std = %.2f" % (mu, std)
    # plt.title(title)
    plt.show()

    return my_fun.ppf(quants)

def main(p):
    for f in p:

        if f[-4:]!=".tif":
            print f, "is not a tif image"
            continue

        ima = np.array(imread(f))
        quants = [0.9,0.95,0.99]
        lims = background_data(ima.ravel(),gamma,quants)

        f, axarr = plt.subplots(1, 4)
        axarr[0].imshow(ima)
        for i in range(1,4):
            axarr[i].imshow(np.greater(ima,lims[i-1]))
            axarr[i].set_title("quant: " + str(quants[i-1]))
        plt.show()


if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] == 'help':
        print(__doc__)
    else:
        main(sys.argv[1:])
