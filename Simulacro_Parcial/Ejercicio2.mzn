%Gestión de Inventarios en un Almacén

int: num_productos = 5;
int: num_estanterias = 3;

% Variables de decisión
array[1..num_productos] of var 1..num_estanterias: estanteria;
array[1..num_productos] of int: volumen;
array[1..num_productos] of int: tiempo_entrega;
array[1..num_productos] of int: prioridad;

% Volúmenes de productos
volumen = [4, 3, 5, 2, 1];

% Tiempos de entrega de los productos
tiempo_entrega = [2, 5, 3, 1, 4];

% Prioridad de los productos
prioridad = [1, 2, 3, 1, 2];

% Capacidad máxima de las estanterías
array[1..num_estanterias] of int: capacidad = [8, 6, 5];

% Restricción de capacidad de las estanterías
constraint forall(e in 1..num_estanterias) (
  sum([volumen[i] | i in 1..num_productos where estanteria[i] == e]) <= capacidad[e]
);

% Restricción de prioridad y tiempo de entrega
constraint forall(i in 1..num_productos) (
  tiempo_entrega[i] <= prioridad[i] * 2
);

% Objetivo: Minimizar el espacio total utilizado
solve minimize sum([volumen[i] | i in 1..num_productos]);