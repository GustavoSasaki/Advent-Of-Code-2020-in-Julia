### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 5e8c4976-3727-11eb-2801-0313fd547ac2
file = open(f->read(f, String), "day_1.txt")

# ╔═╡ bd9f511c-3727-11eb-38e3-ad2be4ac32fc
begin
	#separing each line
	input = eachmatch(r"(.+)\n",file)
	
	#getting first match of regex and converting to int
	input = map(x-> parse(Int64, x.captures[1]), input)
end

# ╔═╡ b3710000-372a-11eb-25f0-4fe8d0aa2162
sum = filter(x->x<2020, [i+j for i in input,j in input])

# ╔═╡ a064fb9e-3737-11eb-06e6-fb89f785aba8
needs = [(2020-x) for x in sum]

# ╔═╡ 081e453e-372d-11eb-09ab-471d8bb8881f
inter = intersect(needs,input)

# ╔═╡ cd91eaa0-3737-11eb-2b49-b9168dab6e3f
result =inter[1]*inter[2]*inter[3]

# ╔═╡ 33efb69e-3738-11eb-3c85-8df7bac1208e
1051 * 897 * 72

# ╔═╡ Cell order:
# ╠═5e8c4976-3727-11eb-2801-0313fd547ac2
# ╠═bd9f511c-3727-11eb-38e3-ad2be4ac32fc
# ╠═b3710000-372a-11eb-25f0-4fe8d0aa2162
# ╠═a064fb9e-3737-11eb-06e6-fb89f785aba8
# ╠═081e453e-372d-11eb-09ab-471d8bb8881f
# ╠═cd91eaa0-3737-11eb-2b49-b9168dab6e3f
# ╠═33efb69e-3738-11eb-3c85-8df7bac1208e
