## CA 05A - Logistic Regression - Kiejstut Bunikiewicz


### Project Overview

This project is a practice implementation of the Logistic Regression to predict whether or not patients are at risk of Cardiovascular disease. The exercise consists of building a 
Logistic Regression, evaluating the standardized coefficients for their importance in the model, and evaluating the model's overall performance. The model's overall performance was
evaluated using Accuracy Score, the Confusion Matrix, F1 Score, ROC Score and a plot of the ROC curve. The model's coefficients were standardized using the standard deviation for 
each feature.


### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:

import numpy as np (Numpy)
import pandas as pd (Pandas)
from sklearn import linear_model (Logistic Regression Import)
import sklearn.metrics (Metrics for Model Performance)
from sklearn.metrics import accuracy_score
from sklearn.metrics import roc_auc_score
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_roc_curve
import matplotlib.pyplot as plt (MatPlotLib, for Graphing ROC Results)
import pydotplus
from google.colab import drive
from sklearn.model_selection import train_test_split
from sklearn.metrics import f1_score

### Operating Instructions
For Google Colab:
Download the .ipynb file. Upload the files to your Google Drive following the filepath. Open the .ipynb file (Google should default to Colab for opening this file type). 
For reading in the data, use the URL in the Data Reading cell. In Colab's Python, this dataset should read in directly.

For reading in data on your Google Drive:
To read in the data, mount your drive in Google Drive by clicking the folder on the popout menu on the left. Then a set of three icons will appear. The rightmost
icon will allow you to mount your drive. Another way to mount the drive is to run the code in the package import cell that will mount the Google Drive.
If the folder path is the same as the folder path in the Data File Reading Section, the data will automatically read when
the cell is run. All of the code is run by clicking the play button that appears when your cursor is hovering over a code cell. The code is commented, explaining
what the lines do.


### File List
The project includes the Python Notebook and cvd_data.csv.
Python Notebook:
Kiejstut_Bunikiewicz_CA05A_Logistic_Regression.ipynb

CSV Files:
cvd_data.csv (Dataset for the model)
Ideally, you should read in the data directly from the URL, rather than uploading the data to a Google Drive.

The census dataset used is linked here:
https://raw.githubusercontent.com/ArinB/CA05-B-Logistic-Regression/master/cvd_data.csv
DataSet is also available in the GitHub.

### Acknowledgement 
Data was provided by Professor Brahma at the following GitHub link:
https://raw.githubusercontent.com/ArinB/CA05-B-Logistic-Regression/master/cvd_data.csv

### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
There should not be any issues in the code. If you are running into an issue, please check if your drive is mounted and if the data is found in a file path identical to
the path in the code. 

 