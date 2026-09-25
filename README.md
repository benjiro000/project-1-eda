![Ironhack logo](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Project 1 | SQL: From Data to Insight

*Data Science & Machine Learning — Week 3*

Build a complete data pipeline from raw data to visual insights. You will design a relational database, write SQL queries, and tell a story with data.

`SQLite` · `Python` · `Pandas` · `SQL queries` · `Data visualization` · `ETL pipeline`

---

## Overview

In this project you build a complete data pipeline — from raw data to meaningful insights through SQL and Python visualisations. You design a relational database, populate it with real-world data, run analytical queries, and present your findings to the class.

- **Format** — in pairs or on your own. Working in a pair, divide tasks daily and communicate often.
- **Duration** — 4 working days + presentation on Friday morning.
- **Tools** — Python (Pandas, Matplotlib/Seaborn), SQLite, DB Browser for SQLite, GitHub, Jupyter Notebooks.
- **Repository** — click **Use this template** at the top of this page to create your own repo.

### The goal

Craft a data story. Take data you find interesting, ask questions about it, design a database to hold it, use SQL to find answers, and visualise your insights. By the end of the week you should be able to present a clear narrative backed by data.

> [!IMPORTANT]
> Choose your dataset on launch day and stick with it. Switching datasets mid-week is the single most common way to lose this project.

<br>

## The pipeline at a glance

Your project follows a classic ETL pipeline (Extract, Transform, Load) extended with analysis and reporting. This is the journey your data will take:

1. **Choose & extract** — pick one of the three datasets below (or bring your own). Define your research questions.
2. **Explore & design** — understand your fields. Sketch an ERD. Design a schema with 3+ tables.
3. **Clean & transform** — wrangle in Python: handle missing values, fix types, normalise categories.
4. **Load into SQL** — create the database and write each table into it with `to_sql`.
5. **Query & analyse** — write SQL using `JOIN`, `GROUP BY`, `HAVING`, subqueries and aggregations.
6. **Visualise & report** — build Python visualisations and compile everything into a notebook report.
7. **Present** — design slides and present your story to the class on Friday morning.

The three notebooks in this template map onto that pipeline: `01_eda.ipynb` is steps 1–2, `02_processing.ipynb` is steps 3–4, and `03_hypothesis_and_visualization.ipynb` is steps 5–6.

<br>

## Which SQL engine

**You work in SQLite.** The whole database is a single `.db` file, there is no server to start, and `pandas.to_sql` writes straight into it — which is what Week 2 Day 4 covered. You inspect the file in **DB Browser for SQLite**.

**MySQL is a valid alternative.** If you prefer to run MySQL Workbench, everything in this brief still applies: swap `sqlite3.connect(...)` for a SQLAlchemy MySQL engine, and use `CREATE DATABASE` / `USE` in your schema script. The setup guide is in the **SQL Installation** unit in the portal. Two syntax differences to remember:

```sql
SELECT * FROM mydb.listings;    -- MySQL: database.table
SELECT * FROM listings;         -- SQLite: the file IS the database

CONCAT(city, ', ', country)     -- MySQL
city || ', ' || country         -- SQLite (and PostgreSQL, and MySQL too)
```

Whichever you pick, pick it on day one and keep it. Your grade does not depend on the engine.

<br>

## Choose your data

Three datasets, all licence-clear and all rich enough to normalise. They form a difficulty ladder — read [`data/README.md`](data/README.md) for the full description of each, how to download it, and its licence.

| | Dataset | Difficulty | Licence | What you get |
|---|---|---|---|---|
| **1** | **Ironhack Payments** | Gentler start | Ironhack teaching data | Two related tables ready-made (cash requests and fees). You normalise out lookup tables to reach 3+. |
| **2** | **Inside Airbnb** (Barcelona, Madrid, or another city) | Middle | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) | One wide listings file plus a reviews file. A natural district → neighbourhood hierarchy to model. |
| **3** | **Online Retail II** (UCI) | Hardest | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) | 1.07M transaction rows in one flat sheet. Everything — customers, products, invoices — is yours to design. |

