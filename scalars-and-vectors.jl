### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 1d43a27a-0e6a-4fe9-b300-3f2d51225177
 using HypertextLiteral, PlutoUI; TableOfContents()

# ╔═╡ fe4343f8-c102-11ee-0ad0-9bfdb881f9f0
begin
	html_string = join(readlines("header.html"), "\n")
	HypertextLiteral.@htl("""$(HypertextLiteral.Bypass(html_string))""")
end

# ╔═╡ b602ef19-eceb-46db-a87f-b45894b3b40f
md"""
# Scalars and vectors
"""

# ╔═╡ 64ffe9cd-087b-4f1e-b677-7e7eb71647be
md"""

## Scalars
In Julia, an individual value is referred to as a "scalar", and a collection of values is referred to a "vector". Scalars are a type of data structure, not a data type. As a result, scalars can refer to individual values that are *either* numbers, strings, or dates.

### Numbers as scalars

Let's explore different types of scalars by doing some simple math.

Let's multiply 2 and 3.
"""

# ╔═╡ 2dfda4e4-bf0b-49e3-9e9c-1473b0318190
2 * 3

# ╔═╡ 798522c0-9175-4061-a925-094c93ee6db5
md"""
Multiplying 2 and 3 results in the number `6`, which is probably what you expected. Now, let's check the type to see what type of data this is.
"""

# ╔═╡ 101c2f1d-92b8-41a7-82ac-409230a458e3
typeof(2 * 3)

# ╔═╡ dd295855-3641-43c8-a406-8cfde4b0fc32
md"""
The data type is a 64-bit integer, which is a type of scalar.

Does multiplying 2 and 3 always result in 6? Not always. In Julia, if 2 and 3 refer to strings, then multiplying them results in the number 23.

### Strings as scalars

For example, let's repeat the same multiplication but this time represent 2 and 3 as strings.
"""

# ╔═╡ d0aef339-d008-4f04-a1f2-0696b09c2431
"2" * "3"

# ╔═╡ a713398d-d2be-4110-9820-3f6b267fda7d
md"""
In Julia, combining strings, which is also known as concatenation, is accomplished by multiplying the strings together. We can check the type of the string resulting from multiple "2" and "3", and we see that the result is a `String`.
"""

# ╔═╡ 07c40203-c9a6-4ebf-a969-cde91aa48640
typeof("2" * "3")

# ╔═╡ 350dc505-d549-4c4e-bf00-1c6800010661
md"""
So far, this is fairly straightforward. Behind the scenes, the `*` operator has a way of handling numbers, and a separate way of handling strings.

We won't dig into the details of exactly how this works yet, but it is worth knowing that there's nothing special about `*` in Julia. We refer to the `*` symbol as an operator because it operates on the items to either side of it (for example, on a `2` and `3`). But in every other way, it's defined and behaves like every other function.

For example, we can write `2 * 3` as `*(2, 3)`, thereby calling `*` like we would call any other function.
"""

# ╔═╡ 4b3dec46-fa4c-449b-97d5-ac97ff4d7202
*(2, 3)

# ╔═╡ e0f2465c-696c-4b5c-a65c-a6a0a038af88
*("2", "3")

# ╔═╡ 692db9a9-8469-40a4-9cb5-f84bd81aeb5c
md"""
But what happens if we try to multiply the string "2" with the number `3`?
"""

# ╔═╡ b78b01c3-d967-4607-920c-aa083730cb3b
"2" * 3

# ╔═╡ b81146d2-aff6-4fc7-886a-cc35068d8889
md"""
!!! danger "Don't panic!"
	This error message is expected!

	We get an error when we try to multiply a string by a number. If you look carefully at the first line of the error message, Julia tells you it doesn't know how to multiply a string by an integer. Unlike many other dynamically typed programming languages (like R), Julia will not automatically convert types between strings and numbers.

What if we multiply `2` (an integer) with `3.0` (a floating point number)?
"""

# ╔═╡ cad152a8-7d1d-4aac-9ae9-7d5d13ccb0ca
2 * 3.0

# ╔═╡ 55c8032c-7177-4cae-ae09-e3fb2aa0f62c
typeof(2 * 3.0)

# ╔═╡ c71d1849-74b6-4521-96f9-40362423f290
md"""
Julia handles this situation just fine, with the caveat that it converts the result to a 64-point floating point number rather than an integer.

Mathematically, this isn't a problem. If we check to see if they are equal using the double-equals-sign (`==`), Julia will inform you that they represent the same number.
"""

