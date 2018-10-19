# September 2017 -- Coin toss
import numpy as np
import matplotlib.pyplot as plt
N_trials = 5000;
Sample_sizes = [6000];
# Note that you can run just one or several Sample_sizes.
# For example, replace the line above with Sample_sizes = [1000, 2000]
# to just have the two Sample_sizes: 1000 and 2000.
width_experimental =[]
width_analytical =[]
for k in Sample_sizes:
    N_samples = k
    Total_heads = []
    for i in range(N_trials):
        # Generate [1 x N_samples] vector of uniformly distributed random
        # integers from 0 or 1.
        rs = np.random.randint(2,size =N_samples);
        # Calculate the total number of heads.
        Total_heads.append(sum(rs));

    BW = 5; # Bin width
    #np.histogram(np.array(Total_heads)-N_samples/2)#, 'BinWidth', BW, 'Normalization', 'pdf')
    data = np.array(Total_heads)-N_samples/2
    histdata = plt.hist(data,normed=True, bins=np.arange(min(data), max(data) + int(BW), int(BW)))
    x = np.linspace(-200, 200,100) # returns a row vector of 100 evenly spaced points between -200 and 200
    POmega = (1/np.sqrt(np.pi*N_samples/2))*np.exp(-2*(x**2)/N_samples+ -2*(x**2)/N_samples**2);
    plt.plot (x, POmega, 'r-')# 'LineWidth', 2);

    plt.xlabel('Deviation from '+' $N/2$'+'heads');
    plt.ylabel('Probability density function') # Label probability density function
    plt.savefig('hist_pdf.pdf')
    #title({[num2str(N_trials), ' trials each of ', num2str(Sample_sizes), ' samples'];
    #        ['Bin width = ', num2str(BW)]});
    plt.xlim([-200, 200])
    #plt.savefig('hist.png')


    '''Finding the width'''
    Max_value = max(histdata[0])

    delta =Max_value/20
    print(N_samples)
    elements = np.where(  np.abs(histdata[0]-Max_value/np.exp(1)) <delta)[0]

    width_experimental.append(max(elements[1:]-elements[:-1])*BW) # This print
    width_analytical.append(2*N_samples/np.sqrt(2*N_samples+2))
#plt.show()
plt.clf()
plt.plot(width_analytical,width_experimental,'r*')
plt.xlabel('Analytical width');
plt.ylabel('Experimental Width')
for xy in zip(width_analytical, width_experimental):                                       # <--
    plt.annotate('(%s, %s)' % xy, xy=xy, textcoords='data') # <--



plt.show()
plt.savefig('widths.pdf')
