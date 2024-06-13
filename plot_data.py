"""
This app uses Python 3.12 or greater , numpy, and pandas to generate a set of data points and plot them on a graph.
"""

# import the required libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

"""
Create a function 'gendata' that generates a set of data points (x, f(x)) and returns them as a pandas data frame.
Arguments:
- 'x_range' is a tuple of two integers representing the range of x values to generate.
- 'size' is an integer representing the number of data points to generate.
Returns:
- A pandas data frame with two columns, 'x' and 'y'.
Details:
- 'x' values are generated randomly between x_range[0] and x_range[1].
- 'y' values are generated as a non-linear function of x with excessive random noise: y = x ^ 1.5  + noise.
- The data frame is sorted in ascending order by the 'x' values.
"""
def gendata(x_range, size):
    # Generate random x values
    x = np.random.randint(x_range[0], x_range[1], size)
    # Generate y values with noise
    y = x ** 1.5 + np.random.normal(0, 100, size)
    # Create a pandas data frame
    df = pd.DataFrame({'x': x, 'y': y})
    # Sort the data frame by 'x' values
    df = df.sort_values('x')
    return df

"""
Create a function 'plotdata' that plots the data points from the data frame.
Arguments:
- 'data' is a pandas data frame with two columns, 'x' and 'y'.
Returns:
- None
Details:
- The data points are plotted as a scatter plot.
- The plot has a title 'Data Points', x-axis label 'x', and y-axis label 'f(x)'.
"""
def plotdata(data):
    # Plot the data points
    plt.scatter(data['x'], data['y'])
    # Set the title and labels
    plt.title('Data Points')
    plt.xlabel('x')
    plt.ylabel('f(x)')
    # Display the plot
    plt.show()

# Main code block
if __name__ == '__main__':
    # Generate data points
    data = gendata((0, 100), 100)
    # Plot the data points
    plotdata(data)

    # save the data to a svg file, first query the user for the file name.
    file_name = input('Enter the file name to save the data points: ')
    # save the data to a svg file
    plt.savefig(file_name)

# End of code

