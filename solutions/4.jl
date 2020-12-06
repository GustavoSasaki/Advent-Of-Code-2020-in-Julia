### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 96d2b82a-37d0-11eb-06f7-77d3f8dbd9c9
using DataStructures

# ╔═╡ 3a2812d8-3770-11eb-34b0-7fd565a38a5f


# ╔═╡ 1a5162ec-376c-11eb-2960-5d2de63d1513
file = open(f->read(f, String), "day_4.txt")

# ╔═╡ 47348628-37cf-11eb-18cf-a3e7b88eceb2
begin
	md"separing every person passaport and its characteristics"
	person_pas = split(file, "\n\n",keepempty=false)
end

# ╔═╡ 3c3986fa-37d0-11eb-0c3b-fbcff15461da
person_pas[1]

# ╔═╡ af8f8f44-37d2-11eb-01ed-8772934a512f
md"validating function"

# ╔═╡ 43215040-37d2-11eb-35a6-4391952f9ef9
begin
	charac = ["ecl","pid","eyr","hcl","byr","iyr","hgt"]
	valid_charac(pass) = ( sum([occursin(c,pass) for c in charac]) == 7)
end

# ╔═╡ ece1fb94-37d1-11eb-2b9f-8df65e2cda06
sum([valid_charac(p)  for p in person_pas])

# ╔═╡ fcd1f052-376f-11eb-2e54-611deedd7c74
md"# Question 2"

# ╔═╡ ee13f122-37d2-11eb-2e70-c3b9fc16d1df
begin
	val_byr(yr::SubString) = 1920 ≤ parse(Int,yr) ≤ 2002
	val_iyr(yr::SubString) = 2010 ≤ parse(Int,yr) ≤ 2020
	val_eyr(yr::SubString) = 2020 ≤ parse(Int,yr) ≤ 2030
	function val_hgt(hgt::SubString)
		value = match(r"([0-9]+)",hgt).captures[1]
		if(occursin(r"cm",hgt))
			return 150 ≤ parse(Int,value) ≤ 193
		elseif (occursin(r"in",hgt))
			return 59 ≤ parse(Int,value) ≤ 76
		else return false
		end
		
	end
	val_hcl(hcl::SubString) = occursin(r"#[0-9a-f]{6}(?![0-9a-f])",hcl)
	val_ecl(ecl::SubString) = ecl in ("amb","blu","brn","gry","grn","hzl","oth")
	val_pid(pid::SubString) = occursin(r"^[0-9]{9}(?![0-9])",pid)
	function valid_charac2(pass)
		pass_c = [match(Regex("$(c):([^ \n]+)") ,pass).captures[1] for c in charac]
		pass_f = [val_ecl,val_pid,val_eyr,val_hcl,val_byr,val_iyr,val_hgt]
		return all([f(c) for (c,f) in zip(pass_c,pass_f)])
	end
end

# ╔═╡ 083fc8c4-37d4-11eb-0c3e-87633b5edeb6
sum([valid_charac(p) && valid_charac2(p) for p in person_pas])

# ╔═╡ 7a8b10c8-37d4-11eb-01c6-47332288862f
person_pas[1]

# ╔═╡ 04515e12-3770-11eb-2212-c55609da65f4


# ╔═╡ 58485228-3770-11eb-188a-e3f1060f6f89


# ╔═╡ 832f9fd6-3771-11eb-10cb-dd40d51e2e4c


# ╔═╡ bc646fec-3772-11eb-07a7-a963d0f51465


# ╔═╡ e59c62c0-3772-11eb-3887-c52aa4dcf981


# ╔═╡ Cell order:
# ╟─3a2812d8-3770-11eb-34b0-7fd565a38a5f
# ╠═96d2b82a-37d0-11eb-06f7-77d3f8dbd9c9
# ╠═1a5162ec-376c-11eb-2960-5d2de63d1513
# ╠═47348628-37cf-11eb-18cf-a3e7b88eceb2
# ╠═3c3986fa-37d0-11eb-0c3b-fbcff15461da
# ╠═af8f8f44-37d2-11eb-01ed-8772934a512f
# ╠═43215040-37d2-11eb-35a6-4391952f9ef9
# ╠═ece1fb94-37d1-11eb-2b9f-8df65e2cda06
# ╠═fcd1f052-376f-11eb-2e54-611deedd7c74
# ╠═ee13f122-37d2-11eb-2e70-c3b9fc16d1df
# ╠═083fc8c4-37d4-11eb-0c3e-87633b5edeb6
# ╠═7a8b10c8-37d4-11eb-01c6-47332288862f
# ╟─04515e12-3770-11eb-2212-c55609da65f4
# ╟─58485228-3770-11eb-188a-e3f1060f6f89
# ╟─832f9fd6-3771-11eb-10cb-dd40d51e2e4c
# ╟─bc646fec-3772-11eb-07a7-a963d0f51465
# ╟─e59c62c0-3772-11eb-3887-c52aa4dcf981
