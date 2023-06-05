include "globals.mzn";
% Parámetros
int: N = 3;
int: M = 3;
array[1..N] of float: C = [0.58, 1.55, 0.85];
array[1..N, 1..M] of float: D = [| 120.0, 100.0, 74.0, 
                                 | 60.0, 2.5, 4.0,
                                 |105.0, 3.0, 12.0 |];
                                 
array[1..M] of float: D_min = [89.0, 0.0, 17.0];
array[1..M] of float: D_max = [0.0, 11.0,0.0];

int: P = 12000;  

% Variables
array[1..N] of var int: costosInt = [round(C[i] * 100) | i in 1..N];
array[1..N,1..M] of var int: D_Int = array2d(1..N, 1..M, [round(D[i,j]*10) | i in 1..N, j in 1..M]);
array[1..M] of var int: D_minInt = [round(D_min[i] * 10 ) | i in 1..M];
array[1..M] of var int: D_maxInt = [round(D_max[i] * 10 ) | i in 1..M];

array[1..N] of var 0..P: cantidadIngredientes;


% Restricciones
constraint sum(cantidadIngredientes) = P;
constraint forall(i in 1..N) (cantidadIngredientes[i] >= 0);
constraint forall(i in 1..N)(
  if D_minInt[i]!=0 then sum([D_Int[i,j] * cantidadIngredientes[j] |j in 1..M])/P >= D_minInt[i]
  elseif D_maxInt[i]!=0 then sum([D_Int[i,j] * cantidadIngredientes[j] | j in 1..M])/P <= D_maxInt[i]
  else true
  endif
);



% Función objetivo
var int: cost = sum([costosInt[i] * cantidadIngredientes[i] | i in 1..N]);
solve minimize cost;


output["se utilizaron: " ++ show(cantidadIngredientes) ++ " galones respectivamente de Butano, Catalítico Reformado y de Nafta Pesado para producir: " ++ show(P) ++ " galones de gasolina a un costo mínimo de:" ++ show(cost/100)];


