% Use this editor as a MiniZinc scratch book
% Definimos el tamaño de la secuencia
int: n;

% Definimos el arreglo de variables
array[1..n] of var 0..n-1: x;

% Restricciones
constraint forall(i in 0..n-1)(
    count(x,i) == x[i+1]
);

constraint sum(x) = n;

constraint sum(i in 0..n-1) (x[i+1]*(i-1)) = 0;

% No hay función objetivo, solo queremos enumerar todas las soluciones

% Ejecutamos el modelo
solve satisfy;

% Imprimimos todas las soluciones
output [show(x) ++ "\n"];