import sys

def quienGana(j1: str, j2: str) -> str : 
    res = "Empate"
    while(j1 != j2):
       if (j1 =="Piedra" and j2 =="Tijera") or (j1=="Papel" and j2=="Piedra") or (j1=="Tijera" and j2=="Papel"):
          res = "Jugador1"
       else:
          res = "Jugador2"
       break
    return res

if __name__ == '__main__':
  x = input()
  jug = str.split(x)
  print(quienGana(jug[0], jug[1]))