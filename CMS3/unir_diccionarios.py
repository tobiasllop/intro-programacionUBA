from typing import List
from typing import Dict
import json

def unir_diccionarios(a_unir: List[Dict[str,int]]) -> Dict[str,List[int]]:
  diccionario = {}
  for i in a_unir:
    for clave,valor in (i.items()):
      if clave in diccionario:
        diccionario[clave].append(valor)
      else:
        diccionario[clave] = [valor]
  return diccionario

if __name__ == '__main__':
  x = json.loads(input()) # Ejemplo de input: [{"a":2},{"b":3,"a":1}]
  print(unir_diccionarios(x))