# ╔═╡ c7ee9726-d53f-41c4-88c9-9aff696f11bd
6 == 6.0

# ╔═╡ ae843547-0e71-497d-ac6f-00fdc8bd17f1
md"""
However, if you really needed to know whether they are identical in both their content and their type, then you could use the triple-equals-sign (`===`) to check, and this would confirm that they are slightly different because they belong to different types.
"""

# ╔═╡ 4d40482e-1f69-4ed6-af75-1efd21d20492
6 === 6.0

# ╔═╡ d0a88c7e-f270-4498-972e-195a71f6a039
md"""
	To summarize, we learned that scalars refer to individual values that can belong to different data types. Some common data types are integers, floating point numbers, and strings.
"""

# ╔═╡ 0b79dfed-b08d-4e1d-b78f-ef9522768b68
md"""
## Vectors
"""

# ╔═╡ 65f25e2c-136b-4661-8c59-88aa9fd22692
md"""
Vectors represent a collection of scalars. They are defined using square brackets. They are commonly used in data frames (which we will learn about soon), where each column of data consists of a vector.

Vectors can contain any type of scalar, whether it be numbers, strings, or dates.
"""

# ╔═╡ 6298d926-d963-4176-938f-8e51ca85f9b3
md"""
### Numeric vectors

Let's start by defining a simple numeric vector. Remember that in Julia, integers and floats are represented as separate data types.
"""

# ╔═╡ 32354c82-f2d0-45fb-8665-f0a4818547d7
[2,3]

# ╔═╡ 81ee9df5-d4a2-48d4-87fd-1c4c1c0d60db
md"""
Because vectors can contain different types of data, vectors are represented in Julia as a "parametric" type. Specifically, the data type is a `Vector`, with a parameter of `Int64` to indicate that the data type of the values contained within the vector are integers..
"""

# ╔═╡ a2f660c8-c01d-41e8-88d1-62b47ea137e2
typeof([2, 3])

# ╔═╡ 9b8f2eb0-36c7-468c-9ed6-d16648704182
md"""
A `Vector` is just a 1-dimensional array, so Julia points out that `Vector{Int64}` is an alias for `Array{Int64, 1}`. Whereas `Vector{Int64}` has a single parameter (`Int64`), `Array{Int64, 1}` has two parameters (`Int64` for the data type of the values, and `1` for the number of dimensions).

If we indicate that `2.0` and `3.0` are float values by adding a decimal point, then Julia will identify the data type as a `Vector{Float64}`. Note that the zero is optional, so `[2., 3.]` would have the same result.
"""

# ╔═╡ b9a091c3-e78e-428b-b15b-009a2d395b51
typeof([2.0, 3.0])

# ╔═╡ cde4c2bc-ead3-4338-921d-6fe3cd301c70
md"""
We can also mix and match integers and floats. Because integers can be easily upgraded to become floats, the resulting data type is a `Vector{FLoat64}` rather than a combination of the two types.
"""

# ╔═╡ 012ef250-a459-4427-9eb2-a594fdf03ab3
typeof([2, 3.5])

# ╔═╡ d4a0d615-87fb-4b05-bd43-fa652e3e7670
md"""
### String vectors

Defining a string vector is as easy as ensuring that each value in the vector is a string. If we our typing out the values of the string (known as a "string literal"), then we can accomplish this by surrounding the value with double-quotations (`""`).

Importantly, single-quotations are used to denote individual characters of a string, so `"2"` is not the same thing as `'2'` in Julia. Specifically, strings in Julia are considered to be collections of characters.
"""

# ╔═╡ 4e14b5dc-12c0-4012-9f00-df3c3bb3967e
typeof(["2", "3"])

# ╔═╡ 44de803e-aa9f-4b10-b009-ac5778102506
md"""
Note that this is different from the following:
"""

# ╔═╡ 924acdef-0a22-4876-8217-ff2294e2f18e
typeof(['2', '3'])

# ╔═╡ 73f5fcb9-6491-4b69-abd2-7f32c8b02908
md"""
### Mixed data type vectors

We saw that when combining an integer with a float, the resulting data type was a `Float64` because the integer was upgraded to a float.

The parameter in `Vector` does not always get upgraded when we combine different data types. For example, if we combine a `"2"` (a string) with a `3` (an integer), then the resulting type is `Any`, which is an abstract data type that encompasses all other types.
"""

# ╔═╡ 29e8a33a-2d52-47d5-94ee-a4fe9cbc250b
md"""
This is because when we look for the narrowest data type that encompasses strings and integers, we arrrive at `Any`.
"""

