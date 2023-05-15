import math

#1.1
def raizde2():
    res = round(math.sqrt(2), 4)
    print(res)
#raizde2() 

#1.2
def imprimir_hola():
    print("Hola")
#imprimir_hola()

#1.3
def imprimir_verso():
    print("Te estas portando mal,")
    print("Seras castigada")
    print("Te encerrare en mi cuarto hasta la madrugada")
#imprimir_verso()

#1.4
def factorial_2():
    res = math.factorial(2)
    print(res)
#factorial_2()

#1.5
def factorial_3():
    res = math.factorial(3)
    print(res)
#factorial_3()

#1.6
def factorial_4():
    res = math.factorial(4)
    print(res)
#factorial_4()

#1.7
def factorial_5():
    res = math.factorial(5)
    print(res)
#factorial_5()

#2.1
def imprimir_saludo(x):
    print(f"Hola {x}")

#2.2
def raiz_cuadrada_de(x):
    print(math.sqrt(x))

#2.3
def imprimir_dos_veces(x):
    print(x)
    print(x)

#2.4
def es_multiplo_de(n: int,m: int) -> bool: 
    res: bool
    res = n%m == 0
    return res
#2.5 
def es_par(n:int) -> bool:
    res : bool 
    res = es_multiplo_de(n,2)
    return res

#3.3
def es_nombre_largo(x:str) -> bool:
    res: bool = len(x) > 2 and len(x) < 9
    return res


#6.2
def imprimir_pares():
    res:int = 10
    while (res <= 40):
        if es_par(res) == True:
            print(res)
            res = res + 1
        else:
            res = res + 1