### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 3a2812d8-3770-11eb-34b0-7fd565a38a5f
import Pkg; Pkg.add("DataStructures");using DataStructures

# ╔═╡ 1a5162ec-376c-11eb-2960-5d2de63d1513
file = readlines("day_5.txt")

# ╔═╡ 63d8cc20-376c-11eb-0a15-e74649299804
function get_id(not_zone_or_group)
	upper = map(x-> (x=='B'|| x=='R'), collect(not_zone_or_group))
	
	return sum([up*2^(10-index) for (index,up) in enumerate(upper)])
end

# ╔═╡ ad648972-376e-11eb-07d7-1f77ba810dad
passager_id = [get_id(line) for line in file]

# ╔═╡ c7ed4bda-376e-11eb-22d9-e14675f7f9e2
maximum(passager_id)

# ╔═╡ fcd1f052-376f-11eb-2e54-611deedd7c74
md"# Question 2"

# ╔═╡ 04515e12-3770-11eb-2212-c55609da65f4
occupy = DefaultDict(false)

# ╔═╡ 58485228-3770-11eb-188a-e3f1060f6f89
for id in passager_id
	occupy[id] = true
end

# ╔═╡ 832f9fd6-3771-11eb-10cb-dd40d51e2e4c
sum([(occupy[i]==false)&&occupy[i-1]&&occupy[i+1]  for i in 8:1023-8])

# ╔═╡ bc646fec-3772-11eb-07a7-a963d0f51465
begin
	assent = -1
for i in 8:1023-8
	if (occupy[i]==false) && occupy[i-1] && occupy[i+1]
		assent = i
	end
end
end

# ╔═╡ e59c62c0-3772-11eb-3887-c52aa4dcf981
assent

# ╔═╡ Cell order:
# ╠═3a2812d8-3770-11eb-34b0-7fd565a38a5f
# ╠═1a5162ec-376c-11eb-2960-5d2de63d1513
# ╠═63d8cc20-376c-11eb-0a15-e74649299804
# ╠═ad648972-376e-11eb-07d7-1f77ba810dad
# ╠═c7ed4bda-376e-11eb-22d9-e14675f7f9e2
# ╠═fcd1f052-376f-11eb-2e54-611deedd7c74
# ╠═04515e12-3770-11eb-2212-c55609da65f4
# ╠═58485228-3770-11eb-188a-e3f1060f6f89
# ╠═832f9fd6-3771-11eb-10cb-dd40d51e2e4c
# ╠═bc646fec-3772-11eb-07a7-a963d0f51465
# ╠═e59c62c0-3772-11eb-3887-c52aa4dcf981