# ╔═╡ a40b071c-5ef2-405b-acab-9a32404ad3ed
typeof(["2", 3])

# ╔═╡ 7d3a715a-837d-46bc-a332-cc1f0a0e65f9
typejoin(String, Int64)

# ╔═╡ 161a6f22-649d-4247-861a-8275b1aa4b6e
md"""
You might be wondering what exactly `Any` represents here. `Any` is the "overall" data type for the vector. In other words, all bets are off with respect to data types when it comes to adding, removing, or modifying elements of this vector.

Even though the overall data type of the vector is `Any`, the individual elements of the vector still retain their data types. We can see this by evaluating the `typeof()` function on each individual value of the `["2", 3]` vector.
"""

# ╔═╡ 2470a189-fdb6-4622-8cf1-23b7b4d60d34
md"""
## Dot-vectorization

To run the `typeof()` function separately to each element of the vector, you *might* be tempted to write a loop that will let you apply this function separately to each element of the vector.

But there's no need!


!!! note
	In Julia, running a function on each element of a vector is easily accomplished by adding a period (`.`) to the end of the function call. This is referred to as dot-vectorization and is essentially a bit of compiler *magic*.
"""

# ╔═╡ 4e1d87b4-8bb1-445e-aa7e-2d9e07f5e0bd
typeof.(["2", 3])

# ╔═╡ 81de86f0-2afd-4a48-a311-cbb056c83202
md"""
By dot-vectorizing the `typeof()` function, we were able to run it individually on each item of the vector. It returns two values, one for the data type for each of the elements.

!!! note
	Dot-vectorization is a powerful tool because it lets us apply *any* function individually to the elements of *any* collection! The person defining the function does not have to do anything special to enable dot-vectorization. It is built into Julia for all functions!

In this particular example, we had the option to call `typeof()` or `typeof.()`. Both of these were valid Julia code, although they produced different results. However, sometimes, only the dot-vectorized version is valid. This is true when it comes to performing common arithmetic operations on vectors.
"""

# ╔═╡ ad43cf10-02bf-4ef6-a89b-b7a8b21897c3
[2, 3] + 1

# ╔═╡ bb00f75a-8501-4c2c-887b-aa1855f12cf4
md"""
### Our first error!

!!! danger "Don't panic!"
	This error was expected! Why?

	The error occurs because we tried to add a vector to a scalar. Julia knows how to add scalars to one another but doesn't know how to add a vector to a scalar. If you look carefully at the first line of the error, Julia even tells you that there is `no method matching +(::Vector{Int64}, ::Int64)`. This means that for the `+` function, Julia doesn't know how to add a `::Vector{Int64}` to an `::Int64`. Double-colon signs in Julia are used to refer to data types.

Since Julia *does* know how to add scalars to one another, we can have Julia individually add the scalars `2` and `3` to the scalar `1`. How do we accomplish this? Dot-vectorization!
"""

# ╔═╡ d18b87b5-0eb9-416b-b613-e53d36d39066
[2, 3] .+ 1

# ╔═╡ c72a4ac9-dee0-4875-b4db-3fe162251d2d
md"""
### How to dot-vectorize operators

!!! note
	When applying dot-vectorization to operators, we place the `.` *before* the name of the function. Operators are special types of functions that can be inserted in between their arguments, such as the `+` operator in `a + b` resulting in `a .+ b`.

Let's revisit the error above for a moment. The error stated `MethodError: no method matching +(::Vector{Int64}, ::Int64)`. The first time (or even the tentht time) you see this error, it can be quite disconcerting. 

There's no need to worry when you see this error. Method errors are quite common in Julia because of the heavy reliance of Julia on the programming paradigm of "multiple dispatch". This means that functions like `+` and `*` have been separately defined for different types of arguments. When Julia comes across a combination of arguments for which it doesn't have a function defined, it results in a `MethodError`.

This usually means one of the following things:

- You forgot to dot-vectorize the function (as in the example above).
- You forgot to load a package that defines how to interact with data types you are working with.
- You made a mistake.

Let's take a look at a situations where we made a mistake. Even though Julia knows how to multiple numbers with one another and strings with one another, trying to multiply a string by a number results in a `MethodError` because Julia doesn't have a method defined for this.
"""

# ╔═╡ 3ae67b3e-b0c9-4c30-8ba8-b709717db6aa
"2" * 3

# ╔═╡ c2efd4f0-55b8-4d3a-8432-bd20c6f60a88
md"""
!!! danger "Don't panic!"
	This is another expected error! Focus on the first line, and you'll see exactly why. Julia is telling you it doesn't know how to apply the `*` function when the first argument is a `::String` and the second argument is an `::Int64`.
"""

