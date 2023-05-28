from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
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
    
if __name__ == '__main__':
  x = input()
  print(mesetaMasLarga([int(j) for j in x.split()]))