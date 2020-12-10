### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2dd190ae-3888-11eb-2e68-090f885617d6
using DataStructures

# ╔═╡ 47c147e6-3888-11eb-1574-cd2d6aea7b1c
file = open(f->read(f, String), "day_10.txt")

# ╔═╡ 019df412-388a-11eb-17c1-2bfe6376975b
#first match get command, second get value of comand
regex = r"(\d+)"

# ╔═╡ f875f352-3952-11eb-3d4a-979e6ccb162f
to_int(x) = parse(Int64,x)

# ╔═╡ 913adf24-3955-11eb-2cf3-5bbfeee310db
input =append!([0],[ to_int(x.captures[1]) for x in eachmatch(regex,file)])

# ╔═╡ 5959a5a6-3ae8-11eb-304e-93efdbb1449d
sort!(input)

# ╔═╡ 604c7afc-3ae8-11eb-0b3e-ad3c795d8d39
difference= input[2:end] - input[1:end-1]

# ╔═╡ f2da1cce-3ae8-11eb-3823-93b721546763
dif1 =sum(map(x -> (x==1), difference)) 

# ╔═╡ 0cb01a04-3ae9-11eb-1503-713cd2879c56
#your device has always a difference of 3 in the last slot, thats why the +1
dif3 = sum(map(x -> (x==3), difference)) +  1

# ╔═╡ 4980f462-3ae9-11eb-0258-6fb53fe670f1
dif1 * dif3

# ╔═╡ aab19fbe-3956-11eb-0e2e-4d1994109154
md"# Question 2"

# ╔═╡ 907408d6-3aea-11eb-2ff8-650fd94ee053
md"Consider the input already in order:
.we have to include the pairs with difference 3.
If not, we will make a 4+ jump.

So divide the input in continuos '1' difference

Calculate with dp for each group
"

# ╔═╡ 60c7816c-3af9-11eb-01c7-a9830ae2db73


# ╔═╡ 6a3b0a72-3aed-11eb-037d-cfdd3bb9eb2c
begin
	group_size = 0
	size_continuos_groups = []
	
	for x in difference
		
		group_size +=1
		
		if(x==3)
			
			if(group_size > 2)
				push!(size_continuos_groups,group_size)
			end
			group_size = 0
		end
	end
	
	push!(size_continuos_groups,group_size + 1)
	

end

# ╔═╡ 03af7394-3afa-11eb-1a11-c77bce80ccda
size_continuos_groups

# ╔═╡ e0c5fc98-3af1-11eb-3935-0b3da67afc71
input

# ╔═╡ c9c035fa-3af5-11eb-2372-a5b6156890ce
difference

# ╔═╡ 130b05ce-3a23-11eb-17bb-218a402f4383
number_of_solutions = Dict([(2,1), (3,2), (1,1), (0,1)])

# ╔═╡ 39c08774-3af1-11eb-3fa2-7f55584e157f
function find_solutions(n)
	if haskey(number_of_solutions, n)
		return number_of_solutions[n]
	else
		result = find_solutions(n-1) + find_solutions(n-2) + find_solutions(n-3)
		number_of_solutions[n] = result
		return result
	end
end

# ╔═╡ 552d820c-3af4-11eb-29a2-e3868c3f3ae5
begin
	awn2 = 1
	for x in size_continuos_groups
		awn2 *= find_solutions(x) 
	end
end

# ╔═╡ 6c9fe808-3af4-11eb-25db-838ef16b38de
awn2

# ╔═╡ Cell order:
# ╠═2dd190ae-3888-11eb-2e68-090f885617d6
# ╠═47c147e6-3888-11eb-1574-cd2d6aea7b1c
# ╠═019df412-388a-11eb-17c1-2bfe6376975b
# ╠═f875f352-3952-11eb-3d4a-979e6ccb162f
# ╠═913adf24-3955-11eb-2cf3-5bbfeee310db
# ╠═5959a5a6-3ae8-11eb-304e-93efdbb1449d
# ╠═604c7afc-3ae8-11eb-0b3e-ad3c795d8d39
# ╠═f2da1cce-3ae8-11eb-3823-93b721546763
# ╠═0cb01a04-3ae9-11eb-1503-713cd2879c56
# ╠═4980f462-3ae9-11eb-0258-6fb53fe670f1
# ╠═aab19fbe-3956-11eb-0e2e-4d1994109154
# ╟─907408d6-3aea-11eb-2ff8-650fd94ee053
# ╠═60c7816c-3af9-11eb-01c7-a9830ae2db73
# ╠═6a3b0a72-3aed-11eb-037d-cfdd3bb9eb2c
# ╠═03af7394-3afa-11eb-1a11-c77bce80ccda
# ╠═e0c5fc98-3af1-11eb-3935-0b3da67afc71
# ╠═c9c035fa-3af5-11eb-2372-a5b6156890ce
# ╠═130b05ce-3a23-11eb-17bb-218a402f4383
# ╠═39c08774-3af1-11eb-3fa2-7f55584e157f
# ╠═552d820c-3af4-11eb-29a2-e3868c3f3ae5
# ╠═6c9fe808-3af4-11eb-25db-838ef16b38de
