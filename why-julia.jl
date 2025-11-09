### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 44afa588-b452-4068-8c0f-b86b20610ab3
# ╠═╡ show_logs = false
using Pkg; Pkg.activate(".."); Pkg.instantiate()

# ╔═╡ 1a83143f-ee1b-4641-ac4b-6b2c814060bf
using PlutoUI: TableOfContents

# ╔═╡ e5e107c2-bb3b-11ee-06db-754133546dbc
md"""
# Tidier Course: Why Julia?
"""

# ╔═╡ c295fb3d-134c-49e2-a1c7-ea24196bb79c
html"""
<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>
"""

# ╔═╡ b61a62f6-4486-43d9-9ef0-ad3bd67348c7
md"""
## Preface

Welcome to the **Tidier Course**, an interactive course designed to introduce you to Julia and the Tidier ecosystem for data analysis. The course consists of a series of Pluto Notebooks so that you can both learn and practice how to write Julia code through real data science examples.

This course assumes a basic level of familiarity with programming but does not assume any prior knowledge of Julia. This course emphasizes the parts of Julia required to read in, explore, and analyze data. Because this course is primarily oriented around data science, many important aspects of Julia will *not* be covered in this course.

If you do happen to have familiarity with either R or Python, we will make a concerted effort to highlight ways in which Julia is both *similar* to and *different* from both of these languages. If Julia is the first language you're learning for data science, this course should tell you most of what you'll need to know.
"""

# ╔═╡ 79a07af6-1c5b-4c65-a780-eb12db42c153
md"""
## Why Julia?

Clearly, Python and R are more commonly used languages, so it's a natural question to ask: **why use Julia?**

While Julia has many virtues as a language, probably the most important one is this: it has a fairly simple syntax resembling a mix of Python and R, but unlike either of this languages, it's **much faster** out of the box. If you've used either Python and R, you may wonder how this could  be true. Both Python and R *seem* to be quite speedy to work with, especially when you're working with modern data science packages.

For example, let's take a look at recent h2o/DuckDB benchmarks for data aggregation tasks: [https://duckdblabs.github.io/db-benchmark/](https://duckdblabs.github.io/db-benchmark/).
"""

# ╔═╡ 9bf1568e-9e97-487a-94e7-70be221e6df3
html"""
<img src="https://raw.githubusercontent.com/TidierOrg/TidierCourse/main/images/duckdb_benchmark.jpeg" style="width:50%"/>
"""

# ╔═╡ 39662edf-f4f5-43f0-8626-4be8d990db35
md"""
For grouped aggregation tasks on a 50 GB data frame, the fastest solutions are:

- DuckDB: available in Python, R, and Julia
- Polars: available in Python and Rust
- ClickHouse: standalone solution
- DataFrames.jl: available in Julia
- data.table: available in R

Let's take a closer look at each one of these.

**DuckDB** and **ClickHouse** are examples of database management systems in which data frames represented in memory can be accessed using the Structured Query Language (SQL). DuckDB is an especially popular tool because it comes with companion packages in Python, R, and Julia. **Polars** is most commonly accessed using a Python package, and the speed of polars has led to an interesting moment in the Python community, where the **pandas** package remains very popular despite being among the slower-performing tools on this benchmark. The **data.table** was originally distributed as an R package, with a slower-performing Python port available in the form of the **pydatatable** package. And then there's the **DataFrames.jl** package, which is the fastest Julia solution for this benchmark and among the top tools overall.

While these all seem roughly similar, there is one aspect of the Julia **DataFrames.jl** package that sets it apart. To appreciate this, we need to take another look at how each of these packages is implemented behind the scenes. 

How are each of these tools implemented?

- DuckDB: implemented in C++
- Polars: implemented in Rust
- ClickHouse: implemented in C++
- DataFrames.jl: implemented in Julia
- data.table: implemented in C

Even though the users may work with a package like DuckDB in Python or R, the speed of this package actually comes from C++ code. And while C++ has many virtues as a memory-safe, production-ready programming language, it is generally not anyone's first choice as a data science language.

And if you were to decide you wanted to improve DuckDB to make it work better, you couldn't necessarily do this even if you were an expert in both Python and R. You'd need to learn C++. Well, that's perhaps a bit of an oversimplification. In reality, because DuckDB is an open-source project, you could open a GitHub issue suggesting a new feature and rely on their capable team to implement it.

But the larger point is still valid:

> **DataFrames.jl** is the *only* fast data analysis tool written in the same language as its user base.

(While polars *can* be used directly in Rust, its user base largely consists of Python users.)
"""

