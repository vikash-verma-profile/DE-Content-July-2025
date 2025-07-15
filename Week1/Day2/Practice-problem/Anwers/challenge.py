import os
import pandas as pd
import argparse

def read_csv(filepath):
    return pd.read_csv(filepath)

def clean_data(df):
    df['Salary'] = df['Salary'].fillna(0).astype(int)
    return df

def filter_department(df, department):
    return df[df['Department'].str.lower() == department.lower()]

def save_csv(df, output_path):
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    df.to_csv(output_path, index=False)
    print(f"Saved filtered data to {output_path}")

def main():
    # argparse for dynamic department filtering
    parser = argparse.ArgumentParser(description="ETL: Filter employees by department")
    parser.add_argument(
        "--department", type=str, default="Engineering",
        help="Department to filter (default: Engineering)"
    )
    args = parser.parse_args()
    department_filter = args.department

    # Paths
    input_file = "data/employees.csv"
    output_file = f"output/{department_filter.lower()}_employees.csv"

    # ETL process
    print("Reading data...")
    df = read_csv(input_file)

    print("Cleaning data...")
    df = clean_data(df)

    print(f"Filtering department: {department_filter}")
    filtered_df = filter_department(df, department_filter)

    print("Writing to output...")
    save_csv(filtered_df, output_file)

if __name__ == "__main__":
    main()
