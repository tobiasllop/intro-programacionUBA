#8.3
def sumaTotal(l:list) -> int:
    suma = 0
    for i in l:
        suma = suma + i
    return suma

#8.4
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

#8.6
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
