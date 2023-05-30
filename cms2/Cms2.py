from typing import List
from typing import Tuple
import sys

#Ej 1
def quienGana(j1: str, j2: str) -> str : 
    res = "Empate"
    while(j1 != j2):
       if (j1 =="Piedra" and j2 =="Tijera") or (j1=="Papel" and j2=="Piedra") or (j1=="Tijera" and j2=="Papel"):
          res = "Jugador1"
       else:
          res = "Jugador2"
       break
    return res

#Ej 2
def fibonacciNoRecursivo(n: int) -> int:
  f0 = 0 
  f1 = 1
  fn = f1+ f0
  if n == 0:
    fn =0
  if n==1:
    fn = 1
  i=0
  while(n > 1 and i < (n-1)):
    fn = f1+ f0
    f0 = f1
    f1 = fn
    i = i + 1
  return (fn)

#Ej 3
def mesetaMasLarga(l: List[int]) -> int :
  i = 0
  j=1
  mesetas = []
  res = 0
  for i in range(len(l)-1):
    if (l[i] == l[i+1]):
      j = j+1
    else:
      j = 1
    mesetas.append(j)
    i = i+1
  while (l != []):
    res = max(mesetas)
    break
  return res

#Ej 4
def mesetaMasLarga(l: List[int]) -> int :
  i = 0
  j=1
  mesetas = []
  res = 0
  for i in range(len(l)-1):
    if (l[i] == l[i+1]):
      j = j+1
    else:
      j = 1
    mesetas.append(j)
    i = i+1
  while (l != []):
    res = max(mesetas)
    break
  return res

#Ej 5
def sePuedeLlegar(origen: str, destino: str, vuelos: List[Tuple[str, str]]) -> int :
  res = -1
  recorrido = []
  i = 0
  while i < len(vuelos):
    if origen == vuelos[i][0] and origen not in recorrido:
      recorrido.append(vuelos[i][0])
      if destino == vuelos[i][1]:
        res = len(recorrido)
        i = i +1
      else:
        origen = vuelos[i][1]
        i = 0
    else:
      i = i+1
  return res