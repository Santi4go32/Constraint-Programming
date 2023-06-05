include "globals.mzn";
array[1..9, 1..9] of var 1..9: casillas;


% Restricción de filas
constraint forall(i in 1..9) (
    all_different([casillas[i,j] | j in 1..9])
);

% Restricción de columnas
constraint forall(j in 1..9) (
    all_different([casillas[i,j] | i in 1..9])
);

% Restricción de regiones
constraint forall(k in 0..2, l in 0..2) (
    all_different([casillas[i,j] | i in 1+3*k..3*(k+1), j in 1+3*l..3*(l+1)])
);

% Solución
solve satisfy;