The two CC BY datasets **require attribution** in your README and on your data-acquisition slide. That is a condition of the licence, not a nicety, and it is graded — the exact lines to use are in [`data/README.md`](data/README.md).

Fetch whichever you choose with the included script:

```bash
python download_data.py payments    # or: airbnb, retail
```

Files land in `data/raw/`, which is gitignored. **Do not commit data.** Anyone cloning your repo runs the same script.

> [!NOTE]
> **Bringing your own dataset?** You may, and you are graded on exactly the same rubric. Two rules: it must support **at least two genuinely related tables** so the database-design work is real, and its licence must permit educational use. Clear it with your teacher on launch day, not on Wednesday.

<br>

## Day-by-day breakdown

Launch day (Friday of Week 2) is when you settle who you are working with, pick your dataset and click **Use this template** — so Monday starts with the data already downloaded.

### Day 1 — Questions, extraction and EDA

The decisions you make today shape your entire week.

- **Firm up your research questions.** You drafted them on launch day. Today you commit to at least **2 clear questions**, checked against what you now know is actually in the data — a question you cannot answer with the columns in front of you is better found today than on Wednesday.
- **Frame the business case.** Who would care about these findings? What decisions could they inform?
- Finish **`01_eda.ipynb`**: shape, dtypes, missing values, duplicates, distributions.
- Pay attention to the **categorical cardinality** section. Columns with few repeated values are your lookup tables tomorrow.

> [!TIP]
> By the end of today you should be able to name your tables out loud. If you cannot, you are behind — Tuesday is the heaviest day of the week and it assumes you arrive with a table list.

### Day 2 — Database design and loading

Today you move from raw data to a structured database. This is the core engineering day.

