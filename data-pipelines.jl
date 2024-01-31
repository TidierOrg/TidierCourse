### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ d6823989-bb85-400d-87ec-2a365260f5fb
# ╠═╡ show_logs = false
using Pkg; Pkg.activate(".."); Pkg.instantiate()

# ╔═╡ 51e24e5e-cfc7-4b02-978c-505e21e6df43
using PlutoUI: TableOfContents

# ╔═╡ 2eec5998-bb36-11ee-2283-67ea47c4f5ed
md"""
# Tidier Course: Data Pipelines
"""

# ╔═╡ a4baabcd-d425-449e-b7bb-f8b776582330
html"""<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>"""

# ╔═╡ c38f82c2-def3-4d1c-bda0-54e779e2583a
md"""
## The Structured Query Language (SQL)

Let's rewind to our benchmarks for data aggregation tasks: [https://duckdblabs.github.io/db-benchmark/](https://duckdblabs.github.io/db-benchmark/).
"""

# ╔═╡ 99aa11d7-09f8-4ebb-9166-e248fc5af44f
html"""<img src="https://raw.githubusercontent.com/TidierOrg/TidierCourse/main/why-julia/duckdb_benchmark.jpeg" style="width:50%"/>"""

# ╔═╡ 78d16051-d5d9-4f9c-9316-ce4ddee39dce
md"""
DuckDB and ClickHouse were two of the fastest tools, and while both are implemented in C++, their primary interface to users is in SQL. SQL is the *lingua franca* of databases, and it is important background knowledge as a data scientist to understand its syntax, which is the source of its popularity as well as its primary limitation.

Let's say we have a dataset called `patients`, which has columns `diagnosis`, `takes_medications`, and `age`. Each row represents a unique patient, `diagnosis` is the primary diagnosis, `takes_medications` is a string indicating whether a patients takes any medications ("yes") or not ("no"), and `age` is their current age.

To compare the mean age among patients with diabetes who take medications versus those who do not take medications, we would write the following in SQL:

```sql
SELECT takes_medications, AVG(age) AS mean_age
FROM patients
WHERE diagnosis = 'diabetes'
GROUP BY takes_medications;
```

The SQL syntax is fairly intuitive in that each verb (e.g., `SELECT`) has a clear purpose, and the full query itself reads a bit like a sentence that you could read aloud. However, hidden within this apparent simplicity is the fact that SQL queries don't actually run in the order in this order.

The *actual* order in which this query runs is:

1. `FROM patients`
2. `WHERE diagnosis = 'diabetes'`
3. `GROUP BY takes_medications`
4. `SELECT takes_medications, AVG(age) AS mean_age`

If you think about this, this makes sense. You first need to start with the dataset (`FROM patients`), then you need to limit the dataset to only those rows where the primary diagnosis is diabetes (`WHERE diagnosis = 'diabetes'`). Then, after grouping by whether or not a patient takes medications, we need to calculate the mean age for each group.

The key lesson with SQL is:

> The order in which you write the verbs in SQL is different from the order in which the verbs are processed by SQL.

Much has been written about this issue (see: [https://jvns.ca/blog/2019/10/03/sql-queries-don-t-start-with-select/](https://jvns.ca/blog/2019/10/03/sql-queries-don-t-start-with-select/) and [https://www.flerlagetwins.com/2018/10/sql-part4.html](https://www.flerlagetwins.com/2018/10/sql-part4.html)).

In case you're curious, this is a more complete comparison of how SQL queries are written vs. how they are processed by SQL.

| What You Write in SQL | Order In Which It Runs |
| ----------------------|------------------------|
| SELECT                | FROM                   |
| DISTINCT              | JOIN                   |
| TOP                   | WHERE                  |
| [AGGREGATION]         | GROUP BY               |
| FROM                  | [AGGREGATION]          |
| JOIN                  | HAVING                 |
| WHERE                 | SELECT                 |
| GROUP BY              | DISTINCT               |
| HAVING                | ORDER BY               |
| ORDER BY              | TOP / LIMIT            | 
"""

