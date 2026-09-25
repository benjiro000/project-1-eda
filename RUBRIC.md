![Ironhack logo](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Project 1 — Evaluation Rubric

*SQL: From Data to Insight · Data Science & Machine Learning*

This is the **single source of truth** for how Project 1 is graded. It is adapted from Ironhack's DSML project rubric and uses the same **0–3 scale** as the [Generic Lab Rubric](https://gist.github.com/ironhack-edu/f5cf405db1708c201ad774ee4516bc94), so labs and projects are assessed on one house scale.

Read it on day one. It tells you exactly what is being looked at, and there are no surprises in here that the [brief](README.md) does not already ask for.

## How the scale works

| Score | Meaning |
|---|---|
| **0 — Incomplete** | Not attempted, or attempted in a way that does not meet the requirement. |
| **1 — Fair** | Attempted, with real gaps. |
| **2 — Good** | Meets the requirement competently. **This is the target.** |
| **3 — Excellent** | Exceeds it — depth, rigour or polish beyond what was asked. |

Each level is a **checklist behind a threshold**: "all of these apply", "at least two of the following apply". Read the threshold before the bullets. You are placed at the highest level whose threshold you satisfy.

**Passing is a 2 on every criterion that applies to your project.** Two or three 3s is a strong project; 3s everywhere is rare and is not what you should be aiming for on a four-day project.

## The ten criteria

| # | Criterion | Domain | Where it is judged from |
|---|---|---|---|
| 1 | [Business problem solving](#1--business-problem-solving) | Business Problem Solving | Research questions in notebook 01, the question and conclusions in notebook 03 |
| 2 | [Data preparation](#2--data-preparation) | Data Preparation | The data-quality work in notebooks 01 and 02 |
| 3 | [Data analysis and EDA](#3--data-analysis-and-eda) | Data Analysis | Notebook 01, notebook 03 |
| 4 | [Database design](#4--database-design) | Databases & SQL | ERD, `sql/schema.sql`, the build and load in notebook 02 |
| 5 | [SQL analysis](#5--sql-analysis) | Databases & SQL | `sql/queries.sql`, the analysis in notebook 03 |
| 6 | [Data visualisation](#6--data-visualisation) | Data visualization and communication | Notebook 03, slides |
| 7 | [Code quality and structure](#7--code-quality-and-structure) | Coding | `src/functions.py`, the repo as a whole |
| 8 | [Git and GitHub](#8--git-and-github) | Coding | Commit history |
| 9 | [Documentation](#9--documentation) | Coding | `README.md`, docstrings, comments |
| 10 | [Presentation and demo](#10--presentation-and-demo) | Data visualization and communication | Friday, 7 + 3 minutes |

Criteria **4** and **5** are specific to this project. The other eight are the Ironhack DSML rubric criteria, carried over unchanged except where noted.

> [!NOTE]
> **Machine learning is not assessed here** and neither is **statistical hypothesis testing**. ML is Weeks 4 and 5; hypothesis testing with p-values is Week 4 Day 3, after this project. "Hypothesis" in this rubric means a **business hypothesis** supported by descriptive evidence. You will not be marked down for having no t-test.

---

## 1 | Business problem solving

**Learning outcome:** Identify business problems and opportunities for improvement through data analysis, formulate a well-defined hypothesis, research question or problem statement, and apply appropriate data analysis techniques to answer the question.

**0 — Incomplete** · *all of these apply*
- There is no clear hypothesis or research question defined.
- The analysis techniques applied are inadequate for the data and the business problem.
- No clear or relevant insights are provided.

**1 — Fair** · *at least two of the following apply*
- There is one well-defined hypothesis or research question, neither too broad nor too narrow, analytical, and neither too complex nor too simple.
- The techniques applied are somewhat effective, but there is room for improvement.
- Clear insights are provided to aid decision-making.

**2 — Good** · *at least two of the following apply*
- Includes **at least two** clear and focused hypotheses or research questions.
- Demonstrates a solid understanding of data analysis principles by using techniques that match the data and the business problem, with a clear rationale for their selection.
- Provides clear and relevant insights to aid decision-making.
- The business case is framed: who would care about the findings, and what decision they inform.

**3 — Excellent** · *at least three of the following apply*
- Identifies multiple relevant business problems and opportunities, each with a clearly defined hypothesis or research question.
- Demonstrates exceptional understanding by selecting relevant techniques with outstanding rationale.
- Delivers clear, impactful insights, translating results into actionable recommendations with substantial impact on the business problem.
- Each hypothesis gets an explicit verdict, including where the data could not settle it.

---

## 2 | Data preparation

**Learning outcome:** Identify data quality issues in a dataset and apply appropriate data cleaning, wrangling, and manipulation techniques to address them.

**0 — Incomplete** · *all of these apply*
- No relevant data quality issues found.
- No relevant implementation of data cleaning or wrangling techniques.

**1 — Fair** · *all of these apply*
- Some data quality issues identified, but they are irrelevant, unclear or incomplete.
- Cleaning and wrangling techniques were applied, but they are inadequate for the issues identified.

**2 — Good** · *at least three of the following apply*
- Identified some relevant data quality issues, with clear explanations of their impact on the analysis.
- Implemented appropriate cleaning and wrangling techniques, consistently applied to most identified issues.
- Used a range of cleaning techniques, though omitting some of: null handling, duplicates, dropping unnecessary columns, string manipulation, type formatting.
- Addressed missing data, but did not fully justify the strategy.

**3 — Excellent** · *all of these apply*
- Identified most relevant data quality issues, with clear explanations of their impact.
- Implemented relevant techniques, consistently applied to **all** identified issues.
- Used many cleaning techniques, including null handling, duplicates, dropping unnecessary columns, string manipulation and type formatting.
- Addressed missing data properly, with the strategy fully justified — including where a null was kept because it carries meaning.

---

## 3 | Data analysis and EDA

**Learning outcome:** Apply Exploratory Data Analysis techniques to analyse data, validate hypotheses, draw conclusions and insights.

> Adapted from the DSML rubric: the inferential-statistics bullets have been removed, since hypothesis testing with p-values is taught the week *after* this project.

**0 — Incomplete** · *all of these apply*
- No basic EDA techniques used to analyse the data, validate hypotheses, draw conclusions or communicate findings.
- Improper use of EDA for the data types present.

**1 — Fair** · *at least two of the following apply*
- Basic EDA techniques, but incomplete or inaccurate for analysing the data, validating hypotheses and drawing conclusions.
- Improper or incomplete use of EDA techniques for the data types present.
- Charts and graphs are produced with Python libraries, but they are not visually appealing or easy to understand.

**2 — Good** · *at least two of the following apply*
- Competent use of EDA techniques to analyse the data, validate hypotheses, draw conclusions and communicate findings.
- EDA is appropriate to the data types, though the selection or the understanding of how results affect the analysis could improve.
- Creates visually appealing charts with Python libraries, with room for improvement.
- Univariate analysis of the columns that matter, and bivariate analysis relating them to the question being asked.

**3 — Excellent** · *all of these apply*
- Employs sophisticated EDA techniques to analyse the data, validate hypotheses, draw data-driven conclusions and provide unique insights.
- Comprehensive understanding of the data's characteristics, patterns and relationships: thorough univariate and bivariate analysis, using numerical measures and graphical methods suited to each data type, with outstanding interpretation of how the EDA results shaped the decisions that followed.
- Creates visually appealing and highly informative charts, communicating complex data clearly and concisely.

---

## 4 | Database design

**Learning outcome:** Design a normalised relational schema for an analytical question, implement it, and load data into it with referential integrity intact.

**Skill tag:** *Databases & SQL: SQL Fundamentals*

**0 — Incomplete** · *all of these apply*
- Fewer than three tables, or the tables have no relationships between them.
- No primary keys, or no foreign keys.
- No ERD.

**1 — Fair** · *at least two of the following apply*
- Three or more tables exist, but the split is arbitrary — one flat file cut into pieces that do not relate.
- Primary keys are declared, but foreign keys are missing or not used in the queries.
- An ERD exists but does not match what was actually built.
- The database loaded, but with orphaned foreign keys, or with foreign-key enforcement left off.

**2 — Good** · *all of these apply*
- **At least three tables**: one main table holding the rows being analysed, and at least two that it references.
- Primary and foreign keys declared in `sql/schema.sql`, with types chosen deliberately rather than inferred by pandas.
- Relationships make sense: each lookup table exists because a real categorical column repeated, and the cardinality is right.
- **An ERD, committed as an image and matching the implemented schema.**
- Referential integrity verified — no orphaned foreign keys — and the verification is visible in notebook 02.

**3 — Excellent** · *at least three of the following apply*
- The schema goes beyond one main table with flat lookups: a multi-level hierarchy, a second table of records worth analysing in its own right, or a referenced table carrying real attributes rather than just a label.
- Design decisions are defended in writing, including the ones rejected and why.
- `schema.sql` alone rebuilds the database from nothing, indexes included where they earn their place.
- Edge cases in the relationships are handled explicitly and documented — nullable keys, children with no matching parent — rather than dropped in silence.

---

## 5 | SQL analysis

**Learning outcome:** Answer analytical questions with SQL, using joins, aggregation, grouping and subqueries, and document what each query found.

**Skill tags:** *Databases & SQL: SQL Fundamentals*, *Advanced SQL*

**0 — Incomplete** · *all of these apply*
- Fewer than three queries, or no `.sql` file.
- No joins: everything is a single-table `SELECT`, or the aggregation was done in pandas instead.
- Queries are undocumented.

**1 — Fair** · *at least two of the following apply*
- Three or four queries, or five that are variations on one another.
- Joins and `GROUP BY` appear, but the queries do not connect to the stated research questions.
- `queries.sql` holds the SQL but records no findings.
- The heavy lifting is done in pandas after a `SELECT *`, rather than in SQL.

**2 — Good** · *all of these apply*
- **At least five queries**, each answering a stated research question.
- A range of features used where they fit: `JOIN`, `GROUP BY`, `HAVING`, `ORDER BY`, aggregate functions, and at least one subquery or `CASE`.
- Aggregation happens **in SQL**; Python receives the result and presents it.
- **All queries in `sql/queries.sql`**, each commented with its purpose and what it found.
- Results are correct and interpreted — a number is reported alongside what it means.

**3 — Excellent** · *at least three of the following apply*
- Queries build on each other towards a conclusion rather than standing as five independent facts.
- Advanced SQL used where it genuinely helps: CTEs, window functions, views.
- Groups too small to be meaningful are filtered out with `HAVING`, and the choice of threshold is justified.
- Query results are cross-checked — against a pandas computation, or against a second query approaching it differently.
- Performance considered on a large table: indexes added, or `EXPLAIN QUERY PLAN` consulted, with a note on what changed.

---

## 6 | Data visualisation

**Learning outcome:** Select and use appropriate data visualisation techniques that effectively communicate insights, and create informative visualisations using Python libraries.

**0 — Incomplete** · *at least two of these apply*
- No appropriate visualisation techniques used to communicate insights.
- Visualisations lack clarity; the metrics are not properly identified, defined or plotted.
- Visual design is not informative.

**1 — Fair** · *at least two of these apply*
- Fair use of visualisation to communicate insights, but chart-type selection and design need work.
- Visualisations have some clarity but need better organisation.
- Metrics need to be more clearly defined and plotted.
- Some plots lack detail or have formatting problems — missing titles, unlabelled axes, unreadable ticks.

**2 — Good** · *at least three of these apply*
- **At least two visualisations** with Matplotlib or Seaborn, and solid use of technique to communicate insights effectively.
- Charts are clear, well organised and support decision-making.
- Metrics are clearly defined, measurable and plotted.
- Chart types are appropriate to the data, with clear labelling: title, axis labels, units.
- Each chart carries a written takeaway — what it shows, in one sentence.

**3 — Excellent** · *all of these apply*
- Exceptional use of visualisation to communicate insights effectively.
- Highly effective, with a clear and intuitive layout that conveys the key insight at a glance.
- Metrics expertly defined, measured and plotted, with great attention to detail.
- Expertly designed, with sophisticated chart-type choices and creative visual elements that add meaning rather than decoration.

---

## 7 | Code quality and structure

**Learning outcome:** Write clean, modular, efficient code following best practices, and maintain a clean and logical project structure.

**0 — Incomplete** · *at least three of these apply*
- Much unused code left in the project.
- No functions.
- Naming conventions not applied, making the code hard to read.
- Many hard-coded values or global variables.
- No consistent approach to naming, structure and organisation of files and folders.

**1 — Fair** · *at least four of these apply*
- Some unused code left in the project.
- Functions are either too large or do several things at once.
- Naming conventions barely applied.
- Some hard-coded values or global variables.
- Some files and folders are organised appropriately; others need work.

**2 — Good** · *at least four of these apply*
- Little unused code left.
- **Functions are modular and reusable, and live in `.py` files** — `src/functions.py`, not pasted into cells.
- Naming conventions well applied, in both Python and SQL.
- Few hard-coded values or global variables.
- Most files and folders organised appropriately, and **the notebooks, `src/` and `sql/` separation is respected**: logic in `.py`, queries in `.sql`, narrative in the notebook.

**3 — Excellent** · *all of these apply*
- No unused code left.
- Functions are cleanly modular and reusable, each doing one thing, saved in `.py` files.
- Naming conventions applied consistently throughout.
- No hard-coded values or magic strings; paths and configuration are defined in one place.
- All files and folders organised appropriately, and the notebooks run top to bottom on a fresh kernel.

---

## 8 | Git and GitHub

**Learning outcome:** Save and track changes in the source code using Git and GitHub.

**0 — Incomplete** · *all of these apply*
- Zero or one commit in total.
- Commit messages provide no useful information.

**1 — Fair** · *all of these apply*
- At least two commits made during the project.
- Commit messages are unclear and ambiguous.

**2 — Good** · *at least two of these apply*
- Several commits made during the project, but fewer than one per project day.
- Commit messages are clear and accurately describe the changes.
- Working in a pair, both people have commits in the history.
- No data files committed — `data/` stayed ignored.

**3 — Excellent** · *all of these apply*
- **At least one commit per project day**, from each person if you are working in a pair.
- Atomic commits with accurate, precise descriptions, consistently.
- Branches used for development rather than committing everything straight to `main`.

---

## 9 | Documentation

**Learning outcome:** Document the project's features, configuration and technical specifications.

**0 — Incomplete** · *all of these apply*
- No attempt to document the project in a README.
- No documentation of the code or functions.

**1 — Fair** · *at least two of these apply*
- A partially completed README.
- Functions partially documented, with incomplete docstrings.
- Few comments explaining the rationale or logic behind the code.

**2 — Good** · *all of these apply*
- **A well-structured, clear README**, written for *your* project — the question, the data and its licence, the findings, and how to run it. The template brief has been replaced, not left in place.
- Functions documented with accurate docstrings.
- Enough comments to explain the rationale, logic and main ideas.

**3 — Excellent** · *all of these apply*
- A fully comprehensive, well-structured README that someone could follow from clone to conclusion without asking a question.
- Functions documented with complete docstrings — parameters, returns, and the decisions the caller has to make.
- Clear, concise comments explaining purpose and functionality, addressing *why* rather than restating *what*.

---

## 10 | Presentation and demo

**Learning outcome:** Build a presentation and perform a demo to deliver your results.

Format: **7 minutes of slides plus a 3-minute live demo**, presented from your own machine by sharing your screen. Any slide tool.

**0 — Incomplete** · *at least two of these apply*
- The presentation lacks clear structure and purpose, making the results hard to follow.
- The demo is poorly executed and does not communicate the results.
- No storytelling, making the presentation hard to engage with.

**1 — Fair** · *at least two of these apply*
- The presentation has some structure, but would benefit from better organisation and clearer presentation of the findings behind the conclusions.
- The demo communicates the results adequately, but could be more polished, with better pacing.
- Storytelling is present but not used effectively.

**2 — Good** · *at least three of these apply*
- Clear structure and purpose, effectively communicating the results.
- The demo is engaging, well rehearsed, and stays within the allocated time.
- Storytelling techniques are well incorporated and add to the audience's engagement.
- Conclusions and next steps are included.
- The ERD is shown and the design decisions behind it are defended.

**3 — Excellent** · *at least four of these apply*
- Highly compelling, with a clear message and a well-structured narrative.
- Flawlessly executed demo, showcasing the results memorably and using the time proficiently.
- Storytelling expertly used to build a narrative that deepens the audience's understanding.
- Conclusions and next steps included, alongside the strengths and limitations of the data and recommendations for further analysis.
- Visualisation used in an innovative and meaningful way to support the findings.

---

## Bringing your own dataset

A group working on their own data is assessed on **exactly these criteria** — there is no separate, easier or harder rubric.

The condition in the [brief](README.md#choose-your-data) is what keeps that fair: your data must support **at least two genuinely related tables**. Without a real relationship, criterion 4 has nothing to assess and criterion 5 has nothing to join, and no amount of good work elsewhere makes those up. Clear the dataset with your teacher on launch day.

## Attribution

Two of the three provided datasets are [**CC BY 4.0**](https://creativecommons.org/licenses/by/4.0/) — [Inside Airbnb](http://insideairbnb.com) and [Online Retail II](https://doi.org/10.24432/C5CG6D). Attribution is a condition of the licence, not a formality: name the source and the licence in your README and on your data-acquisition slide. The exact lines to use are in [`data/README.md`](data/README.md). A missing attribution counts against criterion 9.

---

## A note on flexibility

Carried over from Ironhack's project rubric, and it applies here too:

> In this agnostic project rubric, it is important to acknowledge that each project may have unique characteristics and requirements. As such, it is understood that not all learning outcomes or criteria points listed in the rubric will be applicable to every project.
>
> Students should focus on relevant outcomes and criteria for self-assessment, while teachers should consider project-specific aspects for evaluation. This approach ensures a tailored assessment aligned with the unique requirements of each project.

In practice: if a criterion genuinely does not apply to your project, say so in your README and explain why, rather than leaving a gap for the reader to interpret.
