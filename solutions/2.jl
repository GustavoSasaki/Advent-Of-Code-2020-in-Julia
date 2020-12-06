### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2d73bd62-3739-11eb-35c0-09836bdd3d24
file = open(f->read(f, String), "day_2.txt")

# ╔═╡ 431ed85e-3739-11eb-0f7d-bd408abb654f
begin
	#separing each line
	input = eachmatch(r"(\d+)-(\d+) (\w): (\w+)\n",file)
	
	#getting first match of regex and converting to int
	input = map(x-> x.captures, input)
end

# ╔═╡ db441a22-3739-11eb-3657-319f8fbfbbe2
[x[1] for x in input]

# ╔═╡ ebaf6628-3739-11eb-3ec3-3120c2937e13
function valid_line(min ,max ,password, letter::AbstractString)
	min = parse(Int64, min)
	max = parse(Int64, max)
	
	matchs = collect( eachmatch( Regex(letter) , password) )
	return size(matchs)[1] ≥ min && size(matchs)[1] ≤ max
end

# ╔═╡ a9690290-373b-11eb-0312-671f6f134c36
resp1 = sum([valid_line(x[1],x[2],x[4],x[3]) for x in input])

# ╔═╡ ba4b5356-373b-11eb-2dc9-65a12a13c5d2
md"awnser for problem1 $(resp1)"

# ╔═╡ 65c76852-373c-11eb-3b42-8bdfacf8c6b3
md"# Problem 2"

# ╔═╡ 769c461e-373c-11eb-050a-1d496a98c2ab
function valid_line2(pos1 ,pos2 ,password, letter::AbstractString)
	pos1 = parse(Int64, pos1)
	pos2 = parse(Int64, pos2)
	
	matchs =  collect(eachmatch( Regex(letter) , password))
	if size(matchs)[1] == 0
		return false
	end
	apperance= map(x -> x.offset, matchs)
	return xor((pos1 in apperance) ,(pos2 in apperance))
end

# ╔═╡ b71c9022-373c-11eb-1168-599806156629
resp2 = sum([valid_line2(x[1],x[2],x[4],x[3]) for x in input])

# ╔═╡ Cell order:
# ╠═2d73bd62-3739-11eb-35c0-09836bdd3d24
# ╠═431ed85e-3739-11eb-0f7d-bd408abb654f
# ╠═db441a22-3739-11eb-3657-319f8fbfbbe2
# ╠═ebaf6628-3739-11eb-3ec3-3120c2937e13
# ╠═a9690290-373b-11eb-0312-671f6f134c36
# ╟─ba4b5356-373b-11eb-2dc9-65a12a13c5d2
# ╠═65c76852-373c-11eb-3b42-8bdfacf8c6b3
# ╠═769c461e-373c-11eb-050a-1d496a98c2ab
# ╠═b71c9022-373c-11eb-1168-599806156629
