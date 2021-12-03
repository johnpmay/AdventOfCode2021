input := FileTools:-Text:-ReadFile("AoC-2021-2-input.txt" ):

sample_input := "forward 5
down 5
forward 8
up 3
down 8
forward 2";

# split input into a flat list: one letter directions, and numbers into integers
course := map(s->ifelse(parse(s)::posint, parse(s), s[1]), StringTools:-Split(input)):

hpos := 0:
depth := 0:
aim := 0: # aim = depth in part 1

for i from 1 to nops(course) by 2 do
    if course[i] = "f" then
        x := course[i+1];
        hpos := hpos + x;
        depth := depth + aim*x;
    elif course[i] = "d" then
        aim := aim + course[i+1];
    elif course[i] = "u" then
        aim := aim - course[i+1];
    end if;
end do:

hpos * aim; # answer part 1
hpos * depth; # answer part 2
