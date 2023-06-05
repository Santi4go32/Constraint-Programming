include "globals.mzn";
int: n = 8;                             % número de personas
array[1..n] of string: personas = ["jose","julian","diana", "juan",
"david", "clauda","edgar","mario" ]; 
array[int, 1..2] of int: next = [|5,8|];       
array[int, 1..2] of int: separate = [|6,7|];        
array[int, 1..3] of int: distance = [|6,5,2|];     


array[1..n] of var 1..n: fila;


constraint alldifferent(fila);  



constraint forall(i in 1..length(next) where i mod 2 != 0) (
    abs(fila[next[i,1]] - fila[next[i,2]]) = 1  
);
constraint forall(i in 1..length(separate) where i mod 2 != 0) (
    abs(fila[separate[i,1]] - fila[separate[i,2]]) > 1  
);
constraint forall(i in 1..length(distance) where i mod 3 != 0 /\ i mod 2 != 0) (
    abs(fila[distance[i,1]] - fila[distance[i,2]]) <= fila[distance[i,3]]
);


solve satisfy;


output ["La fila es: \(fila)"];




