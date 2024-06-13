"""
This is a Python app which generates a scatter plot of age vs net worth.
Details:
- Uses the numpy library to generate the data and matplotlib to plot the data. 
- Has functions to generate and plot the data.
- The data is generated based on a normal distribution with the probability of having a high net worth increasing with age.
- The data is plotted as a scatter plot with the x-axis representing age and the y-axis representing net worth.
- The plot has a title 'Age vs Net Worth', x-axis label 'Age', and y-axis label 'Net Worth'.
- The x-axis is formatted as an integer.
- The y-axis is formatted as currency with a $ sign and commas.
"""

"""
Importing the required libraries
"""
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick

""" Create a function 'generate_data'  to generate data.
Arguments: None
Returns: Two numpy arrays, age and net worth.
Details:
- age is between 20 and 70 
- net worth generated in the range 100000 low to 1000000 high using a normal distribution.
- The probability of having a high net worth should increase linearly between 0.1 and 0.9 for ages between 25 and 65.
- use 10000 as the slope of the increase in net worth between 25 and 65.
"""

def generate_data():
    age = np.random.randint(20, 70, 1000)
    net_worth = np.random.normal(550000, 200000, 1000)
    net_worth = net_worth + (age - 25) * 10000
    return age, net_worth




""" Create a function 'plot_data'
Arguments: Two numpy arrays, age and net worth.
Returns: None
Details:
The plot has a title 'Age vs Net Worth', x-axis label 'Age', and y-axis label 'Net Worth'.
The y-axis should be in currency format, in increments of  1/10 the range of the data rounded to the nearest 10000. 
"""

def plot_data(age, net_worth):
    plt.scatter(age, net_worth)
    plt.title('Age vs Net Worth')
    plt.xlabel('Age')
    plt.ylabel('Net Worth')
    plt.gca().xaxis.set_major_formatter(mtick.StrMethodFormatter('{x:,.0f}'))
    plt.gca().yaxis.set_major_formatter(mtick.StrMethodFormatter('${x:,.0f}'))
    plt.show()

""" 
Create a function 'main' to generate data and plot the data.
Arguments: None
Returns: None 
"""
def main():
    age, net_worth = generate_data()
    plot_data(age, net_worth)

"""
Call the main function
"""
if __name__ == '__main__':
    main()