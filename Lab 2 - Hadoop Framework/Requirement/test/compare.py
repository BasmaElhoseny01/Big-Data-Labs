import csv
import sys
import pandas as pd

# Check if the correct number of arguments are provided
if len(sys.argv) != 2:
    print("Usage: python compare.py output.csv")
    sys.exit(1)

# Get file names from command line arguments
space_file_name = sys.argv[1]
comma_file_name = "out_gold.csv"

# Load the two CSV files into DataFrames
df1 = pd.read_csv(space_file_name, header=None ,sep='\t')
df2 = pd.read_csv(comma_file_name,header=None,delimiter=',')

# Compare the two DataFrames
if df1.equals(df2):
    print("Both DataFrames contain the same data.")
else:
    print("The DataFrames contain different data.")

    # Compare the two DataFrames
    df_diff = df1.compare(df2)
    # Display the differences
    print("Differences between the two DataFrames:")
    print(df_diff)
