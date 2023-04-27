--1
longitud :: [t] -> Integer
longitud [] = 0
longitud [x] = 1
longitud xs = longitud (tail xs) + 1

ultimo :: [t] -> t
ultimo [x] = x
ultimo (x : xs) = ultimo xs

principio :: [t] -> [t]
principio (x : xs) = [x]

reverso :: [t] ->[t]
reverso [] = []
reverso (x:xs) = reverso xs ++ [x]

--2
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece x xs = elem x xs

todosIguales :: (Eq t) => [t] -> Bool
todosIguales [x] = True
todosIguales (x:xs) | pertenece x xs = todosIguales xs
                    | otherwise = False

todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [x] = True
todosDistintos (x:xs) | elem x xs = False
                      | otherwise = todosDistintos xs


hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [x] = False
hayRepetidos (x : xs) | pertenece x xs = True
                      | otherwise = hayRepetidos xs

quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar x (y : ys) | y == x = ys
                  | otherwise = y : quitar x ys

quitarTodos :: (Eq t ) => t -> [t] -> [t]
quitarTodos _[] = []
quitarTodos n m | pertenece n m = quitarTodos n (quitar n m)
                | otherwise = m

eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos [x] = [x]
eliminarRepetidos (x:xs) = [x] ++ (eliminarRepetidos (quitarTodos x xs))  

mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos [] [] = True 
mismosElementos (x:xs) l = pertenece x l == mismosElementos (quitarTodos x (eliminarRepetidos xs)) (quitarTodos x (eliminarRepetidos l)) 

capicua :: (Eq t) => [t] -> Bool
capicua l = l == reverso l 

--3
sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x : xs) = x + sumatoria xs

productoria :: [Integer] -> Integer
productoria [] = 1
productoria (x:xs) = x * productoria xs

maximo :: [Integer] -> Integer
maximo [x] = x
maximo (x:xs) | (head xs) >= x = maximo xs 
              | otherwise = x

sumarN :: Integer -> [Integer] -> [Integer]
sumarN n [] = []
sumarN n (x : xs) = (x + n) : sumarN n xs

sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero (x : xs) = x + x : sumarN x xs

sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo [] = []
sumarElUltimo (x : xs) = x + last (x:xs) : sumarElUltimo xs

pares :: [Integer] -> [Integer]
pares [] = []
pares (x : xs) | x `mod` 2 == 0 = x : pares xs
               | otherwise = pares xs

multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN n [] = []
multiplosDeN n (x : xs) | x `mod` n == 0 = x : multiplosDeN n xs
                        | otherwise = multiplosDeN n xs

ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar l = ordenar (quitar (maximo l) l) ++ [maximo l] 