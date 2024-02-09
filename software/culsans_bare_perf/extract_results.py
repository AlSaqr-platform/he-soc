#!/bin/env python3

import os
import re
import csv

# Regular expressions
regex_patterns = {
    "IMISS": r"IMISS: (\d*)",
    "DMISS": r"DMISS: (\d*)",
    "TOT_CYC": r"TOT_CYC: (\d*)",
    "LOADS": r"LOADS: (\d*)",
    "STORES": r"STORES: (\d*)",
    "L1_ACC": r"L1_ACC: (\d*)",
    "L1_EVICT": r"L1_EVICT: (\d*)",
    "INSTR": r"INSTR: (\d*)",
}

# Function to extract data from transcript file using regex
def extract_data(file_path):
    data = {}
    with open(file_path, 'r') as file:
        content = file.read()
        for key, pattern in regex_patterns.items():
            match = re.search(pattern, content)
            if match:
                data[key] = match.group(1)
            else:
                data[key] = "N/A"
    return data

# Function to generate CSV
def generate_csv(folder_path, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        fieldnames = ['TEST', 'IMISS', 'DMISS', 'TOT_CYC', 'AVG_CYC', 'LOADS', 'STORES', 'INSTR', 'L1_ACC', 'L1_EVICT']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        # Create a list to store test data
        test_data = []

        # Extract and store data for each test
        for folder in os.listdir(folder_path):
            folder_dir = os.path.join(folder_path, folder, "sim.d")
            if os.path.isdir(folder_dir):
                transcript_file = os.path.join(folder_dir, 'transcript')
                if os.path.exists(transcript_file):
                    data = extract_data(transcript_file)
                    data['AVG_CYC'] = f"{float(data['TOT_CYC']) / float((data['LOADS'] if 'read' in folder else data['STORES'])):.2f}"
                    test_data.append({'TEST': folder, **data})

        # Sort the test data by test name
        sorted_test_data = sorted(test_data, key=lambda x: x['TEST'])

        # Write sorted data to the CSV file
        for test_row in sorted_test_data:
            writer.writerow(test_row)

# Example usage
folder_path = 'testlist'
output_file = 'results.csv'
generate_csv(folder_path, output_file)
