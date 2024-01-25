### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 540f6f90-b149-48a9-98b3-31fc458b3b6a
# ╠═╡ show_logs = false
using Pkg; Pkg.activate("."); Pkg.instantiate()

# ╔═╡ 93d671bd-c3a2-4add-ae2c-ac66cd8b734e
using PlutoUI: TableOfContents

# ╔═╡ 29aedef5-bd54-4842-8f31-8a0ae9d7a138
md"""
# Tidier Course
"""

# ╔═╡ 6103da8d-d125-49ab-9717-b8647cb8d421
html"""
<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>
"""

# ╔═╡ 2ce416e8-bb3d-11ee-3a9f-8dcc9a81f83c
md"""
Welcome to the **Tidier Course**, an interactive course designed to introduce you to Julia and the Tidier ecosystem for data analysis. The course consists of a series of Jupyter Notebooks so that you can both learn and practice how to write Julia code through real data science examples.

This course assumes a basic level of familiarity with programming but does not assume any prior knowledge of Julia. This course emphasizes the parts of Julia required to read in, explore, and analyze data. Because this course is primarily oriented around data science, many important aspects of Julia will *not* be covered in this course.

This course is currently under construction. Check back for updated content.

## Background

Skip to the "Getting Started" section if you want to just start coding.

- [Why Julia?](why-julia/why-julia.ipynb)
- [What is Tidier.jl?](what-is-tidier-jl/what-is-tidier-jl.ipynb)
- Installing Julia and its packages
- Accessing help

## Getting Started with Julia

- Values and vectors
- Pipes

## Working with Data Frames

- Data structures and types in Julia
- Reading data into Julia
- The verbs of data science
- Grouping and combining verbs

## Tidy Data

- Recoding data
- Joining data frames
- Reshaping data
- Separating and uniting columns of data

## Data Types

- Working with strings
- Working with categorical data
- Working with dates

## Telling Stories with Plots

- Anscombe's quartet and the Datasaurus Dozen
- Principles of visualization
- Graphics with grammar
- Geometric objets and mappings
- Positions, labels, and facets
- Coordinates, scales, and themes

## Analyzing text data
- Tokenizing text
- Why common words are not useful (and how tf-idf can help)

## Additional reading
- [Data Pipelines](data-pipelines/data-pipelines.ipynb)
- [Tidyverse and its descendants](tidyverse-and-its-descendants/tidyverse-and-its-descendants.ipynb)
"""

# ╔═╡ ba499b05-a496-45a9-a5e0-32b5e948dea2
md"""
# Appendix
"""

# ╔═╡ 149965f8-2979-40ba-a159-993c0ec85831
TableOfContents()

# ╔═╡ Cell order:
# ╟─29aedef5-bd54-4842-8f31-8a0ae9d7a138
# ╟─6103da8d-d125-49ab-9717-b8647cb8d421
# ╟─2ce416e8-bb3d-11ee-3a9f-8dcc9a81f83c
# ╟─ba499b05-a496-45a9-a5e0-32b5e948dea2
# ╠═540f6f90-b149-48a9-98b3-31fc458b3b6a
# ╠═93d671bd-c3a2-4add-ae2c-ac66cd8b734e
# ╠═149965f8-2979-40ba-a159-993c0ec85831
