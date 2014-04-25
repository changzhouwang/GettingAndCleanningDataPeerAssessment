README
======

Before running run_analysis.R, you need to download `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` into your working directory, e.g.,

    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','harusds.zip','wget')

Then, unzip the downloaded file into current working directory, e.g.,

    unzip('harusds.zip')

Now, ensure that you see the `UCI HAR Dataset` child directory in your current working directory. 

Next, make sure the `run_analysis.R` file is located in your current working directory. Finally, you can run the script inside R console, e.g.,

    source('run_analysis.R')

You should see two new files created in the current working directory: `UCI_HAR_Mean_and_StandardDeviation_Measurements.csv` and `UCI_HAR_Mean_per_Activity_and_Subject.csv`.




