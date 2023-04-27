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
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = True
todosDistintos (x:xs) | elem x xs = False
                      | otherwise = todosDistintos xs

--3
maximo :: [Integer] -> Integer
maximo [x] = x
maximo (x:xs) | (head xs) >= x = maximo xs 
              | otherwise = x


{-


principio :: [t] -> [t]
principio (x:xs) | null xs == True = [] ++ []
                 | otherwise = ([] ++ [x]) ++ principio xs
reverso :: [t] -> [t]
reverso (x:xs) | null xs == True = [x] ++ []
               | otherwise = reverso xs ++ ([x] ++ []) 
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece n t | n == head t = True
              | null (tail t) == True && n /= head t = False
              | otherwise = pertenece n (tail t)
todosIguales :: (Eq t) => [t] -> Bool
todosIguales [] = True
todosIguales t | head t == (head (tail t)) && null (tail (tail t)) == True = True
               | head t /= (head (tail t)) = False
               | otherwise = todosIguales (tail t)
subTodosDistintos :: (Eq t) => [t] -> [t] -> [t] -> Bool
subTodosDistintos n m [] = True
subTodosDistintos n m q | longitud n == 1 = True 
                        | null (tail (tail n)) == True && head n /= head q = subTodosDistintos m (principio m) (ultimo m) 
                        | head n == head q = False 
                        | otherwise = subTodosDistintos (tail n) m q 
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos n = subTodosDistintos n (principio n) (ultimo n)
subhayRepetidos :: (Eq t) => [t] -> [t] -> [t] -> Bool
subhayRepetidos n m [] = False
subhayRepetidos n m q | longitud n == 1 = False 
                   | null (tail (tail n)) == True && head n /= head q = subhayRepetidos m (principio m) (ultimo m) 
                   | head n == head q = True
                   | otherwise = subhayRepetidos (tail n) m q 
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos n = subhayRepetidos n (principio n) (ultimo n)
subquitar :: (Eq t) => t -> [t] -> [t] -> [t]
subquitar n [] h = []
subquitar n (x:xs) h | n == x = h ++ [] ++ xs
                  | otherwise = subquitar n xs (h ++ [x])
quitar :: (Eq t) => t -> [t] -> [t]
quitar n t = subquitar n t []
quitarTodos :: (Eq t ) => t -> [t] -> [t] 
quitarTodos n m | pertenece n m == False = m 
                | otherwise = quitarTodos n (quitar n m)
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (x:xs) | null xs == True = [] ++ [x] 
                         | otherwise = [x] ++ (eliminarRepetidos (quitarTodos x xs))   
submismosElementos :: (Eq t) => [t] -> [t] -> Bool
submismosElementos [] _ = False
submismosElementos _ [] = False
submismosElementos (x:xs) t | pertenece x t == False = False
                         | null xs == True && pertenece x t == True = True
                         | otherwise = submismosElementos xs t
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos n t | submismosElementos n t == True && submismosElementos t n == True = True
                    | otherwise = False
--capicua :: (Eq t) => [t] -> Bool
cortarDesdeHasta :: (Eq t) => [t] -> Int -> Int -> [t]
cortarDesdeHasta n a b | b == 0 = [] ++ [head n]
                      | a == 0 = cortarDesdeHasta (tail n) a (b-1) ++ [head n]
                      | otherwise = cortarDesdeHasta (tail n) (a-1) b
                      
-}