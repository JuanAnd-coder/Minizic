% Use this editor as a MiniZinc scratch book

%Numero de tareas,trabajdores y maquinas
int: num_tareas = 4;
int: num_trabajadores = 2;
int: num_maquinas = 2;

array[1..num_tareas] of var 1..num_trabajadores: trabajador;%Cada tarea es asignada a un trabajador
array[1..num_tareas] of var 1..num_maquinas: maquina;%Cada tarea es asignada a una maquina

%Duraciones de las tareas
array[1..num_tareas] of int: duraciones =[3,2,4,1];

%Variables para el tiempo de inicio de cada tarea
array[1..num_tareas] of var int: inicio_tarea;

%Variables para el tiempo de fin de cada tarea
array[1..num_tareas] of var int: fin_tarea;

% Relacion entre inicio y fin de la tarea
constraint forall(i in 1..num_tareas)(
fin_tarea[i] = inicio_tarea[i] + duraciones[i]);

% Restricciones de secuencia: T1 antes que T3 y T2 antes que T4
constraint inicio_tarea[1] < inicio_tarea[3]; % T1 antes que T3
constraint inicio_tarea[2] < inicio_tarea[4]; % T2 antes que T4

% Restriccion: dos tareas no pueden solaparse si usan la misma maquina 
constraint forall(i, j in 1..num_tareas where i != j)( maquina[i] = maquina[j] -> fin_tarea[i] <= inicio_tarea[j] / fin_tarea[j] <= inicio_tarea[i]);
 
 % Restriccion: dos tareas no pueden solaparse si son realizadas por el mismo trabajador
constraint forall(i, j in 1..num_tareas where i != j)(trabajador[i] = trabajador[j] -> fin_tarea[i] <= inicio_tarea[j] / fin_tarea[j] <= inicio_tarea[i]);

% Definir el makespan como el tiempo de finalizacion de la ultima tarea
 var int: makespan = max([fin_tarea[i] | i in 1..num_tareas]);

 % Funcion objetivo: minimizar el tiempo total de produccion (makespan)
 solve minimize makespan;
 
 % Salida: mostrar la asignacion de trabajadores, maquinas y el tiempo de inicio y fin de cada tarea
 output [
 "Asignacion de tareas a trabajadores y maquinas: n",
 "Trabajador asignado: ", show(trabajador), " n",
 "Maquina asignada: ", show(maquina), " n",
 "Tiempos de inicio: ", show(inicio_tarea), " n",
 "Tiempos de fin: ", show(fin_tarea), " n",
 "Makespan (Tiempo total): ", show(makespan), " n"
 ];