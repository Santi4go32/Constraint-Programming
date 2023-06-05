include "globals.mzn";

% int: alto = 6;
% int: ancho = 5; 

int: alto = 8;
int: ancho = 8;

array[1..alto, 1..ancho] of -1..0: entrada; %entrada auxiliar
array[1..alto, 1..ancho] of var -1..9: salida;  %salida
array[1..alto, 1..ancho] of -1..45: horizontal; %suma de horizontales
array[1..alto, 1..ancho] of -1..45: vertical; %suma de verticales                                        



constraint forall(i in 1..alto, j in 1..ancho) (
  horizontal[i,j] != -1 ->
    forall(k in 1..ancho) (
      entrada[i,k] = 0 -> salida[i,k] in 1..9
    )
);


constraint forall(i in 1..alto, j in 1..ancho) (
  vertical[i,j] != -1 ->
    forall(k in 1..alto) (
      entrada[k,i] = 0 -> salida[k,i] in 1..9
    )
);



constraint forall(i in 1..alto, j in 1..ancho) (
        horizontal[i,j] != -1 ->
        let {
            int: inicio = j+1;
            array[int] of int: filter = [k | k in inicio..ancho where entrada[i,k] = -1];
            int: fin = if length(filter) > 0 then filter[1]-1 else ancho endif
        } in (
            alldifferent([salida[i,k] | k in inicio..fin]) /\
            sum([salida[i,k] | k in inicio..fin]) = horizontal[i,j]
        )
);

constraint forall(i in 1..alto, j in 1..ancho) (
        vertical[i,j] != -1 ->
        let {
            int: inicio = i+1;
            array[int] of int: filter = [k | k in inicio..alto where entrada[k,j] = -1];
            int: fin = if length(filter) > 0 then filter[1]-1 else alto endif
        } in (
            alldifferent([salida[k,j] | k in inicio..fin]) /\
            sum([salida[k,j] | k in inicio..fin]) = vertical[i,j]
        )
);

constraint forall(i in 1..alto, j in 1..ancho) (
  entrada[i,j] = -1 -> salida[i,j] = -1
);


%simetrías
constraint forall(j in 1..ancho) (
  salida[1,j] <= min([salida[i,j] | i in 1..alto])
);

constraint forall(i in 1..alto) (
  salida[i,1] <= min([salida[i,j] | j in 1..ancho])
);


%entradas:

% entrada = [|-1,-1,-1,-1,-1|
%             -1,0, 0, 0, -1|
%             -1,0, 0, 0, -1|
%             -1,0, 0,-1, -1|
%             -1,-1,0, 0,  0|
%             -1,-1,0, 0,  0|];

entrada = [| -1,-1,-1,-1,-1,-1,-1,-1|
             -1,-1,-1,0,0,-1,-1,-1  |
             -1,-1,-1,0,0,0,-1,-1   |
             -1,0,0,0,-1,0,0,-1     |
             -1,0,0,-1,-1,-1,0,0    |
             -1,-1,0,0,-1,0,0,0     |
             -1,-1,-1,0,0,0,-1,-1   | 
            -1,-1,-1,-1,0,0,-1,-1|];
           
horizontal = [|-1,-1,-1,-1,-1,-1,-1,-1 |
               -1,-1,9,-1,-1,-1,-1,-1  |
               -1,-1,24,-1,-1,-1,-1,-1 |
               7,-1,-1,-1,12,-1,-1,-1  |
               12,-1,-1,-1,-1,10,-1,-1 |
               -1,14,-1,-1,9,-1,-1,-1  |
               -1,-1,22,-1,-1,-1,-1,-1 |
              -1,-1,-1,11,-1,-1,-1,-1|];
            

% horizontal = [|-1,-1,-1,-1,-1 |
%                9,-1,-1,-1,-1 |
%               13,-1,-1,-1,-1 |
%               13,-1,-1,-1,-1 |
%               -1,7,-1,-1,-1  |
%               -1,19,-1,-1,-1 |];

vertical = [|-1,-1,-1,10,15,-1,-1,-1 |
             -1,-1,-1,-1,-1,13,-1,-1 |
             -1,7,20,-1,-1,-1,23,-1  |
             -1,-1,-1,-1,-1,-1,-1,3  |
             -1,-1,-1,14,-1,8,-1,-1  |
             -1,-1,-1,-1,17,-1,-1,-1 |
             -1,-1,-1,-1,-1,-1,-1,-1 |
             -1,-1,-1,-1,-1,-1,-1,-1|];
            
% vertical = [|-1, 9,34, 4,-1|
%            -1,-1,-1,-1,-1 |
%            -1,-1,-1,-1,-1 |
%            -1,-1,-1,11, 3 |
%            -1,-1,-1,-1,-1 |
%            -1,-1,-1,-1,-1|];  


solve satisfy;


% output [ "Solución: \n"] ++ [ if j == ancho then show(salida[i,j]) ++ "\n"  else show(salida[i,j]) ++ "       " endif | i in 1..alto, j in 1..ancho ];


