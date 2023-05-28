import sys

def fibonacciNoRecursivo(n: int) -> int:
  f0 = 0 
  f1 = 1
  fn = f1+ f0
  if n == 0:
    fn =0
  if n==1:
    fn = 1
  i=0
  while(n > 1 and i < (n-1)):
    fn = f1+ f0
    f0 = f1
    f1 = fn
    i = i + 1
  return (fn)


if __name__ == '__main__':
  x = int(input())
  print(fibonacciNoRecursivo(x))