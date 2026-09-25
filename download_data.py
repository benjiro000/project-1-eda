"""Download the raw data for Project 1 into data/raw/.

Usage
-----
    python download_data.py payments
    python download_data.py airbnb
    python download_data.py airbnb --city madrid
    python download_data.py retail
    python download_data.py all

Nothing in data/ is committed, so this script is how anyone reproduces your
project: they clone the repo, run it, and have the same files you had.

See data/README.md for what each dataset contains and how it is licensed.
"""

import argparse
import io
import shutil
import sys
import urllib.parse
import urllib.request
import zipfile
from pathlib import Path

RAW = Path(__file__).parent / "data" / "raw"

# Inside Airbnb re-publishes every city roughly quarterly and the snapshot date
# is part of the URL, so an old date returns 403 rather than a helpful error.
# To bump it: open https://insideairbnb.com/get-the-data/, find your city, and
# copy the date out of one of its download links.
AIRBNB_SNAPSHOTS = {
    "barcelona": ("spain/catalonia/barcelona", "2026-06-24"),
    "madrid": ("spain/comunidad-de-madrid/madrid", "2026-06-20"),
}

PAYMENTS_BASE = (
    "https://raw.githubusercontent.com/ironhack-labs/"
    "project-1-ironhack-payments-2-en/main/project_dataset/"
)

# The filenames in that repo contain spaces, and the fees one has a stray
# trailing " - ", so we rename them to something you can type.
PAYMENTS_FILES = {
    "extract - cash request - data analyst.csv": "cash_requests.csv",
    "extract - fees - data analyst - .csv": "fees.csv",
    "Lexique - Data Analyst.xlsx": "data_dictionary.xlsx",
}

RETAIL_URL = "https://archive.ics.uci.edu/static/public/502/online+retail+ii.zip"

# Inside Airbnb and UCI both reject the default urllib user agent.
HEADERS = {"User-Agent": "Mozilla/5.0 (Ironhack DSML Project 1)"}


def fetch(url: str, dest: Path) -> Path:
    """Download `url` to `dest`, skipping the download if it is already there."""
    if dest.exists():
        print(f"  {dest.name} already downloaded, skipping")
        return dest
    print(f"  downloading {dest.name} ...", end="", flush=True)
    request = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(request) as response, open(dest, "wb") as handle:
        shutil.copyfileobj(response, handle)
    print(f" {dest.stat().st_size / 1e6:.1f} MB")
    return dest


def download_payments() -> None:
    """Ironhack Payments: two related CSVs plus the data dictionary."""
    print("Ironhack Payments")
    for remote_name, local_name in PAYMENTS_FILES.items():
        url = PAYMENTS_BASE + urllib.parse.quote(remote_name)
        fetch(url, RAW / local_name)


def download_airbnb(city: str) -> None:
    """Inside Airbnb: the listings and reviews files for one city snapshot."""
    if city not in AIRBNB_SNAPSHOTS:
        sys.exit(
            f"No snapshot pinned for {city!r}. Known: {', '.join(AIRBNB_SNAPSHOTS)}.\n"
            "Add yours to AIRBNB_SNAPSHOTS using the path and date from "
            "https://insideairbnb.com/get-the-data/"
        )
    path, date = AIRBNB_SNAPSHOTS[city]
    print(f"Inside Airbnb - {city}, snapshot {date}")
    for name in ("listings", "reviews"):
        url = f"https://data.insideairbnb.com/{path}/{date}/data/{name}.csv.gz"
        # Left gzipped on purpose: reviews.csv is 133 MB expanded and pandas
        # reads .gz directly, so pd.read_csv("...reviews.csv.gz") just works.
        fetch(url, RAW / f"{name}.csv.gz")


def download_retail() -> None:
    """Online Retail II: one zipped xlsx with a sheet per year, joined into one CSV."""
    print("Online Retail II (UCI)")
    out = RAW / "online_retail_II.csv"
    if out.exists():
        print(f"  {out.name} already built, skipping")
        return

    try:
        import pandas as pd
    except ImportError:
        sys.exit("This one needs pandas: pip install -r requirements.txt")

    print("  downloading online+retail+ii.zip ...", end="", flush=True)
    request = urllib.request.Request(RETAIL_URL, headers=HEADERS)
    with urllib.request.urlopen(request) as response:
        payload = response.read()
    print(f" {len(payload) / 1e6:.1f} MB")

    with zipfile.ZipFile(io.BytesIO(payload)) as archive:
        name = next(n for n in archive.namelist() if n.endswith(".xlsx"))
        workbook = pd.ExcelFile(io.BytesIO(archive.read(name)))

    print(f"  reading {len(workbook.sheet_names)} sheets (this takes a minute) ...")
    frames = [workbook.parse(sheet) for sheet in workbook.sheet_names]
    combined = pd.concat(frames, ignore_index=True)
    combined.to_csv(out, index=False)
    print(f"  wrote {out.name}: {len(combined):,} rows")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("dataset", choices=["payments", "airbnb", "retail", "all"])
    parser.add_argument(
        "--city",
        default="barcelona",
        help="Inside Airbnb city (default: barcelona)",
    )
    args = parser.parse_args()

    RAW.mkdir(parents=True, exist_ok=True)

    if args.dataset in ("payments", "all"):
        download_payments()
    if args.dataset in ("airbnb", "all"):
        download_airbnb(args.city.lower())
    if args.dataset in ("retail", "all"):
        download_retail()

    print(f"\nDone. Files are in {RAW.relative_to(Path.cwd()) if RAW.is_relative_to(Path.cwd()) else RAW}/")


if __name__ == "__main__":
    main()
