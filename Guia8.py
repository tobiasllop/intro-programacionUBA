import numpy as np

# 1.3
def sumaTotal(l:list) -> int:
    suma = 0
    for i in l:
        suma = suma + i
    return suma

#1.4
def ordenados(l:"list[int]") -> bool:
    i=0
    res = True
    while ((i+1) < len(l)):
        if l[i] <= l[i+1]:
            i = i+1
        else:
            i = i+1
            res = False 
    return res

#1.6
def esPalindroma(p:str) -> bool:
    p = p.upper()
    i = len(p)-1
    j = 0
    res = True
    while(j <= i):
         if p[j] != p[i]:
             res = False
         j= j+1
         i=i-1            
    return res

#1.8
def saldoActual(movs:list[tuple[str, int]]) -> int:
    res = 0
    i = 0
    for i in range(len(movs)):
        if movs[i][0] == "I":
            res = res + movs[i][1]
        else:
            res = res - movs[i][1]
        i = i+1
    return res

#2.5
def daVueltaStr(s:str) -> str:
    s2:str = ""
    for i in s:
        s2 = i + s2
    return s2

#3.1
def nombresDeEstudiantes() -> list[str]:
    l:list[str] = []
    s:str = ""
    while s != "listo":
        s:str = input("Estudiante: ")
        l.append(s)
    l.remove("listo")
    return (l)

#4.4
def elevarMatrizCuadrada(d:int, p:int):
    m = np.random.random((d,d))
    res = np.copy(m)
    for _ in range(p-1):
       res = m @ res
    return res
