### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 2506ecab-6bb5-410d-b0d5-fb53a9c36b04
 	using HypertextLiteral, PlutoUI; TableOfContents()

# ╔═╡ 7bee46aa-ed8c-4216-b124-574350a95f3f
begin
	html_string = join(readlines("header.html"), "\n")
	HypertextLiteral.@htl("""$(HypertextLiteral.Bypass(html_string))""")
end

# ╔═╡ bda1b780-f753-4d83-9b88-9b84242e55eb
md"""
# Tidier Course: Tidyverse and Its Descendants
"""

# ╔═╡ ecbe5053-c3b9-40c4-bcae-d935b6d31a03
html"""<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>"""

# ╔═╡ 596930fa-92ec-4d5b-bd87-b3879caccb77
md"""
## A brief introduction to the tidyverse

The tidyverse is a package (or more accurately, a collection of packages) for data transformation, reshaping, and visualization that was implemented in the R programming language. The tidyverse package was named in the 2022 Stack Overflow as the #22 most popular framework across all programming languages (Source: [https://survey.stackoverflow.co/2022#most-popular-technologies-misc-tech](https://survey.stackoverflow.co/2022#most-popular-technologies-misc-tech).

The tidyverse popularized the use of [data pipelines](data-pipelines/data-pipelines.ipynb). The building blocks of data pipelines are functions that take in a dataset, transform it, and then return a dataset. Each function is simple in that it only aims to perform one task, but the beauty of using data pipelines is that multiple functions can be chained together to perform complex data transformations. This style of programming was popularized by the tidyverse, and it looks something like this:

```r
patients |>
  group_by(takes_medications) |>
  summarize(age = mean(age))
```

The `|>` is a pipe operator in R (similar to Julia). Because each function in this code accepts a dataset as its first argument, it can written in this way, which has the added benefit that the code can be read aloud, like this:

Start with the **patients** dataset, *then*
**group by** whether or not they take medications, *then*
**summarize** their age by taking the mean.

Since each function in the above code transforms the dataset in a specific way, functions in tidyverse are often referred to as "data verbs," or just "verbs." Tidyverse has simple verbs like the `group_by()` and `summarize()` verbs above, and it has complex verbs like `count()` that combine the functionality of `group_by()` followed by a `summarize()` into a single function.

The verbs from tidyverse have proven so popular that they've led to [multiple implmentations across multiple programming languages](tidyverse-and-its-descendants/tidyverse-and-its-descendants.ipynb). The tidyverse isn't limited to data transformation only. There are functions within the tidyverse geared towards generating plots and standardizing the syntax for working with strings, categorical variables, in dates. In short, if there's a data-oriented task you can think of, there's probably a tidy way of accomplishing it.
"""

# ╔═╡ ffa569e5-86f8-4244-be9a-774335f3c2ee
md"""
## What packages make up the tidyverse?

The tidyverse is often referred to as a meta-package because while it exists as a single package, its primary role is to re-export a collection of underlying R packages. Many of these underlying packages actually existed before the tidyverse. However, with the formation of the tidyverse, the philosophy and approach underlying these packages were standardized to follow a consistent design and syntax.

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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.62"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "bc2b72b0d12fee30969231371a4f610807e01f2d"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "d3de2694b52a01ce61a036f18ea9c0f61c4a9230"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.62"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "cbbebadbcc76c5ca1cc4b4f3b0614b3e603b5000"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─7bee46aa-ed8c-4216-b124-574350a95f3f
# ╟─2506ecab-6bb5-410d-b0d5-fb53a9c36b04
# ╟─bda1b780-f753-4d83-9b88-9b84242e55eb
# ╟─ecbe5053-c3b9-40c4-bcae-d935b6d31a03
# ╟─596930fa-92ec-4d5b-bd87-b3879caccb77
# ╟─ffa569e5-86f8-4244-be9a-774335f3c2ee
# ╟─1804b400-13dd-4961-a24e-4a23a33706cc
# ╟─f2d12946-b710-42b1-af67-5dde7165d790
# ╟─b7386c91-d95f-46af-8c50-3cd0e971864a
# ╟─5b8a701e-bf77-4a7c-b83f-b948d0adabc9
# ╟─9c74ce19-3da6-4444-a07e-5c2343c17b43
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
