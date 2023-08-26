from queue import Queue
from typing import List
from typing import Dict
from typing import Union
import json

# ACLARACIÓN: El tipo de "pedidos" debería ser: pedidos: Queue[Dict[str, Union[int, str, Dict[str, int]]]]
# Por no ser soportado por la versión de CMS, usamos simplemente "pedidos: Queue"
def procesamiento_pedidos(pedidos: Queue,
                          stock_productos: Dict[str, int],
                          precios_productos: Dict[str, float]) -> List[Dict[str, Union[int, str, float, Dict[str, int]]]]:
  res = []
  while pedidos.empty() == False:
    diccionario = {}
    pedido = pedidos.get()
    diccionario["id"] = pedido["id"]
    diccionario["cliente"] = pedido["cliente"]
    diccionario["productos"] = pedido["productos"]
    diccionario["precio_total"] = 0
    diccionario["estado"] = "completo"
    for clave, valor in pedido["productos"].items():
       datos = chequearStock(clave, valor, stock_productos, precios_productos, diccionario)
       diccionario["precio_total"] = datos[1]
       if datos[0] == "incompleto":
          diccionario["estado"] = "incompleto"
    res.append(diccionario) 
  return res

def chequearStock(clave: str, valor: int, stock_productos: Dict[str, int], precios_productos: Dict[str, float], diccionario: Dict[str, Union[int, str, Dict[str, int], float]]) -> str:
  res = "completo"
  for key,value in stock_productos.items():
    if clave == key and value >= valor:
        diccionario["precio_total"] = diccionario["precio_total"] + valor * precios_productos[key]
        stock_productos[key] = value - valor
    elif clave == key and value < valor:
        diccionario["precio_total"] = diccionario["precio_total"] + value * precios_productos[key]
        diccionario["productos"][key] = value
        stock_productos[key] = 0
        res = "incompleto"
  return [res, diccionario["precio_total"]]

if __name__ == '__main__':
  pedidos: Queue = Queue()
  list_pedidos = json.loads(input())
  [pedidos.put(p) for p in list_pedidos]
  stock_productos = json.loads(input())
  precios_productos = json.loads(input())
  print("{} {}".format(procesamiento_pedidos(pedidos, stock_productos, precios_productos), stock_productos))

# Ejemplo input  
# pedidos: [{"id":21,"cliente":"Gabriela", "productos":{"Manzana":2}}, {"id":1,"cliente":"Juan","productos":{"Manzana":2,"Pan":4,"Factura":6}}]
# stock_productos: {"Manzana":10, "Leche":5, "Pan":3, "Factura":0}
# precios_productos: {"Manzana":3.5, "Leche":5.5, "Pan":3.5, "Factura":5}