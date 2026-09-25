# The datasets

Three options, all licence-clear and all rich enough to normalise into 3+ tables. Pick one on launch day and stay with it.

Nothing in `data/` is committed. Download with the script at the repo root:

```bash
python download_data.py payments    # or: airbnb, retail
python download_data.py all         # all three, if you want to browse before choosing
```

Files land in `data/raw/`. Your cleaned, one-CSV-per-table output goes in `data/clean/`. Both are gitignored, so someone cloning your repo re-runs the script rather than pulling 130 MB out of GitHub.

---

## Option 1 — Ironhack Payments · *gentler start*

Real usage data from Ironhack Payments, a cash-advance service. **Two related tables ready-made**, which is the friendliest starting point: the join already exists, so you spend your Tuesday on lookup tables rather than on getting a join to work at all.

| File | Rows | What it is |
|---|---|---|
| `cash_requests.csv` | 23,970 | One row per cash advance: amount, status, user, and the dates it moved through. |
| `fees.csv` | 21,061 | One row per fee charged, with `cash_request_id` pointing at the request it belongs to. |
| `data_dictionary.xlsx` | — | What every column means. Read this first. |

**Business questions it supports.** How often do users come back, and does that change by signup cohort? What share of advances end in a payment incident, and is it worse for instant transfers than regular ones? Which fee types generate the most revenue? Are users who pay a postpone fee more or less likely to default later?

> [!IMPORTANT]
> **Two tables is one short of the 3-table minimum — you must normalise.** This is the work, not a problem with the dataset. Every one of these is a ready-made lookup table (Option A in the brief):
>
> | Source column | Distinct values | Suggested table |
> |---|---|---|
> | `cash_requests.status` | 7 | `request_status` |
> | `cash_requests.transfer_type` | 2 | `transfer_type` |
> | `cash_requests.recovery_status` | 4 | `recovery_status` |
> | `fees.type` | 3 | `fee_type` |
> | `fees.status` | 4 | `fee_status` |
> | `fees.category` | 2 | `fee_category` |
> | `fees.charge_moment` | 2 | `charge_moment` |
>
> There is also a `users` table hiding in `cash_requests.user_id` (10,798 distinct users): aggregate first-request date and request count per user into its own table, and you have a table that describes something real rather than just a label with an id attached.
>
> Pick three or four of these, not all seven. A schema with eight two-row tables is worse design than one with three meaningful ones, and the rubric grades whether your relationships make sense.

**Licence.** Ironhack's own teaching dataset, published in [`ironhack-labs/project-1-ironhack-payments-2-en`](https://github.com/ironhack-labs/project-1-ironhack-payments-2-en) for use in this bootcamp. Use it for your coursework; do not republish it elsewhere.

<br>

## Option 2 — Inside Airbnb · *middle · the reference solution uses this one*

A quarterly snapshot of every Airbnb listing in a city. Barcelona is the default; the script takes any city Inside Airbnb publishes.

| File | Rows (Barcelona) | What it is |
|---|---|---|
| `listings.csv` | 15,293 | One row per listing, 90 columns: price, room type, neighbourhood, district, host, review scores, availability. |
| `reviews.csv` | 1,033,523 | One row per review: `listing_id` and `date`. A second table worth analysing on its own, joined on a key that already exists. |

**Business questions it supports.** Which districts command the highest price per night, and does that hold once you adjust for how many people a listing sleeps? Do entire homes score better on reviews than private rooms? Where is hosting most professionalised — which neighbourhoods have the highest listings-per-host? How has review volume moved over time, and did some neighbourhoods peak earlier than others?

**Why it is the middle option.** `listings.csv` has an obvious two-level hierarchy in it — `neighbourhood_group_cleansed` is the district, `neighbourhood_cleansed` is the neighbourhood inside it — so your joins mean something instead of just resolving a code to a label. But you do have to find it, and `price` arrives as a string like `"$120.00"` that needs cleaning before it is a number.

```bash
python download_data.py airbnb                              # Barcelona, the pinned snapshot
python download_data.py airbnb --city madrid                # another city
```

`reviews.csv.gz` is 133 MB compressed. The script keeps the `.gz` and reads it directly — pandas handles gzip transparently, so there is no need to expand it.

**Licence.** [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). You must credit the source. Put this line in your README and on your data-acquisition slide:

> Data from [Inside Airbnb](http://insideairbnb.com), licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

<br>

## Option 3 — Online Retail II · *hardest · design it all yourself*

Two years of transactions from a UK online gift retailer. **1,067,371 rows in a single flat sheet** — no tables, no keys, no hierarchy. Everything is yours to design.

| File | Rows | What it is |
|---|---|---|
| `online_retail_II.csv` | 1,067,371 | `Invoice`, `StockCode`, `Description`, `Quantity`, `InvoiceDate`, `Price`, `Customer ID`, `Country`. The script concatenates both year sheets. |

**Business questions it supports.** Who are the highest-value customers and what share of revenue do they account for? Which products are bought together? How does revenue move across the year, and which countries drive the growth? What proportion of transactions are returns (negative `Quantity`), and which products are returned most?

**Why it is the hardest.** A million rows is slow if you are careless, and the normalisation is genuinely open: `customers`, `products`, `invoices` and `invoice_lines` is one reasonable design, but you have to notice that an invoice is a header with many lines before you can model it. There are also real data-quality traps — negative quantities are returns, missing `Customer ID` means a guest checkout, and some `StockCode` values are not products at all (`POST`, `BANK CHARGES`, `M` for manual).

**Licence.** [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Cite it:

> Chen, D. (2019). *Online Retail II* [Dataset]. UCI Machine Learning Repository. <https://doi.org/10.24432/C5CG6D>. Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

<br>

---

## Bringing your own dataset

You may, and you are graded on exactly the same [rubric](../RUBRIC.md). Two conditions:

- **It must support at least two genuinely related tables** — a real foreign-key relationship, not one flat file you split arbitrarily. Without that, the *Database design* criterion has nothing to assess.
- **Its licence must permit educational use.** Check before you start. Anything marked *NonCommercial* is a grey area for a bootcamp; anything with no stated licence at all is a no.

Clear it with your teacher on launch day. Not on Wednesday.

## Attribution, in one place

Whatever you use, your project README must name the source and its licence. For the two CC BY datasets that is a requirement of the licence, not a nicety — attribution is the only thing CC BY asks of you in return.
