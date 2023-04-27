
-- 1
fib :: Integer -> Integer
fib n | n == 0 = 0
      | n == 1 = 1
      | otherwise = fib (n - 1) + fib (n - 2)

-- 2
parteEntera :: Float -> Integer
parteEntera x | 0 <= x && x < 1 = 0
              | x >= 0 = parteEntera (x - 1) + 1

-- 3
esDivisor :: Integer -> Integer -> Bool
esDivisor n d
  | n == 0 = True
  | n < 0 = False
  | otherwise = esDivisor (n - d) d

-- 4

sumaImpares :: Integer -> Integer
sumaImpares n
  | n == 1 = 1
  | otherwise = sumaImpares (n - 1) + nesimoImpar n

nesimoImpar :: Integer -> Integer
nesimoImpar n
  | n == 1 = 1
  | otherwise = nesimoImpar (n - 1) + 2

-- 5
medioFact :: Integer -> Integer
medioFact n
  | n == 0 = 1
  | n == 1 = 1
  | n == 2 = 2
  | otherwise = n * medioFact (n - 2)

-- 6

sumaDigitos :: Integer -> Integer
sumaDigitos n
  | n < 10 = n
  | otherwise = mod n 10 + sumaDigitos (div n 10)

-- 7

todosDigitosIguales :: Integer -> Bool
todosDigitosIguales n
  | n < 10 = True
  | mod n 10 /= mod (div n 10)  10 = False
  | otherwise = todosDigitosIguales (div n 10)

-- 8

iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito i n
  | cantidadDeDigitos n == i = mod n 10
  | otherwise = iesimoDigito i resto
    where
      resto = div n 10

cantidadDeDigitos :: Integer -> Integer
cantidadDeDigitos n
  | n < 10 = 1
  | otherwise = 1 + cantidadDeDigitos resto 
  where
    resto = div n 10

-- 13

dobleSumatoria :: Integer -> Integer -> Integer
dobleSumatoria n m
  | n == 1 = segundaSumatoria 1 m
  | otherwise = dobleSumatoria (n - 1) m + segundaSumatoria n m

segundaSumatoria :: Integer -> Integer -> Integer
segundaSumatoria i m
  | m == 1 = i ^ m
  | otherwise = segundaSumatoria i (m - 1) + i ^ m

-- 14
sumaPotencias :: Integer -> Integer -> Integer -> Integer
sumaPotencias q n m | n == 0 = 0
                    | otherwise = sumaPotencias q (n-1) m + sumaIntpot q n m
sumaIntpot :: Integer -> Integer -> Integer -> Integer
sumaIntpot q n m | m == 0 = 0
                 | otherwise = q ^ (n + m) + sumaIntpot q n (m-1)            

-- 15

sumaRacionales :: Integer -> Integer -> Float
sumaRacionales n m
  | n == 1 = sumaInterna 1 m
  | otherwise = sumaRacionales (n - 1) m + sumaInterna n m

sumaInterna :: Integer -> Integer -> Float
sumaInterna p m
  | m == 1 = fromIntegral p / fromIntegral m
  | otherwise = sumaInterna p (m - 1) + fromIntegral p / fromIntegral m
