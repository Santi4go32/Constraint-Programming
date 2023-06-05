include "globals.mzn";

enum musica = {pop, clasica, jazz};
enum nombre = {Oscar, Juan, Dario};
enum apellido = {Garcia, Gonzalez, Lopez};

set of int: edad = {24, 25, 26};

var nombre: persona1;
var apellido: persona1_apellido;
var edad: edad1;

var nombre: persona2;
var apellido: persona2_apellido;
var edad: edad2;

var nombre: persona3;
var apellido: persona3_apellido;
var edad: edad3;

var musica: persona1_music;
var musica: persona2_music;
var musica: persona3_music;

constraint all_different([persona1, persona2, persona3]);
constraint all_different([persona1_apellido, persona2_apellido, persona3_apellido]);
constraint all_different([persona1_music,persona2_music,persona3_music]);
constraint all_different([edad1,edad2,edad3]);

%simetrías
constraint persona2>persona3;
constraint edad3 > edad2;
constraint persona1_apellido > persona2_apellido;

%1
constraint persona1 == Juan /\ persona1_music != clasica /\ persona1_apellido != Gonzalez;
constraint persona2_apellido == Gonzalez /\ persona2_music == clasica /\ persona2 != Juan;
constraint edad1 > edad2;

%2
constraint (persona1_music = pop /\ persona1_apellido != Garcia -> edad1 != 24) /\
           (persona2_music = pop /\ persona2_apellido != Garcia -> edad2 != 24) /\
           (persona3_music = pop /\ persona3_apellido != Garcia /\ persona3 != Oscar -> edad3 != 24);
constraint (persona3_music = pop -> persona3_apellido != Garcia) /\ (persona3_apellido = Garcia -> persona3_music != pop);

%3
constraint (persona3 == Oscar /\ persona3_apellido != Lopez -> edad3 == 25);

%4
constraint persona3 != Dario \/ persona3_music != jazz;

%5
constraint edad1 >= 24 /\ edad1 <= 26 /\
           edad2 >= 24 /\ edad2 <= 26 /\
           edad3 >= 24 /\ edad3 <= 26;

solve satisfy;

output [show(persona1), " ", show(persona1_apellido), ", Edad: ", show(edad1), ", música favorita: ", show(persona1_music), "\n",             show(persona2), " ", show(persona2_apellido), ", Edad: ", show(edad2), ", música favorita: ", show(persona2_music), "\n",        show(persona3), " ", show(persona3_apellido), ", Edad: ", show(edad3), ", música favorita: ", show(persona3_music), "\n"];









