# ╔═╡ e6a7fc77-8e25-47d2-be78-5518826ab85a
md"""
## The two-language problem

Data scientists generally prefer languages with a concise syntax (like Python and R), but a lot of the speed in Python and R packages comes from using faster languages like C, C++, and Rust.

This tension between the frontend language (the one used by the data scientist) and the backend language (the one used in implementing the tool to make it run fast) has been termed the "two-language problem." 

Because the backend language does all the hard computational work, the frontend language is sometimes referred to (with a hint of disdain) as the "glue" language. The entire purpose of the glue language is to glue together the bits of backend code.

What's unique about Julia is that it is **both a glue language and a backend language**. How is this possible?

Like Python and R, Julia has a concise syntax. Similar to C, C++, and Rust, Julia is compiled, which allows optimizations that help code run really fast. But unlike C, C++, and Rust, there is no "Compile" button that you need to press. Julia is compiled on-the-fly as you use it. This means that you get the benefits of both concise syntax and speed.
"""

# ╔═╡ 4a352113-70f2-45d5-9515-98f1fea00ad4
md"""
## What are the downsides of Julia?

The two downsides of using Julia are:

- It has a less robust package ecosystem than R or Python.
- Because code needs to compile before it runs, there is sometimes a lag associated with the first time code runs.

Both of these are fairly minor and readily addressed.

Between `PyCall.jl`, `PythonCall.jl`, and `RCall.jl`, you can access all Python and R packages using Julia syntax. While this might seem like a bit of a cop-out, it's actually the best of both worlds. You get access to packages from more established languages without having to worry about your glue language being slow. If anything, your glue language may be *faster* than the underlying Python or R code that you're calling.

The issue of code compilation used to be a major problem in Julia until recently. As of version 1.9+, Julia packages are able to precompile their code and save it. This does mean that packages take a bit longer to install, but once installed, packages taking advantage of this precompilation run fast right from the beginning. While you may notice a momentary pause when running new functions that you've defined, most major Julia packages (including DataFrames.jl) take advantage of this precompilation.
"""

# ╔═╡ 6cfa4f75-1aa3-4d4e-a81f-fb46adaf1b9a
md"""
## Summary

In this section, we learned that:

- Julia has a simple and concise syntax, like Python and R
- Julia is fast, like C, C++, and Rust
- Julia plays nicely with both Python and R packages, giving you access to the full breadth of data science packages
"""

# ╔═╡ a0f21837-8df9-42d5-8e55-1cafe478777d
md"""
# Appendix
"""

# ╔═╡ 08f6a882-f687-4a1a-83ca-f47399022fca
TableOfContents()

# ╔═╡ Cell order:
# ╟─e5e107c2-bb3b-11ee-06db-754133546dbc
# ╟─c295fb3d-134c-49e2-a1c7-ea24196bb79c
# ╟─b61a62f6-4486-43d9-9ef0-ad3bd67348c7
# ╟─79a07af6-1c5b-4c65-a780-eb12db42c153
# ╟─9bf1568e-9e97-487a-94e7-70be221e6df3
# ╟─39662edf-f4f5-43f0-8626-4be8d990db35
# ╟─e6a7fc77-8e25-47d2-be78-5518826ab85a
# ╟─4a352113-70f2-45d5-9515-98f1fea00ad4
# ╟─6cfa4f75-1aa3-4d4e-a81f-fb46adaf1b9a
# ╟─a0f21837-8df9-42d5-8e55-1cafe478777d
# ╠═44afa588-b452-4068-8c0f-b86b20610ab3
# ╠═1a83143f-ee1b-4641-ac4b-6b2c814060bf
# ╠═08f6a882-f687-4a1a-83ca-f47399022fca
