### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2dd190ae-3888-11eb-2e68-090f885617d6
using DataStructures

# ╔═╡ 47c147e6-3888-11eb-1574-cd2d6aea7b1c
file = open(f->read(f, String), "day_8.txt")

# ╔═╡ 019df412-388a-11eb-17c1-2bfe6376975b
#first match get command, second get value of comand
regex = r"(\w{3}) \+?(-?\d+)"

# ╔═╡ f875f352-3952-11eb-3d4a-979e6ccb162f
to_int(x) = parse(Int64,x)

# ╔═╡ 913adf24-3955-11eb-2cf3-5bbfeee310db
program =[ (x.captures[1], to_int(x.captures[2])) for x in eachmatch(regex,file)]

# ╔═╡ 90ffacfe-388a-11eb-3224-377942614d33
begin
	mutable struct Register
		pointer::Int64
		value::Int64
		
	end
	
	Register() = Register(1,0)
	Register(pointer,value) = Register(pointer,value)
end

# ╔═╡ 2ffb9de0-3953-11eb-02f2-71323a50ca88
begin
	function nop(register, x)
		register.pointer += 1
	end
	
	function acc(register, x)
		register.value += x
		register.pointer += 1
	end
	
	function jmp(register, x)
		register.pointer += x
	end
end

# ╔═╡ 0edb82ea-3953-11eb-0547-5158b0364ddc
begin
	commands = Dict()
	commands["nop"] = nop; 
	commands["acc"] = acc;
	commands["jmp"] = jmp;
	
	function execute_line(register)
		line = program[register.pointer]
		commands[line[1]](register, line[2])
	end
end

# ╔═╡ ab476d98-3954-11eb-117e-dbb761d47b74
begin

	function execute_program()
		register= Register()
		visited = Dict() #every line executed
		
		while(haskey(visited,register.pointer) == false)
			visited[register.pointer] = true
			execute_line(register)
		end

		return (register.value , register.pointer)
	end
end

# ╔═╡ 11487890-3954-11eb-14f9-139bb83e3c6c
execute_program()

# ╔═╡ aab19fbe-3956-11eb-0e2e-4d1994109154
md"# Question 2"

# ╔═╡ ee71662e-3958-11eb-0204-09256c308b5f
begin

	function execute_program2(register,visited,has_switched)
		
		while(haskey(visited,register.pointer) == false)
			
			#Got end of program
				if size(program)[1]+1 == register.pointer
					return register.value
			end

			
			visited[register.pointer] = true
			
			line = program[register.pointer]
			cmd = commands[line[1]]
			cmd_value = line[2]
			
			#swap jump or swap
			if(has_switched == false)
				
				if(cmd == jmp)
					new_pointer = register.pointer + 1
					new_register = Register(new_pointer,register.value)
					result =execute_program2(new_register,copy(visited),true)
					
					if(result isa Int)
						return result
					end
					
				elseif (cmd == nop)
					new_pointer = register.pointer + cmd_value
					new_register = Register(new_pointer,register.value)
					result =execute_program2(new_register,copy(visited),true)	
					
					if(result isa Int)
						return result
					end
				end
			end
			
			cmd(register, cmd_value)
		end

		#program visited one line 2 times
		return false
		
	end
end

# ╔═╡ 5139d282-395b-11eb-15f9-9b3bd7c3eec3
execute_program2(Register(),Dict(),false)

# ╔═╡ e1945406-395b-11eb-0d7a-192a3e1f408d
size(program)[1]+1

# ╔═╡ Cell order:
# ╠═2dd190ae-3888-11eb-2e68-090f885617d6
# ╠═47c147e6-3888-11eb-1574-cd2d6aea7b1c
# ╠═019df412-388a-11eb-17c1-2bfe6376975b
# ╠═f875f352-3952-11eb-3d4a-979e6ccb162f
# ╠═913adf24-3955-11eb-2cf3-5bbfeee310db
# ╠═90ffacfe-388a-11eb-3224-377942614d33
# ╠═2ffb9de0-3953-11eb-02f2-71323a50ca88
# ╠═0edb82ea-3953-11eb-0547-5158b0364ddc
# ╠═ab476d98-3954-11eb-117e-dbb761d47b74
# ╠═11487890-3954-11eb-14f9-139bb83e3c6c
# ╠═aab19fbe-3956-11eb-0e2e-4d1994109154
# ╠═ee71662e-3958-11eb-0204-09256c308b5f
# ╠═5139d282-395b-11eb-15f9-9b3bd7c3eec3
# ╠═e1945406-395b-11eb-0d7a-192a3e1f408d
