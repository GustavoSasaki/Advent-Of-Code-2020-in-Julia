using DataStructures
file = readlines("day_17.txt")

function get_neig(pos)
    return [(pos[1]+i,pos[2]+j,pos[3]+k) for i =-1:1 for j =-1:1 for k =-1:1
        if  !(i==0 && j==0 && k==0)]
end

cubes = DefaultDict(false)
recently_change = []

#reading input
for (index_i, line) in enumerate(file)
    for (index_j,word) in enumerate(line)
        if (word == '#')
            cubes[(index_i,index_j,0)] = true
            push!(recently_change,(index_i,index_j,0))
            append!(recently_change, get_neig((index_i,index_j,0)))
        end
    end
end




for cycle in 1:6
    new_cubes = DefaultDict(false)
    new_recently_change = []
    
    for pos in recently_change
        neig = get_neig(pos)
        sum_Act = sum([cubes[x] for x in neig])

        if cubes[pos] == true
            if sum_Act == 2 || sum_Act == 3
                new_cubes[pos] = true
                append!(new_recently_change,neig)
                push!(new_recently_change,pos)
            end
        else
            if sum_Act == 3
                new_cubes[pos] = true
                append!(new_recently_change,neig)
                push!(new_recently_change,pos)
            end
        end
    end

    global cubes = new_cubes 
    global recently_change = new_recently_change
    println(cycle)
end

#heay, i could have made a better detect for possible active cubes, oh well
aa = 0
for (key, value) in cubes
    global aa+=value
end
print(aa)


#QUESTION 2 (the same thing but 3d)


file = readlines("day_17.txt")
function get_neig(pos)
    return [ (pos[1]+i,pos[2]+j,pos[3]+k,pos[4]+l) 
        for i =-1:1 for j =-1:1 for k =-1:1 for l=-1:1
        if  !(i==0 && j==0 && k==0 && l==0)]
end

cubes = DefaultDict(false)

#reading input
for (index_i, line) in enumerate(file)
    for (index_j,word) in enumerate(line)
        if (word == '#')
            pos = (index_i,index_j,0,0)
            cubes[pos] = true
        end
    end
end




for cycle in 1:6
    new_cubes = DefaultDict(false)
    recently_change = DefaultDict(0)
    
    #count neig acc
    for (pos, value) in cubes
        if value == false
            print("AAAAAAAA")
        end
        neig = get_neig(pos)

        for i in neig
            recently_change[i] += value
        end
    end

    #find new cycle value
    for (pos, neig_acc) in recently_change
        curr_act = cubes[pos]
        new_act = false
        
        new_act |= (curr_act == true &&(neig_acc == 3 || neig_acc == 2))
        new_act |= (curr_act == false && neig_acc == 3 )

        if(new_act == true)
            new_cubes[pos] = true
        end
    end

    global cubes = new_cubes 
    println(cycle)
end


aa = 0
for (key, value) in cubes
    global aa+=value
end
print(aa)