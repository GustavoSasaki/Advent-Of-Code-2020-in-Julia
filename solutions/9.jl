### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2dd190ae-3888-11eb-2e68-090f885617d6
using DataStructures

# ╔═╡ 47c147e6-3888-11eb-1574-cd2d6aea7b1c
file = open(f->read(f, String), "day_9.txt")

# ╔═╡ 019df412-388a-11eb-17c1-2bfe6376975b
#first match get command, second get value of comand
regex = r"(\d+)\n"

# ╔═╡ f875f352-3952-11eb-3d4a-979e6ccb162f
to_int(x) = parse(Int64,x)

# ╔═╡ 913adf24-3955-11eb-2cf3-5bbfeee310db
input =[ to_int(x.captures[1]) for x in eachmatch(regex,file)]

# ╔═╡ 93a45364-3a20-11eb-0b1c-7b2f51070e0b
tam_buffer = 25

# ╔═╡ c1fc1900-3a1d-11eb-3ec4-fd5962e66c3c
function question1()
	memory = CircularBuffer{Int}(tam_buffer)  
	append!(memory,input[1:tam_buffer])

	for (index,i) in enumerate(input[tam_buffer+1:end])
		
		has_sum = any([(j+k==i)&&(j!=k) for j in memory, k in memory])
		awnser = 40
		if(has_sum)
			push!(memory,i)
		else
			return (index+tam_buffer,i)
		end
	end
	
end

# ╔═╡ e8f52ace-3a1f-11eb-1933-157ecc0d42c0
index_awns1, awns1 = question1()

# ╔═╡ aab19fbe-3956-11eb-0e2e-4d1994109154
md"# Question 2"

# ╔═╡ bb4c9200-3a20-11eb-3ef3-374ba3a31658
before_awns1 = input[1: index_awns1-1]

# ╔═╡ efa380ea-3a20-11eb-3c8e-8d04111be3e0
function _question2(size_set,awns1)
	
	memory = CircularBuffer{Int}(size_set)  
	append!(memory,input[1:size_set-1])

	for (index,i) in enumerate(input[size_set: end])
		push!(memory,i)

		if(sum(memory) == awns1)
			return  minimum(memory) + maximum(memory)
		end
	end
	return nothing
end

# ╔═╡ 6ba067a8-3a21-11eb-1a57-29ab5ea8efd3
_question2(4,awns1)

# ╔═╡ 86b6bf60-3a21-11eb-0cae-1f6b2222e1b6
function question2()
	for n in 2:size(input)[1]
		
		result =_question2(n,awns1)
		if(result != nothing)
			return result
		end
	end
end

# ╔═╡ 9490fb04-3a22-11eb-2c11-9fd604a6a319
question2()

# ╔═╡ 130b05ce-3a23-11eb-17bb-218a402f4383


# ╔═╡ Cell order:
# ╠═2dd190ae-3888-11eb-2e68-090f885617d6
# ╠═47c147e6-3888-11eb-1574-cd2d6aea7b1c
# ╠═019df412-388a-11eb-17c1-2bfe6376975b
# ╠═f875f352-3952-11eb-3d4a-979e6ccb162f
# ╠═913adf24-3955-11eb-2cf3-5bbfeee310db
# ╠═93a45364-3a20-11eb-0b1c-7b2f51070e0b
# ╠═c1fc1900-3a1d-11eb-3ec4-fd5962e66c3c
# ╠═e8f52ace-3a1f-11eb-1933-157ecc0d42c0
# ╠═aab19fbe-3956-11eb-0e2e-4d1994109154
# ╠═bb4c9200-3a20-11eb-3ef3-374ba3a31658
# ╠═efa380ea-3a20-11eb-3c8e-8d04111be3e0
# ╠═6ba067a8-3a21-11eb-1a57-29ab5ea8efd3
# ╠═86b6bf60-3a21-11eb-0cae-1f6b2222e1b6
# ╠═9490fb04-3a22-11eb-2c11-9fd604a6a319
# ╠═130b05ce-3a23-11eb-17bb-218a402f4383
