%Organización de un Evento Deportivo

int: num_disciplinas = 4;
int: num_participantes = 6;
int: num_lugares = 2;

% Variables de decisión
array[1..num_disciplinas] of var 1..num_lugares: lugar; 
array[1..num_disciplinas] of var 1..6: inicio_disciplina; 
array[1..num_disciplinas] of var 1..num_participantes: participantes; 

% Duraciones de las disciplinas
array[1..num_disciplinas] of int: duracion = [2, 3, 1, 2]; 

% Capacidad máxima de los lugares
array[1..num_lugares] of int: capacidad_lugar = [5, 6];

% Restricción de participación
constraint forall(p in 1..num_participantes, i, j in 1..num_disciplinas where i != j)(
  participantes[i] == p /\ participantes[j] == p -> (inicio_disciplina[i] + duracion[i] <= inicio_disciplina[j]) \/
  (inicio_disciplina[j] + duracion[j] <= inicio_disciplina[i])
);

% Restricción de capacidad de los lugares
constraint forall(l in 1..num_lugares)(
  count(i in 1..num_disciplinas) (lugar[i] == l) <= capacidad_lugar[l]
);


% Restricción de capacidad de los lugares
constraint forall(l in 1..num_lugares)(
  sum([duracion[i] | i in 1..num_disciplinas where lugar[i] = l]) <= capacidad_lugar[l]
);

% Objetivo: Minimizar el tiempo total utilizado
solve minimize max(i in 1..num_disciplinas) (inicio_disciplina[i] + duracion[i]);
