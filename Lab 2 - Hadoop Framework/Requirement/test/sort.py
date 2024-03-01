import csv

# Read the CSV file
with open('out_gold.csv', 'r') as file:
    csv_reader = csv.reader(file)
    data = list(csv_reader)

# Sort the data based on the first column as string values
sorted_data = sorted(data, key=lambda x: str(x[0]))

# Write the sorted data back to the CSV file
with open('out_gold_sorted.csv', 'w', newline='') as file:
    csv_writer = csv.writer(file)
    csv_writer.writerows(sorted_data)
