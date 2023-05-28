from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def filasParecidas(matriz: List[List[int]]) -> bool :
  i = 0
  j = 0
  res = True
  if (len(matriz[0]) > 1):
    for i in range(len(matriz)-1):
      for j in range(len(matriz[i])-1):
        res = matriz[i+1][j] - matriz[i][j] == matriz[i+1][j+1] - matriz[i][j+1]
        j = j+1
      j = 0
      i = i +1     
  else:
    for i in range(len(matriz)-2):
      res = matriz[i+1][0] - matriz[i][0] == matriz[i+2][0] - matriz[i+1][0]
      i = i+1
  return res

if __name__ == '__main__':
  filas = int(input())
  columnas = int(input())
 
  matriz = []
 
  for i in range(filas):         
    fila = input()
    if len(fila.split()) != columnas:
      print("Fila " + str(i) + " no contiene la cantidad adecuada de columnas")
    matriz.append([int(j) for j in fila.split()])
  
  print(filasParecidas(matriz))