file = open(f->read(f, String), "day_13.txt")


ids = [x.captures[1] for x in eachmatch(r"(\d+)",file)]
ids = parse.(Int64,ids)

(start,ids) = (ids[1], ids[2:end])

calulate_delay(x) = x -((start) % x )

index_min = argmin(calulate_delay.(ids))

print("awnser1 : $(ids[index_min] * calulate_delay(ids[index_min])) ")

#we can solve question 2 as a linear algebra problem,
#for example: The input 2,3 can be solve as:
#start_time + 2X = c
#start_time + 3X = c -1

#There is problably a way to find the basis of the problem and resolve it; 
#I dont know now, lets just learn more about linear algebra, RIP

a = [2 1;1 0]
b = [4;3]
a\b