# ╔═╡ 2686a0fb-15e1-44d8-9565-1abdee13ec5b
md"""
## Why not run SQL queries in the same order they are written?

While the fact that SQL queries form sentences that can be read aloud is convenient, this convenience comes at a cost. When queries get more complicated, they can no longer be read aloud, and the order of operations becomes much harder to keep track of. For more complex queries, it actually becomes cognitively less demanding to keep track of queries that are run in the same order that they are written.

This idea of behind `PRQL` ([https://github.com/PRQL/prql](https://github.com/PRQL/prql)), which calls itself a "simple, powerful, pipelined, SQL replacement." 

This same query in PRQL would be written as:

```
from patients
filter diagnosis == "diabetes"
group {takes_medications}
aggregate {age = avg age}
```

The fact that the analytic steps are written in the same order as they are performed seems trivial, but this is the big idea behind data pipelines. A data pipeline starts with a dataset, and each function transforms the data in a specific way until the end result answers an analytical question.
"""

# ╔═╡ 4fde78bb-3dc5-4849-ad24-29804a49740c
md"""
## Modern data pipelines

Data pipelines were popularized by the `dplyr` and `ggplot2` R packages, which are two of the core packages that make up the `tidyverse` ecoystem in R. In fact, the `dplyr` R package was a key inspiration behind `PRQL` (see [https://prql-lang.org/faq/](https://prql-lang.org/faq/)). While `PRQL` brings the idea of data pipelines to a `SQL` syntax, modern data pipelines are much more expansive in their capabilities.

While all data pipelines *start* with a dataset, they don't need to *end* with a dataset. Modern data pipelines often end with plots (as in `ggplot2` in R), statistical analyses, machine learning models, and more. These more advanced types of data pipelines is where SQL-like languages (like PRQL) show their limitations. While great for transforming data, SQL-like langauges do not have facilities for plotting and machine learning.

Data pipelines implemented in a programming language like Python, R, or Julia are thus much more capable than in PRQL.
"""

# ╔═╡ 6a08598c-69bf-498c-9ac2-4e0a4b749598
md"""
## Summary

- The Structured Query Language (SQL) is a popular way of working with datasets
- SQL's simple-to-read syntax introduces complexity because the order in which SQL queries are written is different from the order in which SQL queries are run
- PRQL is a SQL-like language that implements data pipelines
- Data pipelines refer to data analysis pathways that start with a dataset and then sequentially transform the dataset
- While data pipelines start with a dataset, modern data pipelines end with plots, statistical analyses, and machine learning models.
"""

# ╔═╡ 831bad3f-0e43-4226-a75c-7a7c4c569e53
md"""
# Appendix
"""

# ╔═╡ 0ddc3de7-c4a8-44c7-8cd3-4d63de3334c7
TableOfContents()

# ╔═╡ Cell order:
# ╟─2eec5998-bb36-11ee-2283-67ea47c4f5ed
# ╟─a4baabcd-d425-449e-b7bb-f8b776582330
# ╟─c38f82c2-def3-4d1c-bda0-54e779e2583a
# ╟─99aa11d7-09f8-4ebb-9166-e248fc5af44f
# ╟─78d16051-d5d9-4f9c-9316-ce4ddee39dce
# ╟─2686a0fb-15e1-44d8-9565-1abdee13ec5b
# ╟─4fde78bb-3dc5-4849-ad24-29804a49740c
# ╟─6a08598c-69bf-498c-9ac2-4e0a4b749598
# ╟─831bad3f-0e43-4226-a75c-7a7c4c569e53
# ╠═d6823989-bb85-400d-87ec-2a365260f5fb
# ╠═51e24e5e-cfc7-4b02-978c-505e21e6df43
# ╠═0ddc3de7-c4a8-44c7-8cd3-4d63de3334c7
