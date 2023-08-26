from queue import Queue

# El tipo de fila debería ser Queue[int], pero la versión de python del CMS no lo soporta. Usaremos en su lugar simplemente "Queue"
from queue import Queue
# El tipo de fila debería ser Queue[int], pero la versión de python del CMS no lo soporta. Usaremos en su lugar simplemente "Queue"
def avanzarFila(fila: Queue, min: int):
  minutoActual: int = 0
  filaParaEntrarDeCaja3: Queue = Queue()
  filaCopia: Queue = Queue()
  minutosDeClienteNuevo: list = list(range(0,min+1,4)) #(0, 4, 8, ...)
  minutosDeCaja1: list = list(range(1,min+1,10)) #(1, 11, 21, hasta que el núm no se pase de min)
  minutosDeCaja2: list = list(range(3,min+1,4)) #(3, 7, 11, ...)
  minutosDeCaja3: list = list(range(2,min+1,4)) #(2, 6, 10, ...)
  minutosParaVolverACaja3: list = list(range(5,min+1,4)) #(5, 9, 13, ...)
  for elemento in list(fila.queue):
    filaCopia.put(elemento)
  if fila.empty():
    proximoCliente: int = 1
  if not fila.empty():
    proximoCliente = (int(filaCopia.qsize()) + 1)
  while minutoActual <= min:
    if minutoActual in minutosDeClienteNuevo:
      fila.put(proximoCliente)
      proximoCliente += 1
    if minutoActual in minutosDeCaja1 and not fila.empty():
      fila.get()
    if minutoActual in minutosDeCaja2 and not fila.empty():
      fila.get()
    if minutoActual in minutosDeCaja3 and not fila.empty():
      filaParaEntrarDeCaja3.put(fila.get())
    if minutoActual in minutosParaVolverACaja3 and not filaParaEntrarDeCaja3.empty():
      fila.put(filaParaEntrarDeCaja3.get())
    #print(f"Minuto {minutoActual}: Fila: {list(fila.queue)}, Fila para entrar de Caja 3: {list(filaParaEntrarDeCaja3.queue)}")
    minutoActual += 1
  return fila

if __name__ == '__main__':
  fila: Queue = Queue()
  fila_inicial: int = int(input())
  for numero in range(1, fila_inicial+1):
    fila.put(numero)
  min: int = int(input())
  avanzarFila(fila, min)
  res = []
  for i in range(0, fila.qsize()):
    res.append(fila.get())
  print(res)


# Caja1: Empieza a atender 10:01, y atiende a una persona cada 10 minutos
# Caja2: Empieza a atender 10:03, atiende a una persona cada 4 minutos
# Caja3: Empieza a atender 10:02, y atiende una persona cada 4 minutos, pero no le resuelve el problema y la persona debe volver a la fila (se va al final y tarda 3 min en llegar. Es decir, la persona que fue atendida 10:02 vuelve a entrar a la fila a las 10:05)
# La fila empieza con las n personas que llegaron antes de que abra el banco. Cuando abre (a las 10), cada 4 minutos llega una nueva persona a la fila (la primera entra a las 10:00)

