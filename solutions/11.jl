### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2dd190ae-3888-11eb-2e68-090f885617d6
using DataStructures

# ╔═╡ aa862a18-3bc3-11eb-17a4-a15284e47f56
using LightGraphs

# ╔═╡ 47c147e6-3888-11eb-1574-cd2d6aea7b1c
file = open(f->read(f, String), "day_11.txt")

# ╔═╡ 019df412-388a-11eb-17c1-2bfe6376975b
#first match get command, second get value of comand
regex = r"([.#L]+)"

# ╔═╡ d29eb8e8-3bc4-11eb-19db-213471925ca2
input =[x.captures[1] for x in eachmatch(regex,file)]

# ╔═╡ 428e6964-3bc7-11eb-2bde-9b9d607bec8b
input_size = (size(input)[1], length(input[1]))

# ╔═╡ 9ec584ca-3bc4-11eb-3d79-6bbd386e9715
begin
	seats = DefaultDict('.')
	for (index_y,line) in enumerate(input)
		for (index_x,item) in enumerate(line)
			seats[(index_y,index_x)] = item
		end
	end
end

# ╔═╡ 8c2fbd94-3bc4-11eb-1c00-136e0add7fcb
seats

# ╔═╡ 6382c796-3bc5-11eb-087a-cde7d6b75abb
begin
	function addjacenty(pos::Tuple{Int64,Int64},dict::DefaultDict)
		neig_pos = [(-1,-1),(-1,0),(-1,1),(1,-1),(1,0),(1,1),(0,-1),(0,1)]
		return [dict[(pos[1]+x,pos[2]+y)] for (x,y) in neig_pos]
	end
	
	is_floor(pos::Tuple{Int64,Int64},dict::DefaultDict) = '.'
	
	function is_empty(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		if all([(x!= '#') for x in addjacenty(pos,dict)])
			return '#'
		else
			return 'L'
		end
	end
	
	function is_occupy(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		if sum([(x== '#') for x in addjacenty(pos,dict)]) ≥ 4
			return 'L'
		else
			return '#'
		end
	end
	
	
	one_step_seat_func = Dict([('#',is_occupy),('L',is_empty),('.',is_floor)])
	function one_step_seat(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		old_value = dict[pos]

		new_value = one_step_seat_func[old_value](pos,dict)
		return new_value
	end
end

# ╔═╡ 33fcb568-3bc5-11eb-16b6-97ee834bb5cf
function one_step_plane(dict)
	
	change = false
	new_seats = DefaultDict('.')
	
	for y in 1:input_size[1]
		for x in 1:input_size[2]
			pos = (y,x)
			new_seats[pos] = one_step_seat(pos,dict)
			
			if(new_seats[pos] != dict[pos])
				change = true
			end
		end
	end
	
	return new_seats,change
end

# ╔═╡ 0f1dc8d6-3bca-11eb-048c-b3dd68dee015

begin
	seats1 = copy(seats)
	change = true
	while(change == true)
		(seats1,change) = one_step_plane(seats1)
	end
	

	sum([(value == '#') for (_, value) in seats1])

end

#29 + 22 + 49

# ╔═╡ 7902a486-3bcc-11eb-0691-b9eedcc0b2c1
md"# Question 2"

# ╔═╡ f4b9ed26-3bd8-11eb-39ab-7d627dfa0712
push!([[5]],[3])

# ╔═╡ 7e524662-3bcc-11eb-28c9-45b61768ed7d
begin
	function addjacenty2(pos::Tuple{Int64,Int64},dict::DefaultDict)
		neig_vert = [(y,pos[2]) for y in 1:input_size[1]]
		neig_hor = [(pos[1],x) for x in 1:input_size[2]]
		max_offset = min(input_size[1],input_size[2])
		neig_dir1 = [(pos[1]+q,pos[2]+q) for q in -max_offset:max_offset]
		neig_dir2 = [(pos[1]-q,pos[2]-q) for q in -max_offset:max_offset]
		
		resp = []
		push!(resp,neig_vert)
		push!(resp,neig_hor)
		push!(resp,neig_dir1)
		push!(resp,neig_dir2)
		
		unique!(resp)
		filter!(e->e !=pos,resp)
		return [dict[(pos[1]+x,pos[2]+y)] for (x,y) in neig_pos]
	end
	

	function is_empty2(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		if all([(x!= '#') for x in addjacenty2(pos,dict)])
			return '#'
		else
			return 'L'
		end
	end
	
	is_floor2 = is_floor
	
	function is_occupy2(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		
		neig_vert = [(y,pos[2]) for y in 1:input_size[1]]
		neig_hor = [(pos[1],x) for x in 1:input_size[2]]
		max_offset = min(input_size[1],input_size[2])
		neig_dir1 = [(pos[1]+q,pos[2]+q) for q in -max_offset:max_offset]
		neig_dir2 = [(pos[1]-q,pos[2]-q) for q in -max_offset:max_offset]
		
		resp = []
		append!(resp,neig_vert)
		append!(resp,neig_hor)
		append!(resp,neig_dir1)
		append!(resp,neig_dir2)
		
		unique!(resp)
		filter!(e->e !=pos,resp)
		
		if sum([(x== '#') for x in addjacenty2(pos,dict)]) ≥ 5
			return 'L'
		else
			return '#'
		end
	end
	
	
	one_step_seat_func2 = Dict([('#',is_occupy2),('L',is_empty2),('.',is_floor2)])
	function one_step_seat2(pos::Tuple{Int64,Int64},dict::DefaultDict) 
		old_value = dict[pos]

		new_value = one_step_seat_func2[old_value](pos,dict)
		return new_value
	end
end

# ╔═╡ f56f80ce-3bcd-11eb-3cac-4d18887d9b36
function one_step_plane2(dict)
	
	change = false
	new_seats = DefaultDict('.')
	
	for y in 1:input_size[1]
		for x in 1:input_size[2]
			pos = (y,x)
			new_seats[pos] = one_step_seat2(pos,dict)
			
			if(new_seats[pos] != dict[pos])
				change = true
			end
		end
	end
	
	return new_seats,change
end

# ╔═╡ ea5878ba-3bcf-11eb-11fc-6f7fa62e6e88
begin
	seats2 = copy(seats)
	change2 = true
	while(change2 == true)
		(seats2,change2) = one_step_plane2(seats2)
	end
	

	sum([(value == '#') for (_, value) in seats2])
end


# ╔═╡ Cell order:
# ╠═2dd190ae-3888-11eb-2e68-090f885617d6
# ╠═aa862a18-3bc3-11eb-17a4-a15284e47f56
# ╠═47c147e6-3888-11eb-1574-cd2d6aea7b1c
# ╠═019df412-388a-11eb-17c1-2bfe6376975b
# ╠═d29eb8e8-3bc4-11eb-19db-213471925ca2
# ╠═428e6964-3bc7-11eb-2bde-9b9d607bec8b
# ╠═9ec584ca-3bc4-11eb-3d79-6bbd386e9715
# ╠═8c2fbd94-3bc4-11eb-1c00-136e0add7fcb
# ╠═6382c796-3bc5-11eb-087a-cde7d6b75abb
# ╠═33fcb568-3bc5-11eb-16b6-97ee834bb5cf
# ╠═0f1dc8d6-3bca-11eb-048c-b3dd68dee015
# ╠═7902a486-3bcc-11eb-0691-b9eedcc0b2c1
# ╠═f4b9ed26-3bd8-11eb-39ab-7d627dfa0712
# ╠═7e524662-3bcc-11eb-28c9-45b61768ed7d
# ╠═f56f80ce-3bcd-11eb-3cac-4d18887d9b36
# ╠═ea5878ba-3bcf-11eb-11fc-6f7fa62e6e88
