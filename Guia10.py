from queue import LifoQueue as Pila
#1
def contarlineas(nombre_archivo: str) -> int:
    res = 1 
    archivo = open(nombre_archivo, "r")
    for lines in archivo:
        res = res + 1
    return res
#3
def archivoReverso(nombre_archivo:str):
    archivo1 = open(nombre_archivo,"r")
    archivo2 = open("reverso.txt","w")
    contenido = archivo1.readlines()
    reverso = contenido [::-1]
    reverso[0] = reverso[0] + "\n"
    reverso[-1] = reverso[-1][:-1]
    res = archivo2.writelines(reverso)
    return res

#11
def buscarElMaximo(p:Pila) -> int:
    l = []
    while (p.empty == False):
        l.append(p.get())
    res = max(l)
    return res

#18
