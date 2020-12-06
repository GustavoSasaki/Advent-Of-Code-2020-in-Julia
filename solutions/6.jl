### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ d3b0d688-37c5-11eb-2dba-339e12b29c0c
using DataStructures

# ╔═╡ 1a5162ec-376c-11eb-2960-5d2de63d1513
file = open(f->read(f, String), "day_6.txt")

# ╔═╡ 3d63250e-37bc-11eb-33fc-473c93d2a0b6
begin
	#separing by \n\n
	input = eachmatch(r"((?!\n\n)(.|\s))+",file)
	
	#getting first match of regex
	input = map(x-> x.match, input)
end

# ╔═╡ 63d8cc20-376c-11eb-0a15-e74649299804
begin
	anwser = 0
	for group in input
		all_c = unique(collect(group))
		filter!(l-> l != '\n' ,all_c)
		
		anwser+= size(all_c)[1]
	end
end

# ╔═╡ 3e522c16-37bd-11eb-0684-b9a6791b529f
anwser

# ╔═╡ fcd1f052-376f-11eb-2e54-611deedd7c74
md"# Question 2"

# ╔═╡ 29d4e6ea-37c5-11eb-33fa-a3bd8a932ad9
begin
	anwser2 = 0

	for group in input
		yes=[x for x in 'a':'z']
		
		group = split(group, "\n",keepempty=false)
		for person in group
			yes = yes ∩ collect(person)
		end

		anwser2+= size(yes)[1]
	end
end

# ╔═╡ a34e3080-37c5-11eb-12d2-97fc7249d5b2
anwser2

# ╔═╡ Cell order:
# ╠═d3b0d688-37c5-11eb-2dba-339e12b29c0c
# ╠═1a5162ec-376c-11eb-2960-5d2de63d1513
# ╠═3d63250e-37bc-11eb-33fc-473c93d2a0b6
# ╠═63d8cc20-376c-11eb-0a15-e74649299804
# ╠═3e522c16-37bd-11eb-0684-b9a6791b529f
# ╠═fcd1f052-376f-11eb-2e54-611deedd7c74
# ╠═29d4e6ea-37c5-11eb-33fa-a3bd8a932ad9
# ╠═a34e3080-37c5-11eb-12d2-97fc7249d5b2
