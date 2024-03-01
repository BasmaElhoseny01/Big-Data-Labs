import csv

def compute_sum(filename):
    sums = {}
    with open(filename, 'r') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            if len(row) >= 2:
                id = row[0]
                value = int(row[1])
                sums[id] = sums.get(id, 0) + value
    return sums

def write_output(sums, output_filename):
    with open(output_filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['ID', 'Sum'])
        for id, sum_value in sums.items():
            writer.writerow([id, sum_value])


if __name__ == "__main__":
    filename = "in.csv"  # Replace with the path to your CSV file
    output_filename= "out_gold.csv"
    sums = compute_sum(filename)

    for id, sum_value in sums.items():
        print(f"ID: {id}, Sum: {sum_value}")
    write_output(sums, output_filename)