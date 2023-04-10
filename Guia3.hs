--1
f :: Integer -> Integer
f n | n == 1 = 8  
    | n == 4 = 131
    | n == 16 = 16

g :: Integer -> Integer
g n | n == 8 = 16
    | n == 16 = 4
    | n == 131 = 1

h :: Integer -> Integer
h n | n == 8 = (f 16)
    | n == 16 = (f 4)
    | n == 131 = (f 1)

k :: Integer -> Integer
k n | n == 16 = (g 16)
    | n == 4 = (g 131)
    | n == 1 = (g 8)

-- 2
absoluto :: Integer -> Integer
absoluto n | n >= 0 = n
           | n < 0 = -n 

maximoAbsoluto ::  Integer -> Integer -> Integer
maximoAbsoluto n p | absoluto n >= absoluto p = n
                   | otherwise = p

esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe n p = mod p n == 0


digitoUnidades :: Integer -> Integer
digitoUnidades n | absoluto n < 10 = n
                 | otherwise = digitoUnidades ((absoluto n) - 10)

digitoDecenas :: Integer -> Integer
digitoDecenas n | absoluto n < 10 = digitoUnidades n
                | absoluto n < 100 = n
                | otherwise = digitoDecenas ((absoluto n) - 100)

--3
estanRelacionados :: Integer -> Integer -> Bool
estanRelacionados a b = mod (a * a) (a * b) == 0

--4
prodInt :: (Float, Float) -> (Float, Float) -> Float
prodInt a b = fst(a) * fst(b) + snd(a) * snd(b)

todomenor :: (Float, Float) -> (Float, Float) -> Bool
todomenor a b = fst(a) < fst(b) && snd(a) < snd(b)

sumarterna :: (Integer, Integer, Integer) -> Integer
sumarterna (a, b, c) = a + b + c