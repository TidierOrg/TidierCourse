### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ b8891864-439c-4962-a4b5-1d849009ca04
# ╠═╡ show_logs = false
using Pkg; Pkg.activate(".."); Pkg.instantiate()

# ╔═╡ 0c798730-96c8-4add-b97b-a270c6f96c85
using PlutoUI: TableOfContents

# ╔═╡ bda1b780-f753-4d83-9b88-9b84242e55eb
md"""
# Tidier Course: Tidyverse and Its Descendants
"""

# ╔═╡ ecbe5053-c3b9-40c4-bcae-d935b6d31a03
html"""<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>"""

# ╔═╡ ffa569e5-86f8-4244-be9a-774335f3c2ee
md"""
## What is the tidyverse?

Before we dive into Tidier.jl, it's worth understanding a bit about the tidyverse, including what it is and what it's not. This will help in conveying some of the key philosophies and design decisions in Tidier.jl.

The tidyverse refers to a collection of R packages that popularized the idea of data pipelines in modern data analysis. The tidyverse is often referred to as a meta-package because while it exists as a single package, its primary role is to re-export a collection of underlying R packages. Many of these underlying packages actually existed before the tidyverse. However, with the formation of the tidyverse, the philosophy and approach underlying these packages were standardized to follow a consistent design and syntax.

These underlying packages include but are not limited to the following:

- `tibble`: for creating and displaying data frames
- `dplyr`: for transforming and summarizing data
- `tidyr`: for reshaping data
- `readr`: for reading in data
- `ggplot2`: for plotting data
- `stringr`: for working with strings
- `forcats`: for working with categorical variables
- `lubridate`: for working with dates

One important thing to note is that pretty much all of the capabilities enabled by the tidyverse are already natively supported in base R. In other words, the tidyverse doesn't exist simply because there's no way to accomplish these tasks without it. The tidyverse exists despite the fact that R is perfectly capable of doing each of these tasks.

What makes the tidyverse special? In addition to being user-friendly and consistent in its approach across these family of packages, the tidyverse is special because it is *opinionated*. There are intentional design decisions made in the tidyverse that diverge from base R. These design decisions are largely why it is loved by so many (but also why it is disliked by some).
"""

# ╔═╡ 1804b400-13dd-4961-a24e-4a23a33706cc
md"""
## The tidyverse has spawned a number of descendants

You might be wondering why so much attention in this course about Tidier.jl to the tidyverse R package upon which it is based. If you think of the tidyverse as *just* an R package, you are greatly underestimating its importance to data analysis across all data science languages.

The concepts, syntax, and verbs articulated by the collection of tidyverse packages are so popular that they have been directly implemented in a number of other languages. They've even inspired the creation of entirely new languages like `PRQL`.

For example, here are just a few examples of tidyverse implementations in programming languages *other* than R. By "implementation," I mean that the tools actively borrow both syntax and verbs (function names) from the original tidyverse.

Tidyverse implementations in Python:

- `siuba`: implements `dplyr`, `tidyr`, and a bit of `dbplyr`
- `dplython`: implements `dplyr` and `tidyr`
- `plydata`: implements `dplyr` and `tidyr`
- `tidypolars`: implements `dplyr` and `tidyr`
- `plotnine`: implements `ggplot2`

Tidyverse implementations in JavaScript:

- `tidy.js`: implements `dplyr` and `tidyr`
- `DataLib`: implements `dplyr`, although it is no longer actively maintained and has been replaced by `Arquero`` and `dataflow-api`
- `cxplot`: implements `ggplot2`

If you can do data science in a language, its highly likely that *someone* has tried to implement tidyverse in it.
"""

