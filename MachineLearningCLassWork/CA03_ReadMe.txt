## CA 03 - Decision Tree Algorithm - Kiejstut Bunikiewicz


### Project Overview
This project is an attempt to use the Decision Trees model to classify sample people and predict whether or not they have an income abouve $50,000 by using explanatory data
like Hours Per Week Worked, Capital Gains, Age, and Marriage Status. This project is a first attempt at using the Decision Trees model. 
It could be useful for future reference as a template for other projects that require the use of Decision Trees. This data contains 48,842 rows of data.
The columns are all binned and labeled for classification. The columns include hours per week worked, occupation, marriage status, capital gains, race and sex,
number of years of education, education type, work class, and age group. This project attempts to tune the model to find the most effective hyperparameters.
Finally, the project attempts to automate the hyperparamater tuning and to predict the outcome for a hypothetical individual.

### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:
import os (Python's OS Module)
import numpy as np (NumPy)
from collections import Counter (Collections)
import pandas as pd (Pandas)
from sklearn.tree import DecisionTreeClassifier (Decision Tree Model from sklearn)
import sklearn.metrics (Metrics for model performance, SKLearn)
from sklearn.metrics import accuracy_score (Metrics for model performance, SKLearn)
from sklearn.metrics import confusion_matrix (Metrics for model performance, SKLearn)
from sklearn.metrics import precision_score (Metrics for model performance, SKLearn)
from sklearn.metrics import recall_score (Metrics for model performance, SKLearn)
from sklearn.metrics import f1_score (Metrics for model performance, SKLearn)
from sklearn.metrics import roc_auc_score (Metrics for model performance, SKLearn)
from sklearn.metrics import roc_curve (Metrics for model performance, SKLearn)
from sklearn.metrics import plot_roc_curve (Metrics for model performance, SKLearn)
from sklearn import svm (SKLearn, used for plotting ROC Curve)
import matplotlib.pyplot as plt (For Exploratory Graphs)
import pydotplus (For GraphViz)
from IPython.display import Image (For GraphViz)
from sklearn.externals.six import StringIO (For GraphViz)
from sklearn.tree import export_graphviz (For GraphViz)
from google.colab import drive (Google Drive Mount)

### Operating Instructions
For Google Colab:
Download the data files, the automated_parameter_tuning.csv, and .ipynb file. Upload both files to your Google Drive following the filepath '/content/drive/My Drive/MSBA_Colab_2020/ML_Algorithms/CA03/Data/filename'.
Open the .ipynb file (Google should default to Colab for opening this file type). 
To read in the data, mount your drive in Google Drive by clicking the folder on the popout menu on the left. Then a set of three icons will appear. The rightmost
icon will allow you to mount your drive. Another way to mount the drive is to run the code in the package import cell that will mount the Google Drive.
If the folder path is the same as the folder path in the Data File Reading Section, the data will automatically read when
the cell is run. All of the code is run by clicking the play button that appears when your cursor is hovering over a code cell. The code is commented, explaining
what the lines do.


### File List
The project includes the Python Notebook, automated_parameter_tuning.csv and census_datacsv.
Python Notebook:
Kiejstut_Bunikiewicz_CA03_Decision_Tree_Algorithm.ipynb

CSV Files:
census_data.csv (Dataset for the model)
automated_parameter_tuning.csv (Used for automated parameter tuning)
Tree Tuning Cases.xlsx is the output of the results for the manual tuning

The census dataset used is linked here:
https://github.com/ArinB/MSBA-CA-03-Decision-Trees
DataSet is also available in the GitHub.

### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
There should not be any issues in the code. If you are running into an issue, please check if your drive is mounted and if the data is found in a file path identical to
the path in the code. 

 