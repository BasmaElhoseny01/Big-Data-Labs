import csv

# Input and output file paths
input_file = 'output.csv'
output_file = 'output_comma_separated.csv'

# Open input and output files
with open(input_file, 'r', newline='') as f_in, open(output_file, 'w', newline='') as f_out:
    # Create CSV reader and writer objects
    reader = csv.reader(f_in, delimiter=' ')
    writer = csv.writer(f_out, delimiter=',')

    # Write rows with comma-separated values
    for row in reader:
        writer.writerow(row)