### A Pluto.jl notebook ###
# v0.19.37

using Markdown
using InteractiveUtils

# ╔═╡ c4b6c1d0-7271-4315-8682-43f3f2a66b44
# ╠═╡ show_logs = false
using Pkg; Pkg.activate(".."); Pkg.instantiate()

# ╔═╡ bd1cbde7-42eb-45a1-9296-f17d3b9c76bc
using Tidier

# ╔═╡ d33059a4-4774-4c4a-89c8-cba7a8032acd
using ZipFile, CSV, Dates

# ╔═╡ 8c1a9720-6a44-4bf5-96e0-5d0610ba9b52
using PlutoUI: TableOfContents

# ╔═╡ 9d465a8f-a418-4fe6-bebc-7f9c7aa632cf
md"""
# Tidier Course: What is Tidier.jl?
"""

# ╔═╡ daf77ffe-a06d-489b-9fff-ce84d377c86f
html"""
<img src="https://raw.githubusercontent.com/TidierOrg/.github/main/profile/TidierOrg_logo.png" align="left" style="padding-right:10x;" width="150"/>
"""

# ╔═╡ 17171622-d198-48cf-8c4a-e1164e824b2b
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

# ╔═╡ 2b49dad8-a00c-46f2-8c19-617292584e2c
md"""
## So what does all this mean for Julia?

Tidier.jl is a Julia implementation of the tidyverse package. Tidier.jl aims to fully recreate the experience of using the tidyverse in Julia, and to bring the maximal power of the Julia ecosystem for users by relying behind-the-scenes on first-class Julia packages like DataFrames.jl, Makie, and AlgebraOfGraphics.

Similar to the tidyverse, Tidier.jl is also a (growing) collection of multiple packages:

- `TidierData.jl`: for transforming, summarizing, and reshaping data
- `TidierPlots.jl`: for plotting data
- `TidierCats.jl`: for working with categorical variables
- `TidierDates.jl`: for working with dates
- `TidierStrings.jl`: for working with strings
- `TidierText.jl`: for working with text
- `TidierVest.jl`: for harvesting website data

Before we talk any more about how Tidier.jl works, let's start with an example of Tidier.jl in action.
"""

# ╔═╡ 9ba2aac6-fe6a-4a69-be4f-3c5eb0cee9bb
# If not already downloaded,
# Download the MITRE Synthea synthetic data zip file containing multiple .csv files
if !("data.zip" in readdir())
    location = download("https://mitre.box.com/shared/static/aw9po06ypfb9hrau4jamtvtz0e5ziucz.zip", "data.zip")
end

# ╔═╡ 55b30bb8-41a0-48d3-8459-affcb46c5c07
zip_file = ZipFile.Reader("data.zip")

# ╔═╡ 8dfb4d74-b7bf-4143-a0a8-2206f7ac000f
# Load the patients data frame
patients = CSV.read(zip_file.files[18], DataFrame);

# ╔═╡ e1edcc50-574b-4c75-8b8f-6448b1d83013
# Load the medications data frame
meds = CSV.read(zip_file.files[2], DataFrame);

# ╔═╡ 7ac88c9c-07f7-41c9-bc2d-a7451bad6ae2
md"""
## Let's take a look at the `patients` data frame

Now that our datasets are loaded from the zip file, let's start by taking a look at the `patients` data frame. We can take get a general feel of the dimensions of the data frame, as well as the first few values for each column, using the `@glimpse()` macro.
"""

# ╔═╡ c3bfa1a8-2651-454a-846f-fd1b4527eac4
@glimpse patients 

# ╔═╡ 5631379e-abaa-44cf-931e-6e5fa60e9353
md"""
**Since we are using Pluto, we can also just leverage Pluto which has a built-in table viewer**
"""

# ╔═╡ 67848cc5-2338-4841-82d5-bc666518e0f6
patients 

# ╔═╡ 5ebb00cc-cb45-4998-aa64-f9e2aebfab64
@chain patients @clean_names()

# ╔═╡ 0db72da1-0da9-422f-8b0b-2f4dc6701ca7
@chain meds @clean_names()

# ╔═╡ f85fb11e-f0aa-4d99-9427-ed3ee4400f99
patients_clean = @chain patients @clean_names();

# ╔═╡ 73211d51-9be7-4614-81e2-0f0be7c60eff
meds_clean = @chain meds @clean_names();

# ╔═╡ a41f9a3e-74f0-4029-ab97-6ec6265542e4
@chain meds_clean begin
	@rename(id = patient)
	@filter(ismissing(stop))
	@group_by(id)
	@summarize(num_meds = n())
	@left_join(patients_clean, _)
	@mutate(num_meds = replace_missing(num_meds, 0))
	@mutate(today = mdy("01-01-2023"))
	@mutate(age = if_else(!ismissing(deathdate) && deathdate < today,
						  deathdate - birthdate,
						  today - birthdate))
	@mutate(age = Dates.days(age)/365.25)
	ggplot(@aes(x = age, y = num_meds, color = gender))
	geom_point(alpha = 1/10)
	geom_smooth()
	labs(title = "Relationship between age and \
				  the number of medications people take",
		 subtitle = "Stratified by gender",
		 x = "Age (years)",
		 y = "Number of medications",
		 color = "Gender")
	theme_black()
end

# ╔═╡ 33dfdb6f-1da4-4e46-bf1f-93a824992194
md"""
# Appendix
"""

# ╔═╡ df80044c-b657-49cb-9a3d-c84848d5d786
TableOfContents()

# ╔═╡ Cell order:
# ╟─9d465a8f-a418-4fe6-bebc-7f9c7aa632cf
# ╟─daf77ffe-a06d-489b-9fff-ce84d377c86f
# ╟─17171622-d198-48cf-8c4a-e1164e824b2b
# ╟─2b49dad8-a00c-46f2-8c19-617292584e2c
# ╠═bd1cbde7-42eb-45a1-9296-f17d3b9c76bc
# ╠═d33059a4-4774-4c4a-89c8-cba7a8032acd
# ╠═9ba2aac6-fe6a-4a69-be4f-3c5eb0cee9bb
# ╠═55b30bb8-41a0-48d3-8459-affcb46c5c07
# ╠═8dfb4d74-b7bf-4143-a0a8-2206f7ac000f
# ╠═e1edcc50-574b-4c75-8b8f-6448b1d83013
# ╟─7ac88c9c-07f7-41c9-bc2d-a7451bad6ae2
# ╠═c3bfa1a8-2651-454a-846f-fd1b4527eac4
# ╟─5631379e-abaa-44cf-931e-6e5fa60e9353
# ╠═67848cc5-2338-4841-82d5-bc666518e0f6
# ╠═5ebb00cc-cb45-4998-aa64-f9e2aebfab64
# ╠═0db72da1-0da9-422f-8b0b-2f4dc6701ca7
# ╠═f85fb11e-f0aa-4d99-9427-ed3ee4400f99
# ╠═73211d51-9be7-4614-81e2-0f0be7c60eff
# ╠═a41f9a3e-74f0-4029-ab97-6ec6265542e4
# ╟─33dfdb6f-1da4-4e46-bf1f-93a824992194
# ╠═c4b6c1d0-7271-4315-8682-43f3f2a66b44
# ╠═8c1a9720-6a44-4bf5-96e0-5d0610ba9b52
# ╠═df80044c-b657-49cb-9a3d-c84848d5d786
