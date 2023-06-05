% Datos de entrada
int: N;  % número de generadores
int: M;  % número de unidades de tiempo
array[1..M] of int: demanda;  % demanda en cada hora
int: precioMax;  % precio máximo de compra por KW

array[1..N, 1..M] of int: ofertas;  % capacidad de producción de cada generador
array[1..N] of int: PV;  % precio de venta de cada generador

array[1..N, 1..M] of var 0..max(demanda): cantidad; % Cant
var 0..precioMax: PC; % precio de compra


% Restricciones
constraint N >= 0 /\ M >=0 /\ precioMax >= 0;

constraint forall(j in 1..M) (
  sum(i in 1..N)(cantidad[i,j]) == demanda[j] /\ demanda[j] >= 0
);

constraint PC == max([PV[i] | i in 1..N where sum(j in 1..M)(cantidad[i,j]) > 0]);

constraint forall(i in 1..N, j in 1..M) (
  PV[i] >= 0 /\ cantidad[i,j] * PV[i] <= PC * cantidad[i,j]
);

constraint forall(i in 1..N, j in 1..M)(
   cantidad[i,j] <= ofertas[i,j] /\ ofertas[i,j] >= 0
);



%redundantes
constraint sum(i in 1..N, j in 1..M)(cantidad[i,j]) <= sum(i in 1..N,j in 1..M)(ofertas[i,j]);
constraint PC <= precioMax;

% %simetrías
% constraint forall(i in 1..N-1)(
%   sum(j in 1..M)(cantidad[i,j]) >= sum(j in 1..M)(cantidad[i+1,j])
% );


% Función objetivo
var int: V = sum(i in 1..N, j in 1..M)(cantidad[i,j] * PV[i]);
% solve minimize V;

%búsqueda en orden inverso
% solve :: int_search([cantidad[i,j] | i in 1..N, j in 1..M] ++ [PC] , anti_first_fail, indomain_random, complete) minimize V;

%búsqueda con orden aleatorio y split
% solve :: int_search([cantidad[i,j] | i in 1..N, j in 1..M] ++ [PC] , occurrence, indomain_split, complete) minimize V;

%búsqueda local
% solve :: int_search([cantidad[i,j] | i in 1..N, j in 1..M] ++ [PC], input_order, indomain_min, complete) minimize V;

%Búsqueda local con variable de decisión ponderada:
% solve ::int_search(cantidad, occurrence, indomain_min, complete) minimize V;

%Split
 solve :: int_search(cantidad, first_fail, indomain_split) minimize V;


output [
    "Hora\t" ++ concat([ "Gen" ++ show(i) ++ "\t" | i in 1..N ]) ++ "||\tPC \n"
] ++
[
    if j = 0 then 
        "0\t|"
        ++ concat([show(cantidad[i,j]) ++ "\t|" | i in 1..N])
        ++ "|\t"++ show(PC) ++ "\n" 
    else
        show(j) ++ "\t| "
        ++ concat([show(cantidad[i,j]) ++ "\t|" | i in 1..N])
        ++ "|\t"++ show(PC) ++ "\n"
    endif
    | j in 1..M
];



