# ╔═╡ ed992c6e-3d4c-4275-8cd7-116d62fc5d7f
md"""
Remember that dot-vectorization applies not only to arithmetic operations. It applies to everything! That means if you want to check if the values of two vectors are equal, you need to vectorize the comparison operator.

Writing `.==` gives us the intended result.
"""

# ╔═╡ 03f080e4-1060-474d-a888-fe159e582226
[2, 3] .== [4, 3]

# ╔═╡ f57e873c-7678-4574-9116-60d8ace56297
md"""
Had we forgotten to dot-vectorize and had written this without the dot, we would have gotten a very different result.
"""

# ╔═╡ 348dfbe3-e3e9-48d8-92dc-642f843068cc
[2, 3] == [4, 3]

# ╔═╡ 73aafb75-259e-4492-ab7f-b2143cf781f1
md"""
This does not produce an error because it is perfectly valid Julia code. However, when it comes to comparison of vectors, we are usually checking to see if each value is equal (the former) and not whether the vectors are overall equal (the latter), so the fact that both versions are valid is a common source of *silent* errors.
"""

# ╔═╡ 721f8157-007c-4406-b004-a166cc66c945
md"""
Let's see what happens we calculate a sum *with* and *without* dot-vectorization.

In the absence of dot-vectorization, `sum()` gives us the intended result.
"""

# ╔═╡ 33066afb-5b99-4536-8fa9-53128cd41b2a
sum([2,3])

# ╔═╡ 5060facc-8625-41fe-acc7-6cd7cc703cc3
md"""
Had we dot-vectorized `sum()`, as in `sum.()`, Julia does not produce an error. Instead, the `sum()` operation is separately applied to each value of the vector. Julia diligently returns the sum of each individual value, which is of course identical to each individual value.
"""

# ╔═╡ e7611704-373e-46aa-9bc3-b0b34282db42
sum.([2,3])

# ╔═╡ 420691b6-e226-4756-a840-373e6b3d52f9
md"""
!!! warning
	While dot-vectorization is a powerful tool, wielding this tool comes with the responsibility to use it correctly. Using it incorrectly will often produce an error, but not always! It's up to you to ensure that you are applying this tool correctly.

	This is a large part of the reason that Tidier.jl will intelligently vectorize your code so that you don't need to. We'll come back to this soon.
"""

# ╔═╡ 73867e01-e83b-4a96-b11c-e1285fa12bd7
md"""
### Dot-vectorization with mixed data types

You might wonder whether we can dot-vectorize across vectors contained mixed data types. As long as each scalar operation is valid (i.e., Julia has a method defined for it), then dot-vectorization is perfectly fine!

Take a look at this example , where different multiplication methods are applied to the strings and integers.
"""

# ╔═╡ 275db704-2312-4a2c-bcd9-29ecb1944173
["1", 2] .* ["2", 3]

