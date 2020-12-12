file = open(f->read(f, String), "day_12.txt")

regex = r"([A-Z])(\d+)"

input =[x.captures for x in eachmatch(regex,file)]

#converting to cartezian format
@NamedTuple{x::Int64,y::Int64,angle::Int64}


cartezinaize_comand = Dict()
cartezinaize_comand["N"] = (north(i) = (x=0,y=i,angle=0))
cartezinaize_comand["S"] = (south(i) = (x=0,y=-i,angle=0))
cartezinaize_comand["E"] = (east(i) =  (x=i,y=0,angle=0))
cartezinaize_comand["W"] = (west(i) =  (x=-i,y=0,angle=0))
cartezinaize_comand["L"] = (left(i) =  (x=0,y=0,angle=i))
cartezinaize_comand["R"] = (right(i) = (x=0,y=0,angle=-i))


angle_to_card = Dict([(0,"E"),(90,"N"),(180,"W"),(270,"S")])
function change_foward(letter,angle)
    if (letter != "F")
        return letter
    else

        angle = (angle % 360)#overflow angles
        angle += 360*(angle < 0)#fixing negative angle
        return angle_to_card[angle]
    end
end


#start moving
pos = (x=0,y=0,angle=0)

for (letter,value) in input
    #change F to equivalent command
    letter = change_foward(letter,copy(pos.angle))

    movement = cartezinaize_comand[letter](parse(Int64,value))

    newX = pos.x + movement.x
    newY = pos.y + movement.y
    newAngle = pos.angle + movement.angle
    global pos = (x=newX,y=newY,angle=newAngle)
end

print(abs(pos.x)+abs(pos.y))


##Question 2


matrix_rotation = Dict()
matrix_rotation[0] = [1 0;0 1]
matrix_rotation[90] = [0 -1;1 0]
matrix_rotation[180] = [-1 0;0 -1]
matrix_rotation[270] = [0 1;-1 0]


waypoint = [10;1]
pos = (x=0,y=0,angle=0)
for (letter,value) in input
    value = parse(Int64,value)
    if letter == "F"
        newX = pos.x + (waypoint[1] * value)
        newY = pos.y + (waypoint[2] * value)
        global pos = (x=newX,y=newY,angle=0)
    elseif letter == "N"
        global waypoint += [0;value]
    elseif letter == "S"
        global waypoint += [0;-value]
    elseif letter == "E"
        global waypoint += [value;0]
    elseif letter == "W"
        global waypoint += [-value;0]
    else #angle commands
        angle = if (letter == "L") value else -value end# left or right
        angle = (angle % 360)#overflow angles
        angle += 360*(angle < 0)#fixing negative angle

        #applying angle with matrix of rotation
        global waypoint = matrix_rotation[angle] * waypoint
    end

    print("\n $(pos)")
    print("\n $(waypoint)")
end


print("\n$(abs(pos.x)+abs(pos.y))")