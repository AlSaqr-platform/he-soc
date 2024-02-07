#!/bin/env python3

import os
import re
import csv

# Regular expressions
regex_patterns = {
    "IMISS": r"IMISS: (\d*)",
    "DMISS": r"DMISS: (\d*)",
    "IF_EMPTY": r"IF_EMPTY: (\d*)",
    "TOT_CYC": r"TOT_CYC: (\d*)",
    "AVG_CYC": r"AVG_CYC: (\d*)"
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
        fieldnames = ['TEST', 'IMISS', 'DMISS', 'IF_EMPTY', 'TOT_CYC', 'AVG_CYC']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for folder in os.listdir(folder_path):
            folder_dir = os.path.join(folder_path, folder, "sim.d")
            if os.path.isdir(folder_dir):
                transcript_file = os.path.join(folder_dir, 'transcript')
                if os.path.exists(transcript_file):
                    data = extract_data(transcript_file)
                    writer.writerow({'TEST': folder, **data})

# Example usage
folder_path = 'testlist'
output_file = 'results.csv'
generate_csv(folder_path, output_file)
