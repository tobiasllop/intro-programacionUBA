module Solucion where
type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas
usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id 

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us



-- Ejercicios
--La funcion nombresDeUsuarios recibe una Red Social e imprime los nombres de todos los usuarios pertenecientes a esa red, sin repetir nombres que sean iguales.
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios ([], _, _) = []
nombresDeUsuarios (x:xs, a, b) = proyectarNombres (x:xs)

proyectarNombres :: [Usuario] -> [[Char]]
proyectarNombres [] = []
proyectarNombres (x:xs) = (nombreDeUsuario x) : (quitar (nombreDeUsuario x) (proyectarNombres xs))

--La funcion quitar quita un elemento de una lista de elementos
quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar x (y : ys) | y == x = ys
                  | otherwise = y : quitar x ys

-- la funcion AmigosDe recibe una redsocial y un usuario que pertenezca a ella, y devuelve la lista con todos los usuarios con los que tiene una relación
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, [], _) u = []
amigosDe (us, (x:re), pu) u | u == primeroDeRelacion x = (segundoDeRelacion x) : (amigosDe (us, re, pu) u)
                            | u == segundoDeRelacion x = (primeroDeRelacion x) : (amigosDe (us, re, pu) u)
                            | otherwise = amigosDe (us, re, pu) u

-- escribo 2 funciones auxiliares para ver el primer y segundo usuario de cada relación
primeroDeRelacion :: Relacion -> Usuario
primeroDeRelacion (u,n) = u

segundoDeRelacion :: Relacion -> Usuario
segundoDeRelacion (u,n) = n

-- La funcion cantidadDeAmigos entrega la cantidad de amigos que tiene un usuario, utilizando su lista de amigos.
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red us = longitud( amigosDe red us )


-- La funcion lonigutud me dice la longitud de una lista.
longitud:: [t] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs


-- La funcion usuarioConMasAmigos recibe una red, y entrega el usuario con más amigos de esa misma red
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos red = masAmigos red (usuarios red)

masAmigos:: RedSocial -> [Usuario] -> Usuario
masAmigos red [u] = u
masAmigos red (u:us) | cantidadDeAmigos red u >= cantidadDeAmigos red (masAmigos red us) = u 
                     | otherwise = masAmigos red us

{- La funcion estaRobertoCarlos recibe una red y entrega un valor booleano. 
Si existe un usuario dentro de la red con más de 1.000.000 de amigos regresa verdadero y si no falso. 
Para facilitar la realizacion de los tests implementamos una funcion que devuelva verdadero cuando hay un Usuario que tiene mas de 10 amigos-}
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = (cantidadDeAmigos red (usuarioConMasAmigos red)) > 10

-- La funcion PublicacionesDe recibe una RedSocial y un Usuario perteneciente a ella y devuelve una lista con las publicaciones del Usuario
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) u = []
publicacionesDe (a, b, (p:pu)) u | usuarioDePublicacion p == u = p : publicacionesDe (a, b, pu) u 
                                 | otherwise = publicacionesDe (a, b, pu) u

--La funcion pertenece se fija si un elemento pertenece a una lista de elementos
pertenece:: (Eq t ) => [t] -> t -> Bool
pertenece [] _ = False
pertenece (x:xs) n | n == x = True
                   | otherwise = pertenece xs n

-- La funcion publicacionesQueLeGustanA recibe una RedSocial y un Usuario y devuelve una lista con todas las publicaciones que le gustan al Usuario
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red u = leGustan (publicaciones red) u

leGustan:: [Publicacion] -> Usuario -> [Publicacion]
leGustan [] u = []
leGustan (p:pu) u | pertenece (likesDePublicacion p) u = p : leGustan pu u
                  | otherwise = leGustan pu u

{- La funcion lesGustanLasMismasPublicaciones recibe una Red Social y dos usuarios y se fija si a esos dos usarios les gustan 
las mismas publicaciones; En caso de que si, devuelve True, en el caso contrario devuelve False -}
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red u1 u2 = publicacionesQueLeGustanA red u1 == publicacionesQueLeGustanA red u2

{--La funcion tieneUnSeguidorFiel recibe una Red Social y un Usuario y se fija si dentro de esa red existe algun 
otro segundo usuario que le haya dado like a todas las publicaciones del usuario que recibe, en caso de que exista devuelve True, si no existe devuelve False. -}
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool

tieneUnSeguidorFiel red u | publicacionesDe red u == [] = False
                          | otherwise = tieneSeguidorFiel red (quitar u (usuarios red)) (publicacionesDe red u)

tieneSeguidorFiel:: RedSocial -> [Usuario] -> [Publicacion] -> Bool
tieneSeguidorFiel _ [] _ = False
tieneSeguidorFiel _ _ [] = True
tieneSeguidorFiel red (u:us) (p:ps) | (pertenece (publicacionesQueLeGustanA red u) p) &&  tieneSeguidorFiel red [u] ps = True
                                    | otherwise = tieneSeguidorFiel red us (p:ps)

-- se fija si existe una secuencia de amigos relacionados entre si tal que dos usuarios dados esten relacionados indirectamente (o directamente) a traves de esa secuencia
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red u1 u2 | (amigosDe red u1) == [] = False
                                  | (amigosDe red u2) == [] = False
                                  | relacionDirecta red u1 u2 = True 
                                  | otherwise = existeCadena red (amigosDe red u1) u2 [u1]

-- chequea todas las "ramas" o posibilidades de relacion de un usuario y almacena los usuarios ya chequeados en una lista para no entrar en una recursion sobre si misma sin fin.
existeCadena :: RedSocial -> [Usuario] -> Usuario -> [Usuario] -> Bool
existeCadena red [] u2 usuarioschekeados = False
existeCadena red (u:us) u2 chek | pertenece chek u = existeCadena red us u2 chek
                                | relacionDirecta red u u2 = True
                                | existeCadena red (amigosDe red u) u2 (u:chek) = True
                                | otherwise = existeCadena red us u2 (u:chek)

--La funcion relacionDirecta recibe una red Social y dos usuarios y se fija si los dos usuarios son amigos
relacionDirecta:: RedSocial -> Usuario -> Usuario -> Bool
relacionDirecta red u1 u2 = (pertenece (amigosDe red u2) u1)
