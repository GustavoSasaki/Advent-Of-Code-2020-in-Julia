### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 7cb1f900-375e-11eb-3cc9-cf8a8fb4fc04
file = readlines("day_3.txt")

# ╔═╡ 8f19f0e8-375e-11eb-38fa-b79ed15de216
md"Getting all tree positions on the original map"

# ╔═╡ a6db569a-375e-11eb-3943-051a1aefc042
world = Dict()

# ╔═╡ 7ed9ada8-375f-11eb-1194-93353bb23be0
for (index,line) in enumerate(file)
	trees = eachmatch(r"#",line)
	
	trees_pos = map(x-> x.offset, trees)
	
	for pos in trees_pos
		world[(index-1,pos-1)] = true
	end
end

# ╔═╡ 21106f36-375f-11eb-387e-7b11364cc055
world

# ╔═╡ 895f12cc-375f-11eb-3b70-a5c0accd57bc
md"extending the map to all positions"

# ╔═╡ 9818c068-375f-11eb-12a6-2b99d75fa222
begin
	tam_column = size(file)[1]
	tam_row = length(file[1])  #the \n ocupy one space
	
	has_tree(x::Int64,y::Int64) = haskey(world, ( x,y % tam_row))
end

# ╔═╡ d2c55762-3761-11eb-2e27-4b019a678050
tam_column

# ╔═╡ 5b953f4e-3762-11eb-1e0a-fbd3f82403d4
tam_row

# ╔═╡ ea80ee60-375d-11eb-2c3f-fd90c04e37c3
toboggan_pos = [(x,3*x) for x in 1:tam_column-1]

# ╔═╡ 6e1d3084-3769-11eb-1523-9d7fc6c7b1e3
[has_tree(x,y) for (x,y) in toboggan_pos]

# ╔═╡ 72a220ca-3763-11eb-3622-d33c420c6fb5
sum([has_tree(x,y) for (x,y) in toboggan_pos])

# ╔═╡ 24f92922-3768-11eb-018d-b582fb9346ad
md"# Question 2"

# ╔═╡ 3e9f32cc-3768-11eb-0561-7fac93e67081
slope(dx,dy) = sum([has_tree(x,Int64(dy/dx*x)) for x in 0:dx:tam_column-1])

# ╔═╡ 58b6ee84-3768-11eb-0cb0-5f322f2c4cc8
slope(1,3)

# ╔═╡ 7366bd04-3768-11eb-2366-a19e90bb92ca
slope(1,1)*slope(1,3)*slope(1,5)*slope(1,7)*slope(2,1)

# ╔═╡ 99bc5a36-3768-11eb-23e0-2394b9706da1
[slope(1,1),slope(1,3),slope(1,5),slope(1,7),slope(2,1)]

# ╔═╡ Cell order:
# ╠═7cb1f900-375e-11eb-3cc9-cf8a8fb4fc04
# ╟─8f19f0e8-375e-11eb-38fa-b79ed15de216
# ╠═a6db569a-375e-11eb-3943-051a1aefc042
# ╠═7ed9ada8-375f-11eb-1194-93353bb23be0
# ╠═21106f36-375f-11eb-387e-7b11364cc055
# ╠═895f12cc-375f-11eb-3b70-a5c0accd57bc
# ╠═9818c068-375f-11eb-12a6-2b99d75fa222
# ╠═d2c55762-3761-11eb-2e27-4b019a678050
# ╠═5b953f4e-3762-11eb-1e0a-fbd3f82403d4
# ╠═ea80ee60-375d-11eb-2c3f-fd90c04e37c3
# ╠═6e1d3084-3769-11eb-1523-9d7fc6c7b1e3
# ╠═72a220ca-3763-11eb-3622-d33c420c6fb5
# ╠═24f92922-3768-11eb-018d-b582fb9346ad
# ╠═3e9f32cc-3768-11eb-0561-7fac93e67081
# ╠═58b6ee84-3768-11eb-0cb0-5f322f2c4cc8
# ╠═7366bd04-3768-11eb-2366-a19e90bb92ca
# ╠═99bc5a36-3768-11eb-23e0-2394b9706da1