- **Design your ERD.** Identify primary keys, foreign keys and table relationships. Draw it in [Excalidraw](https://excalidraw.com) or [draw.io](https://app.diagrams.net) and commit the image to your repo.
- **Break your data into 3+ tables.** The guide further down shows exactly how.
- Clean in Python: handle nulls, fix types, standardise categories, remove duplicates.
- Export one CSV per table into `data/clean/`.
- Write `sql/schema.sql` with your `CREATE TABLE` statements, then load each table with `to_sql`.
- **Validate foreign keys** before you move on. A dangling key is the failure that costs people Wednesday.

> [!IMPORTANT]
> **Load order matters.** Start with the tables that have no foreign keys — your lookup tables — then load the main table that references them. And watch `if_exists`: `"replace"` drops the table and everything in it.

### Day 3 — SQL queries and analysis

With your database loaded, it is time to query. This is where the insights emerge.

- Write **at least 5 insightful queries** that address your research questions.
- Use a variety of features: `JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `CASE`, subqueries.
- Summarise with aggregations: `AVG`, `COUNT`, `SUM`, `MIN`, `MAX`.
- **Document your queries** in `sql/queries.sql` with a comment on each saying what it does and what you found.
- Pull the results into Pandas with `pd.read_sql` and start building the story in **`03_hypothesis_and_visualization.ipynb`**.

### Day 4 — Visualisation, report and presentation

The final push. Turn your findings into visuals and a narrative.

- Create **at least 2 visualisations** with Matplotlib or Seaborn that support your key findings.
- Finish `03_hypothesis_and_visualization.ipynb`. **This notebook is your report deliverable**: text, code, outputs and charts telling the full story.
- Build your slides in whatever tool you like — you present by sharing your own screen.
- Finalise the repo: clean up code, write your README, organise files.
- Practise the presentation. You have **7 minutes of slides plus a 3-minute live demo**.

> [!NOTE]
> **Keep the pipeline modular.** Reusable logic goes in `src/functions.py`, queries go in `sql/queries.sql`, and the notebook carries the narrative. That separation is one of the graded criteria, and it is why this template is laid out the way it is.

<br>

## How to structure your database

The core challenge is designing a database with at least 3 tables. You have two approaches.

### Option A — split one dataset into 3 tables (recommended)

Start from a single dataset and normalise it by extracting categorical columns into lookup tables. This is the recommended path: more controlled, easier to manage.

1. **Pick your main dataset.** Something with enough columns and rows to be interesting.
2. **Identify categorical columns.** Look for columns with a small number of repeated values — categories, types, locations, ratings.
3. **Create lookup tables.** For each one, build a table with an ID and the descriptive value. Replace the original column in the main table with a foreign key.
4. **Design the ERD.** Draw the relationships. Define primary and foreign keys.
5. **Clean and export.** Clean each DataFrame and export them as separate CSVs.

### Option B — combine multiple datasets (advanced)

Use two or more datasets that share a common field and can be joined. Harder, because matching independent sources takes more cleaning and careful alignment.

> [!TIP]
> If you go with Option B, make sure the datasets share at least one column with **matching values** — country names, dates, product IDs. If merging turns out to be too complex, you can show the relationship through visualisations instead.

<br>

## Worked example: the Titanic dataset

Let's walk through Option A on the classic Titanic dataset, splitting one table into three. Titanic is deliberately **not** one of your three options, so this shows you the method without solving your project for you.

### Step 1 — start with the original dataset

Titanic has columns like `PassengerId`, `Name`, `Sex`, `Age`, `Pclass`, `Fare`, `Embarked`, `Survived`.

| PassengerId | Name | Pclass | Embarked | Age | Survived |
|---|---|---|---|---|---|
| 1 | Braund, Owen | 3 | S | 22 | 0 |
| 2 | Cumings, John | 1 | C | 38 | 1 |
| 3 | Heikkinen, Laina | 3 | S | 26 | 1 |

### Step 2 — identify columns to extract

`Pclass` (1, 2, 3) and `Embarked` (C, Q, S) are categorical columns with a small set of repeated values. Perfect candidates for lookup tables.

### Step 3 — create the lookup tables

**`ticket_class`**

| class_id | class_name |
|---|---|
| 1 | 1st Class |
| 2 | 2nd Class |
| 3 | 3rd Class |

**`port`**

| port_id | port_name |
|---|---|
| 1 | Cherbourg |
| 2 | Queenstown |
| 3 | Southampton |

### Step 4 — update the main table with foreign keys

Replace `Pclass` with `class_id` (FK) and `Embarked` with `port_id` (FK).

**`passengers`**

| passenger_id (PK) | name | class_id (FK) | port_id (FK) | age | survived |
|---|---|---|---|---|---|
| 1 | Braund, Owen | 3 | 3 | 22 | 0 |
| 2 | Cumings, John | 1 | 1 | 38 | 1 |

### Step 5 — the ERD

```
┌──────────────────────┐          ┌──────────────────────┐
│ ticket_class         │          │ port                 │
├──────────────────────┤          ├──────────────────────┤
│ PK class_id     INT  │          │ PK port_id      INT  │
│    class_name   TEXT │          │    port_name    TEXT │
└──────────┬───────────┘          └──────────┬───────────┘
           │ 1                               │ 1
           │                                 │
           │ N                               │ N
        ┌──┴─────────────────────────────────┴──┐
        │ passengers                            │
        ├───────────────────────────────────────┤
        │ PK passenger_id  INT                  │
        │    name          TEXT                 │
        │ FK class_id      INT                  │
        │ FK port_id       INT                  │
        │    age           REAL                 │
        │    survived      INT                  │
        └───────────────────────────────────────┘
```

Each passenger belongs to one ticket class and one port: two 1:N relationships. Draw yours in Excalidraw or draw.io and commit it as an image.

### Step 6 — write the SQL schema

In `sql/schema.sql`:

```sql
CREATE TABLE IF NOT EXISTS ticket_class (
    class_id    INTEGER PRIMARY KEY,
    class_name  TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS port (
    port_id     INTEGER PRIMARY KEY,
    port_name   TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS passengers (
    passenger_id  INTEGER PRIMARY KEY,
    name          TEXT,
    class_id      INTEGER,
    port_id       INTEGER,
    age           REAL,
    survived      INTEGER,
    FOREIGN KEY (class_id) REFERENCES ticket_class(class_id),
    FOREIGN KEY (port_id)  REFERENCES port(port_id)
);
```

### Step 7 — load the tables

In notebook 02, load each cleaned DataFrame in dependency order:

```python
import sqlite3
conn = sqlite3.connect("data/titanic.db")

ticket_class.to_sql("ticket_class", conn, if_exists="append", index=False)   # no FKs
port.to_sql("port", conn, if_exists="append", index=False)                   # no FKs
passengers.to_sql("passengers", conn, if_exists="append", index=False)       # has FKs, goes last
```

Then verify: row counts per table, and one test join that returns rows.

<br>

## Deliverables

Your main deliverable is your GitHub repo, created from this template, containing:

| Item | Description |
|---|---|
| `README.md` | Project documentation. Anyone reading it should understand the project without browsing all the files. Replace this brief with your own. |
| `sql/schema.sql` | Your `CREATE TABLE` statements and any other schema definitions. |
| ERD diagram | An image showing tables, columns, primary keys, foreign keys and relationships. Excalidraw or draw.io. Commit it and link it from your README. |
| `sql/queries.sql` | All the queries used in your analysis, with comments explaining the purpose and the finding. |
| `src/functions.py` | Reusable functions for cleaning, transformation and loading. Your logic lives in functions, not pasted into cells. |
| `notebooks/03_hypothesis_and_visualization.ipynb` | **The report.** The complete data story: text, clean code, outputs and visualisations. Separate from the pipeline code in notebooks 01 and 02. |
| `download_data.py` | Left as-is, or extended if you brought your own data. It is how someone else reproduces your work without you committing the dataset. |
| Slides | Linked or committed in your README, so they can be read after the presentation. Any tool. |

### Minimum requirements

Your project must meet all of these to pass:

- **Research** — define at least **2 clear research questions** and analyse the data to address them coherently.
- **Data source** — use one of the three provided datasets, or your own approved one. A **second source is a bonus**, not a requirement.
- **Database** — at least **3 tables**, proper primary and foreign keys, and clear relationships.
- **Data quality** — clean, format and restructure the data to maintain consistency and accuracy.
| **SQL analysis** | At least **5 insightful queries** using `JOIN`, `GROUP BY`, `HAVING`, subqueries and aggregations. |
| **Visualisation** | At least **2 visualisations** with Matplotlib or Seaborn. |

The full grading rubric is in [`RUBRIC.md`](RUBRIC.md). Read it on day one — it tells you exactly what is being evaluated.

> [!NOTE]
> "Hypotheses" here means **business hypotheses** — "entire homes earn more per night than private rooms", which you support with descriptive evidence. Statistical hypothesis testing with p-values comes in Week 4. You are not expected to run a t-test, and you will not be graded on one.

<br>

## Advanced features (optional)

Not required, but they will strengthen your project:

- **Scalable pipeline** — functions that form a complete ETL, so fresh data can be reprocessed automatically.
- **Data quality checks** — auxiliary functions that validate integrity as the database is updated.
- **Advanced SQL** — views, window functions (`ROW_NUMBER`, `RANK`, `LAG`/`LEAD`) and CTEs.
- **Interactive dashboards** — 5+ visualisations in Plotly, embedded in Streamlit or Dash.
- **Performance optimisation** — add indexes, read the query plan with `EXPLAIN QUERY PLAN`, optimise accordingly.
- **Multi-source integration** — merge a second source on a matching key for a richer analysis. This is the enrichment bonus: an API call or a small scrape that adds a column your main dataset lacks.

<br>

## Coding best practices

- **Modularise.** Python logic in `.py` files with reusable functions. SQL in `.sql` files. The notebook is for the narrative.
- **Name clearly.** Descriptive names for variables, functions, tables and columns. `snake_case` in both Python and SQL.
- **Clean up.** Remove unused imports, commented-out code and test cells before submitting.
- **Comment thoughtfully.** Explain *why*, not *what*. A comment should add context the code does not already carry.
- **Commit often.** Small, frequent commits with descriptive messages. Working in a pair, your partner should know what you worked on from the history alone.

<br>

## Presentation guidelines

| Component | Duration |
|---|---|
| Talking with slides | 7 minutes |
| Live demo | 3 minutes |
| **Total** | **10 minutes** |

> [!IMPORTANT]
> **You present from your own machine by sharing your screen.** Use whatever slide tool you prefer. Have everything open and ready before your slot — the clock does not wait while you find a file. Put a link to the slides, or the exported file, in your README so they can be read afterwards.

### Suggested slide structure (~10 slides)

1. **Title** — project title and your name or names.
2. **Project overview** — your dataset, the business problem, your guiding hypotheses.
3. **Data acquisition** — sources used, challenges while sourcing, how any supplemental data aligns with the primary data.
4. **Database design** — show your ERD. Explain the relationships and defend your design decisions.
5. **SQL insights** — showcase 1–2 standout findings. Highlight the challenging or revealing queries.
6. **Visualisations** (1–2 slides) — your main charts and what they reveal.
7. **Conclusions** — do the findings support or refute your hypotheses? What are the business implications?
8. **Biggest obstacle** — what went wrong, what you learned, how it shaped the project.
9. **Closing** — project title, your name or names, thank you.

<br>

## Repo layout

The notebooks are laid out in sections with the intent of each one written down, and `src/functions.py` holds three empty stubs that exist only to show the shape. Everything else is empty on purpose. **This is a place to start, not a template to fill in** — rename things, add sections, delete the ones that do not fit your data. You are graded on the analysis, not on how closely you followed the scaffold.

```
.
├── README.md                                    this brief — replace it with your own
├── RUBRIC.md                                    how you are graded
├── requirements.txt
├── download_data.py                             fetches your chosen dataset into data/raw/
├── data/
│   ├── raw/                                     downloaded data, gitignored
│   ├── clean/                                   one CSV per table, output of notebook 02
│   └── README.md                                the three options, how to get them, licences
├── notebooks/
│   ├── 01_eda.ipynb                             explore and question
│   ├── 02_processing.ipynb                      clean, design, load
│   └── 03_hypothesis_and_visualization.ipynb    query, visualise, report
├── src/
│   └── functions.py                             your reusable logic
└── sql/
    ├── schema.sql                               CREATE TABLE statements
    └── queries.sql                              your analysis queries
```

## Getting set up

```bash
# 1. Click "Use this template" above, then clone YOUR new repo
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>

# 2. Check you already have the libraries - a current Anaconda install does.
#    If this prints, skip to step 3 and install nothing.
python -c "import pandas, numpy, matplotlib, seaborn, openpyxl; print('all present')"

#    Only if that failed. See the note in requirements.txt first: running pip
#    against a conda environment can downgrade packages you did not ask about.
pip install -r requirements.txt

# 3. Download your dataset
python download_data.py payments        # or: airbnb, retail

# 4. Open the first notebook
jupyter lab notebooks/01_eda.ipynb
```

<br>

## Tips for success

1. **Choose your data on launch day and commit to it.** Switching mid-week costs you time you do not have.
2. **Break the project into small tasks.** Many simple steps are easier to manage than one giant one.
3. **Commit early and often.** Name your commits clearly — in a pair, so your partner knows what changed; on your own, so you do.
4. **Explore the data before designing the database.** Understanding the data is half the work.
5. **Ask for help early.** Stuck for more than 30 minutes? Reach out to a classmate, your TA or your teacher.
6. **Test your SQL incrementally.** Start simple, then build complexity.
7. **Make your report notebook tell a story** — intro, exploration, findings, conclusion. Imagine a non-technical reader.
8. **Practise the presentation out loud** at least once before Friday. Time yourselves.
9. **Read [`RUBRIC.md`](RUBRIC.md).** It tells you exactly what is being evaluated.

Good luck. Make something you are proud of.
