#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 17 22:36:02 2019

This is a small code to test powerlaw distribution in raw data from commits
Since series analysis must have 2 columns, most of the input data must have this
structure:

|date|lines changed|
------------------
|   1|         13  |

(date is just an index to be able to make series analysis.)

@author: booort
"""

# Imports: powerlaw
import matplotlib.pylab as plt
import numpy as np
import powerlaw
import pandas as pd
# Imports: Series analysis
from pandas import Series
from matplotlib import pyplot
from pandas.plotting import autocorrelation_plot
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

# Open file in a dataframe
file_name = 'commits_django.csv'
df = pd.read_csv(file_name)

# Extract pure data from 2º column and transform it to a numpy array
raw_commits = df['Lines changed']
data = np.array(raw_commits)

# fit the data in a powerlaw (standard  method)
fit = powerlaw.Fit(data, discrete=True)

# plot the raw pdf and the others fitted distributions pdf
powerlaw.plot_pdf(data[data >= fit.power_law.xmin], label="Data as PDF")
fit.power_law.plot_pdf(label="Fitted powerlaw PDF", ls=":")
fit.lognormal.plot_pdf(label="fitted log normal pdf", ls="--")
fit.truncated_power_law.plot_pdf(label="fitted truncated powerlaw  pdf", ls=":")
plt.legend(loc=3, fontsize=14)
plt.show()

# Print data from the fitted process, parameters and estimations
print('Summary\n')
print('Estimated value of alpha parameter: ', fit.power_law.alpha)
print('Estimated first value where powerlaw is exposed: ', fit.power_law.xmin)
print('Estimated last value where powerlaw is exposed: ', fit.power_law.xmax)
print('Estimated precision of alpha parameter: +/-', fit.power_law.sigma)
R, p = fit.distribution_compare('power_law', 'lognormal', normalized_ratio=True)
print('Comparative between powerlaw and lognormal')
print(R, p)
R, p = fit.distribution_compare('power_law', 'exponential', normalized_ratio=True)
print('Comparative between powerlaw and exponential')
print(R, p)
R, p = fit.distribution_compare('power_law', 'truncated_power_law', normalized_ratio=True)
print('Comparative between powerlaw and truncated power law')
print(R, p)
R, p = fit.distribution_compare('truncated_power_law', 'lognormal_positive', normalized_ratio=True)
print('Comparative between truncated powerlaw and lognormal positive ')
print(R, p)


# Now Time Series analysis

# Open data in a Series format
series = Series.from_csv(file_name, header=0)

# Plot autocorrelation_plot
autocorrelation_plot(data)
pyplot.show()

# Plot autocorrelation_plot from statsmodels
plot_acf(series, lags=50)
pyplot.show()

# Plot partial autocorrelation_plot from statsmodels
plot_pacf(series, lags=50)
pyplot.show()

# Plot power spectral density from matplotlib (never done that before, maybe we are looking for
# another representation
pyplot.psd(series, scale_by_freq=0)
pyplot.show()
