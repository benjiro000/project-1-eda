"""Clean the raw FAOSTAT coffee files and save them in data/clean/.

Usage (from the project-1-eda folder):
    python clean_data.py

Cleaning rules:
- Keep only rows with flag A (official values)
- Keep all countries as they are (including China, Taiwan, Hong Kong, Macao)
- Keep only the useful columns and give them short lowercase names
"""

import pandas as pd

RAW = "data/raw/"
CLEAN = "data/clean/"

# raw file name -> clean file name
FILES = {
    "FAOSTAT_data_en_9-25-2026.csv":     "production_clean.csv",
    "FAOSTAT_data_en_9-25-2026 (1).csv": "trade_clean.csv",
    "FAOSTAT_data_en_9-25-2026 (2).csv": "processed_clean.csv",
}

def clean(df):
    # 1. Keep only official values (flag A)
    df = df[df["Flag"] == "A"]

    # 2. Keep only the columns we need
    df = df[["Area Code (M49)", "Area", "Element Code", "Element", "Unit",
             "Year", "Value", "Flag", "Flag Description"]]

    # 3. Short lowercase column names that are easy to use in SQL
    df = df.rename(columns={
        "Area Code (M49)": "area_code", "Area": "area_name",
        "Element Code": "element_code", "Element": "element_name", "Unit": "unit",
        "Year": "year", "Value": "value",
        "Flag": "flag", "Flag Description": "flag_description"})
    return df

for raw_name, clean_name in FILES.items():
    raw = pd.read_csv(RAW + raw_name, encoding="utf-8-sig")
    cleaned = clean(raw)
    cleaned.to_csv(CLEAN + clean_name, index=False)

    name = clean_name.replace("_clean.csv", "")
    print(f"{name}: {len(raw):,} -> {len(cleaned):,} rows")
    print(f"  missing values: {cleaned.isna().sum().sum()} | duplicate rows: {cleaned.duplicated().sum()}")
    print(f"  Saved: {CLEAN + clean_name}")