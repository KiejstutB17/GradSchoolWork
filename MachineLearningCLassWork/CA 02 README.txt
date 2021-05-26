## CA 02 - Spam eMail Detection using Naive Bayes Classification Algorithm - Kiejstut Bunikiewicz

### Project Overview
This project is an attempt to extract data and use Naive Bayes to filter spam emails while keeping nonspam emails for the LMU BSAN 6070 Machine Learning class.
This project is a first attempt at trying to use the Naive Bayes machine learning technique. It could be useful for future reference as a template for other projects that require the use of Naive Bayes.
The data used contains two sets of emails: testing (260) and training(702) equally divided into spam and nonspam emails.
The project defines functions to create a dictionary of popular terms by count and a function that extracts features for files from folders of files.

### Configuration Instructions
This project was run on Google Colab, using the Windows10 operating system. 

### Installation Instructions
Google Colab uses Python 3.6.9.
The packages used on this project are as follows:
import os (Python's OS Module)
import numpy as np (NumPy)
from collections import Counter (Collections)
from sklearn.naive_bayes import GaussianNB (SKLearn)
from sklearn.metrics import accuracy_score (SKLearn)

### Operating Instructions
For Google Colab:
Download the data files and .ipynb file. Upload both files to your Google Drive. Open the .ipynb file (Google should default to Colab for opening this file type). 
To read in the data, mount your drive in Google Drive by clicking the folder on the popout menu on the left. Then a set of three icons will appear. The rightmost
icon will allow you to mount your drive. Another way to mount the drive is to run the code in the package import cell that will mount the Google Drive.
If the folder path is the same as the folder path in the Data File Reading Section, the data will automatically read when
the cell is run. All of the code is run by clicking the play button that appears when your cursor is hovering over a code cell. The code is commented, explaining
what the lines do.


### File List
The project includes the Python Notebook and the emails dataset (test-mails and train-mails) folders.
Python Notebook:
Kiejstut_Bunikiewicz_CA02_Naive_Bayes.ipynb

The Emails dataset used is linked here:
https://github.com/ArinB/MSBA-CA01-Spam-Mail-Naibe-Bayes


### Contact Information
Programmer: Kiejstut Bunikiewicz
Email: kbuniki1@lion.lmu.edu

### Known Bugs
I have no bugs to note with my software.

### Troubleshooting
There should not be any issues in the code. If you are running into an issue, please check if your drive is mounted and if the data is found in a file path identical to
the path in the code. 

 