# ╔═╡ f2d12946-b710-42b1-af67-5dde7165d790
md"""
## But isn't tidyverse syntax an "R thing"?

Absolutely not! In fact, people who've used R for many years preceding the tidyverse often are the ones who push back against the tidyverse the most. The tidyverse has popularized a style of programming that is decidedly unique from normal R programming. While most of R uses what's called "standard evaluation," tidyverse embraces "non-standard evaluation," where scoping of variable names is dynamic, enabling a concise style of programming.

Let's take a look at the same example we covered in the SQL and PRQL code. Let's compare the mean age among patients with diabetes who take medications versus those who do not take medications:

```r
patients |>
  filter(diagnosis == "diabetes") |>
  group_by(takes_medications) |>
  summarize(age = mean(age))
```

**Everything** about this code is non-idiomatic in R!

The use of pipes (`|>`) is non-idiomatic and was popularized by tidyverse. In fact, tidyverse adopted its own pipe (`%>%`) because there was no pipe built into R. After this pipe became popular, it spawned the adoption of a pipe into base R. The popularity of pipes also brought upon the standardization of the dataframe-in, dataframe-out syntax. Each top-level function takes a data frame as its first argument and returns a data frame, making it easy to chain operations together.

How do we know that `diagnosis` refers to a column name and not to a global variable? Dynamic scoping implemented using non-standard evaluation. This code first looks for a column named `diagnosis` in the `patients` data frame, and if it can't be found, *then* it looks for a `diagnosis` variable in the parent environment. Note: there *are* ways to explicitly specify which environment the variable should be pulled from in the tidyverse.
"""

# ╔═╡ b7386c91-d95f-46af-8c50-3cd0e971864a
md"""
## What are some of the other implementations in R?

*Even in R*, there are multiple implementations of the tidyverse.

| R package             | Backend (language)    |
|-----------------------|-----------------------|
| dtplyr                | data.table (C)        |
| tidytable             | data.table (C)        |
| tidypolars            | polars (Rust)         |
| arrow                 | Arrow (C++)           |
| collapse              | C/C++                 |
| poorman               | R                     |

Why do these implementations exist?

Most of these exist because the original tidyverse implementation isn't fast enough. The original implementation of tidyverse (dplyr, specifically) uses C++ as a backend, and you can see here that people have tried to connect up the tidyverse to faster and faster backends to make it more speedy -- a perfect encapsulation of the two-language problem.

What I hope you appreciate from this is that in general, people *love* the tidyverse syntax. They do want to use the best and fastest tools, but they want to access these tools using the tidyverse syntax if at all possible -- which often is possible!
"""

# ╔═╡ 5b8a701e-bf77-4a7c-b83f-b948d0adabc9
md"""
## The tidyverse is a domain-specific language

While its developers emphasize the connection between tidyverse and the larger R ecosystem, the fact that the tidyverse approach has been adopted in other languages, and that multiple implementations of it exist even in R, suggests that the tidyverse is more of a domain-specific language.

It's true that the way in which it is implemented in R has historically been unique because of R's extensive meta-programming capabilities. This is why other implementations feel slightly clunky to use as compared to the R implementation.

But Julia *also* has very similar meta-programming capabilities, making it the perfect language to port the tidyverse.
"""

# ╔═╡ 9c74ce19-3da6-4444-a07e-5c2343c17b43
md"""
## Summary

- The tidyverse is an opinionated collection of packages for data transformation, reshaping, and visualization.
- The tidyverse popularized the idea of data pipelines and has spun off a number of other implementations in R, Python, and JavaScript.
- The tidyverse is non-idiomatic even in R, so it should be thought of more as a domain-specific language than something specific to R.
- Julia has similar meta-programming capabilities to R, making it a perfect language to port the tidyverse.
"""

# ╔═╡ c4c66ebb-d6ac-4e04-8454-4ba859caf72b
md"""
# Appendix
"""

# ╔═╡ 7a3cc4c6-5697-49ec-a115-500cd959d153
TableOfContents()

# ╔═╡ Cell order:
# ╟─bda1b780-f753-4d83-9b88-9b84242e55eb
# ╟─ecbe5053-c3b9-40c4-bcae-d935b6d31a03
# ╟─ffa569e5-86f8-4244-be9a-774335f3c2ee
# ╟─1804b400-13dd-4961-a24e-4a23a33706cc
# ╟─f2d12946-b710-42b1-af67-5dde7165d790
# ╟─b7386c91-d95f-46af-8c50-3cd0e971864a
# ╟─5b8a701e-bf77-4a7c-b83f-b948d0adabc9
# ╟─9c74ce19-3da6-4444-a07e-5c2343c17b43
# ╟─c4c66ebb-d6ac-4e04-8454-4ba859caf72b
# ╠═b8891864-439c-4962-a4b5-1d849009ca04
# ╠═0c798730-96c8-4add-b97b-a270c6f96c85
# ╠═7a3cc4c6-5697-49ec-a115-500cd959d153