# ╔═╡ 20ca7877-6d6d-45f3-a19d-f069d741981a
md"""
# Summary

In this module, we learned about scalars, vectors, and dot-vectorization. Scalars refer to individual values, which can be any type of data such as an integer, float, string, date, or one of many more data types. Vectors typically contain collections of scalars, where the individual scalars may be any data type (or even more than one data type).

Many functions in Julia are designed to operate on scalars, such as `a + b`, `a * b`, and `typeof(a)`. We can apply these functions to vectors by using *dot-vectorization*, rewriting them as `a .+ b`, `a .* b`, and `typeof.(a)`, respectively.

Many functions can be validly called in their usual or dot-vectorized form, and it is typically left up to you to specify in the intended form. This is one area where Tidier.jl can help by intelligently handling the vectorization for you to reduce common errors involving vectorization.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.55"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "df05af8ff4a6b88f41ec2079384918224692aa07"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

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

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─fe4343f8-c102-11ee-0ad0-9bfdb881f9f0
# ╟─1d43a27a-0e6a-4fe9-b300-3f2d51225177
# ╟─b602ef19-eceb-46db-a87f-b45894b3b40f
# ╟─64ffe9cd-087b-4f1e-b677-7e7eb71647be
# ╠═2dfda4e4-bf0b-49e3-9e9c-1473b0318190
# ╟─798522c0-9175-4061-a925-094c93ee6db5
# ╠═101c2f1d-92b8-41a7-82ac-409230a458e3
# ╟─dd295855-3641-43c8-a406-8cfde4b0fc32
# ╠═d0aef339-d008-4f04-a1f2-0696b09c2431
# ╟─a713398d-d2be-4110-9820-3f6b267fda7d
# ╠═07c40203-c9a6-4ebf-a969-cde91aa48640
# ╟─350dc505-d549-4c4e-bf00-1c6800010661
# ╠═4b3dec46-fa4c-449b-97d5-ac97ff4d7202
# ╠═e0f2465c-696c-4b5c-a65c-a6a0a038af88
# ╠═692db9a9-8469-40a4-9cb5-f84bd81aeb5c
# ╠═b78b01c3-d967-4607-920c-aa083730cb3b
# ╠═b81146d2-aff6-4fc7-886a-cc35068d8889
# ╠═cad152a8-7d1d-4aac-9ae9-7d5d13ccb0ca
# ╠═55c8032c-7177-4cae-ae09-e3fb2aa0f62c
# ╟─c71d1849-74b6-4521-96f9-40362423f290
# ╠═c7ee9726-d53f-41c4-88c9-9aff696f11bd
# ╟─ae843547-0e71-497d-ac6f-00fdc8bd17f1
# ╠═4d40482e-1f69-4ed6-af75-1efd21d20492
# ╟─d0a88c7e-f270-4498-972e-195a71f6a039
# ╠═0b79dfed-b08d-4e1d-b78f-ef9522768b68
# ╟─65f25e2c-136b-4661-8c59-88aa9fd22692
# ╟─6298d926-d963-4176-938f-8e51ca85f9b3
# ╠═32354c82-f2d0-45fb-8665-f0a4818547d7
# ╟─81ee9df5-d4a2-48d4-87fd-1c4c1c0d60db
# ╠═a2f660c8-c01d-41e8-88d1-62b47ea137e2
# ╟─9b8f2eb0-36c7-468c-9ed6-d16648704182
# ╠═b9a091c3-e78e-428b-b15b-009a2d395b51
# ╟─cde4c2bc-ead3-4338-921d-6fe3cd301c70
# ╠═012ef250-a459-4427-9eb2-a594fdf03ab3
# ╟─d4a0d615-87fb-4b05-bd43-fa652e3e7670
# ╠═4e14b5dc-12c0-4012-9f00-df3c3bb3967e
# ╟─44de803e-aa9f-4b10-b009-ac5778102506
# ╠═924acdef-0a22-4876-8217-ff2294e2f18e
# ╟─73f5fcb9-6491-4b69-abd2-7f32c8b02908
# ╟─29e8a33a-2d52-47d5-94ee-a4fe9cbc250b
# ╠═a40b071c-5ef2-405b-acab-9a32404ad3ed
# ╠═7d3a715a-837d-46bc-a332-cc1f0a0e65f9
# ╟─161a6f22-649d-4247-861a-8275b1aa4b6e
# ╟─2470a189-fdb6-4622-8cf1-23b7b4d60d34
# ╠═4e1d87b4-8bb1-445e-aa7e-2d9e07f5e0bd
# ╟─81de86f0-2afd-4a48-a311-cbb056c83202
# ╠═ad43cf10-02bf-4ef6-a89b-b7a8b21897c3
# ╟─bb00f75a-8501-4c2c-887b-aa1855f12cf4
# ╠═d18b87b5-0eb9-416b-b613-e53d36d39066
# ╟─c72a4ac9-dee0-4875-b4db-3fe162251d2d
# ╠═3ae67b3e-b0c9-4c30-8ba8-b709717db6aa
# ╠═c2efd4f0-55b8-4d3a-8432-bd20c6f60a88
# ╟─ed992c6e-3d4c-4275-8cd7-116d62fc5d7f
# ╠═03f080e4-1060-474d-a888-fe159e582226
# ╟─f57e873c-7678-4574-9116-60d8ace56297
# ╠═348dfbe3-e3e9-48d8-92dc-642f843068cc
# ╟─73aafb75-259e-4492-ab7f-b2143cf781f1
# ╟─721f8157-007c-4406-b004-a166cc66c945
# ╠═33066afb-5b99-4536-8fa9-53128cd41b2a
# ╟─5060facc-8625-41fe-acc7-6cd7cc703cc3
# ╠═e7611704-373e-46aa-9bc3-b0b34282db42
# ╟─420691b6-e226-4756-a840-373e6b3d52f9
# ╟─73867e01-e83b-4a96-b11c-e1285fa12bd7
# ╠═275db704-2312-4a2c-bcd9-29ecb1944173
# ╟─20ca7877-6d6d-45f3-a19d-f069d741981a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
