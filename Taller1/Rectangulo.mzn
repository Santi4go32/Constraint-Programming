include "globals.mzn";


int: n = 6;

array[1..n] of int: cuadrados = [3, 2, 2, 1, 1, 1];

int: ancho = 5;
int: altura = 4;

array[1..n] of var 0..ancho: x;
array[1..n] of var 0..altura: y;

constraint forall(i, j in 1..n where i < j) (
    (x[i] + cuadrados[i] <= x[j]) \/ (x[j] + cuadrados[j] <= x[i]) \/
    (y[i] + cuadrados[i] <= y[j]) \/ (y[j] + cuadrados[j] <= y[i])
);

constraint forall(i in 1..n) (
    x[i] + cuadrados[i] <= ancho /\ y[i] + cuadrados[i] <= altura
);

constraint sum(i in 1..n) (cuadrados[i] * cuadrados[i]) = ancho * altura;

solve satisfy;

% imprimir solución
output ["El cuadrado " ++ show(i) ++ " en la posición (" ++ show(x[i]) ++ ", " ++ show(y[i]) ++ ") con ancho y alto " ++ show(cuadrados[i]) ++ "\n" | i in 1..n];
