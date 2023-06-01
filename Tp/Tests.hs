import Test.HUnit
import Solucion
import Data.Binary.Get (label)

main = runTestTT tests

tests = test [
   " nombresDeUsuarios Catedra" ~: (nombresDeUsuarios redACat) ~?= ["Juan","Natalia","Pedro","Mariela"],

    " amigosDe Catedra" ~: (amigosDe redACat usuario1) ~?= [usuario2, usuario4],

    " cantidadDeAmigos Catedra" ~: (cantidadDeAmigos redACat usuario1) ~?= 2,

    " usuarioConMasAmigos Catedra" ~: expectAny (usuarioConMasAmigos redACat) [usuario2, usuario4],

    " estaRobertoCarlos Catedra" ~: (estaRobertoCarlos redACat) ~?= False,

    " publicacionesDe Catedra" ~: (publicacionesDe redACat usuario2) ~?= [publicacion2_1, publicacion2_2],

    " publicacionesQueLeGustanA Catedra" ~: (publicacionesQueLeGustanA redACat usuario1) ~?= [publicacion2_2, publicacion4_1],

    " lesGustanLasMismasPublicaciones Catedra" ~: (lesGustanLasMismasPublicaciones redBCat usuario1 usuario3) ~?= True,

    " tieneUnSeguidorFiel Catedra" ~: (tieneUnSeguidorFiel redACat usuario1) ~?= True,

    " existeSecuenciaDeAmigos Catedra" ~: (existeSecuenciaDeAmigos redACat usuario1 usuario3) ~?= True,
   
   --Tests propios
   " nombresDeUsuarios con red vacia" ~: (nombresDeUsuarios redVacia) ~?= [],
    
   " nombresDeUsuarios con red de un solo usuario" ~: (nombresDeUsuarios redUnSoloUsuario) ~?= ["Kylian"],
   
   " nombresDeUsuarios con red de mas de un usuario y nombre repetido" ~: (nombresDeUsuarios redA) ~?= ["Kylian", "Yeni", " ", "Alan", "Bryan"],
    
   " amigosDe con red de un solo usuario" ~: (amigosDe redUnSoloUsuario kylian) ~?= [],
    
   " amigosDe con un usuario con un solo amigo" ~: (amigosDe redA kylian) ~?= [yeni],
    
   " amigosDe con red con mas de un usuario y un usuario que no tiene amigos" ~: (amigosDe redA sin_nombre) ~?= [],
   
   " amigosDe con red con mas de un usuario y un usuario que tiene mas de un amigo" ~: (amigosDe redA bryan) ~?= [yeni, alan],
    
   " cantidadDeAmigos con red no vacia y un usuario con mas de un amigo" ~: (cantidadDeAmigos redA yeni) ~?= 2,
    
   " cantidadDeAmigos con red no vacia y un usuario sin amigos" ~: (cantidadDeAmigos redA sin_nombre) ~?= 0,
    
   " cantidadDeAmigos con red de un solo usuario sin relaciones" ~: (cantidadDeAmigos redUnSoloUsuario kylian) ~?= 0,
    
   " usuarioConMasAmigos con red de un solo usuario" ~: (usuarioConMasAmigos redUnSoloUsuario) ~?= kylian,
    
   " usuarioConMasAmigos con un usuario que comparte casi todas las relaciones con otro usuario" ~: (usuarioConMasAmigos redC) ~?= sin_nombre,
    
   " usuarioConMasAmigos con tres usuarios que comparten cantidad de amigos" ~: expectAny (usuarioConMasAmigos redB) [kylian, yeni, sin_nombre],
    
   " estaRobertoCarlos con una red vacia" ~: (estaRobertoCarlos redVacia) ~?= False,
    
   " estaRobertoCarlos con una red en la que hay un usuario con mas de 10 amigos" ~: (estaRobertoCarlos redRob_carlos) ~?= True,
    
   " estaRobertoCarlos con una red en la que no hay un usuario con mas de 10 amigos" ~: (estaRobertoCarlos redA) ~?= False,
    
   " publicacionesDe con una red sin publicaciones vacias en las que un usuario tiene una sola publ." ~: (publicacionesDe redA yeni) ~?= [publi_yeni1],
    
   " publicacionesDe con una red sin publicaciones vacias en las que un usuario tiene mas de una publ." ~: (publicacionesDe redB yeni) ~?= [publi_yeni1, publi_yeni2],
    
   " publicacionesDe con una red con publicaciones vacias" ~: (publicacionesDe redUnSoloUsuario kylian) ~?= [],
    
   " publicacionesQueLeGustanA con un usuario al que no le gusto ninguna publicacion" ~: (publicacionesQueLeGustanA redB kylian) ~?= [],
    
   " publicacionesQueLeGustanA con una red sin publicaciones" ~: (publicacionesQueLeGustanA redUnSoloUsuario kylian) ~?= [],
    
   " publicacionesQueLeGustanA con un usuario al que le gusto una publicacion propia y otra mas" ~: (publicacionesQueLeGustanA redC bryan) ~?= [publi_bryan1, publi_yeni2],
    
   " publicacionesQueLeGustanA con un usuario al que le gusto una sola publicacion." ~: (publicacionesQueLeGustanA redC sin_nombre) ~?= [publi_yeni2],
    
   " lesGustanLasMismasPublicaciones con dos usuarios a los que no le gusta ninguna publ." ~: (lesGustanLasMismasPublicaciones redC kylian yeni) ~?= True,
    
   " lesGustanLasMismasPublicaciones con una red sin publicaciones" ~: (lesGustanLasMismasPublicaciones redPubsVacias kylian yeni) ~?= True,
    
   " lesGustanLasMismasPublicaciones con usuario1 = usuario2" ~: (lesGustanLasMismasPublicaciones redC kylian kylian) ~?= True,
    
   " lesGustanLasMismasPublicaciones con una red con una sola publicacion a la que los dos usuarios le dieron like" ~: (lesGustanLasMismasPublicaciones redUnaSolaPub sin_nombre bryan) ~?= True,
    
   " lesGustanLasMismasPublicaciones con dos usuarios a los que le gustan publicaciones distintas" ~: (lesGustanLasMismasPublicaciones redD kylian yeni) ~?= False,
    
   " lesGustanLasMismasPublicaciones con un usuario que comparte likes con el otro usuario pero que le dio like a otra publicacion mas" ~: (lesGustanLasMismasPublicaciones redC bryan alan) ~?= False,
    
   " tieneUnSeguidorFiel con una red con un solo usuario y una publicacion con un solo like de el mismo" ~: (tieneUnSeguidorFiel redUnapubyunUs kylian) ~?= False,
    
   " tieneUnSeguidorFiel con una red sin publicaciones" ~: (tieneUnSeguidorFiel redUnSoloUsuario kylian) ~?= False,
    
   " tieneUnSeguidorFiel con una publicacion del usuario sin likes" ~: (tieneUnSeguidorFiel redA yeni) ~?= False,
    
   " tieneUnSeguidorFiel con 3 usuarios que le dieron me gusta a todas las publicaciones" ~: (tieneUnSeguidorFiel redE kylian) ~?= True,
    
   " tieneUnSeguidorFiel con 1 usuario que le dio me gusta a todas las publicaciones" ~: (tieneUnSeguidorFiel redD kylian) ~?= True, 
    
   " existeSecuenciaDeAmigos con una red sin relaciones" ~: (existeSecuenciaDeAmigos redPubsVacias kylian yeni) ~?= False,
    
   " existeSecuenciaDeAmigos con una relacion directa entre u1 y u2" ~: (existeSecuenciaDeAmigos redA yeni kylian) ~?= True,
    
   " existeSecuenciaDeAmigos con una cadena de un usuario entre u1 y u2" ~: (existeSecuenciaDeAmigos redD yeni kylian) ~?= True,
    
   " existeSecuenciaDeAmigos con u2 que no esta relacionado con nadie" ~: (existeSecuenciaDeAmigos redB  kylian bryan) ~?= False,
    
   " existeSecuenciaDeAmigos con u1 que no esta relacionado con nadie" ~: (existeSecuenciaDeAmigos redB  bryan kylian) ~?= False,
    
   " existeSecuenciaDeAmigos con u1 = u2" ~: (existeSecuenciaDeAmigos redB  kylian kylian) ~?= True,
    
   " existeSecuenciaDeAmigos en la que no existe una relacion entre u1 y u2, pero u1 y u2 si estan relacionados con otros usuarios" ~: (existeSecuenciaDeAmigos redD  kylian sin_nombre) ~?= False,
    
   " existeSecuenciaDeAmigos en la que existe una cadena entre u1 y u2 de mas de un usuario en el medio" ~: (existeSecuenciaDeAmigos redF  kylian robertoCarlos) ~?= True
     ]

expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)

-- Ejemplos
--Usuarios
kylian = (1,"Kylian")
kylian2 = (7, "Kylian")
yeni = (2,"Yeni")
sin_nombre = (3," ")
alan = (4, "Alan")
bryan = (5, "Bryan")
robertoCarlos = (6, "Roberto Carlos")
amigo_de_robCarlos1 = (8, "Amigo de Roberto Carlos")
amigo_de_robCarlos2 = (9, "Amigo de Roberto Carlos")
amigo_de_robCarlos3 = (10, "Amigo de Roberto Carlos")
amigo_de_robCarlos4 = (11, "Amigo de Roberto Carlos")
amigo_de_robCarlos5 = (12, "Amigo de Roberto Carlos")

--Publicaciones
publi_yeni1 = (yeni, "Hola mundo", [])
publi_yeni2 = (yeni, "Que tal" , [bryan, alan, sin_nombre])
publi_alan1 = (alan, "Hola mundo", [])
publi_bryan1 = (bryan, "Hello world", [bryan])
publi_kylian1 = (kylian, "Hola soy kylyan", [bryan, alan, sin_nombre, yeni])
publi_kylian2 = (kylian, "Aguante yo", [kylian, alan])
publi_kylian3 = (kylian, "Dale me gusta porfa", [bryan])
publi_kylian4 = (kylian, "Soy un crack", [kylian])


-- Listas de Relaciones
relacionesA = [(kylian,yeni), (bryan, yeni), (alan, bryan)]
relacionesB = [(kylian, sin_nombre), (kylian, yeni), (yeni, sin_nombre)]
relacionesC = [(sin_nombre, kylian), (sin_nombre, yeni), (sin_nombre, alan), (alan, yeni)]
relacionesD = [(alan, yeni), (alan, kylian), (bryan, sin_nombre)]
relacionesE = [(kylian, yeni), (yeni, sin_nombre), (alan, sin_nombre), (alan, bryan)]
relacionesF = [(kylian, yeni), (kylian, sin_nombre), (kylian, bryan), (yeni, bryan), (yeni, sin_nombre), (bryan, sin_nombre), 
              (sin_nombre, alan), (alan, robertoCarlos), (robertoCarlos , kylian2), (robertoCarlos , amigo_de_robCarlos1)]
relacionesRob_Carlos = [(robertoCarlos, kylian), (robertoCarlos, kylian2), (robertoCarlos, alan), (robertoCarlos, bryan), (robertoCarlos, yeni), (robertoCarlos, sin_nombre),
                         (robertoCarlos, amigo_de_robCarlos1), (robertoCarlos,amigo_de_robCarlos2), (robertoCarlos, amigo_de_robCarlos3), (robertoCarlos, amigo_de_robCarlos4), (robertoCarlos, amigo_de_robCarlos5)]

--Listas de publicaciones
publicacionesA = [publi_yeni1]
publicacionesB = [publi_yeni1, publi_yeni2, publi_alan1]
publicacionesC = [publi_bryan1, publi_yeni2]
publicacionesD = [publi_kylian1, publi_kylian2]
publicacionesE = [publi_kylian1]

--Listas de Usuarios
usuariosA = [kylian, kylian2, yeni, sin_nombre, alan, bryan]
usuariosF = [kylian, kylian2, yeni, sin_nombre, alan, bryan, robertoCarlos, amigo_de_robCarlos1, amigo_de_robCarlos2, amigo_de_robCarlos3, amigo_de_robCarlos4, amigo_de_robCarlos5]

--Redes Sociales
redA = (usuariosA, relacionesA, publicacionesA)
redB = (usuariosA, relacionesB, publicacionesB)
redC = (usuariosA, relacionesC, publicacionesC)
redD = (usuariosA, relacionesD, publicacionesD)
redE = (usuariosA, relacionesE, publicacionesE)
redF = (usuariosF, relacionesF, publicacionesE)
redRob_carlos = (usuariosF, relacionesRob_Carlos, publicacionesE)
redUnaSolaPub = (usuariosA, relacionesC, [publi_kylian1])
redVacia = ([],[],[])
redUnSoloUsuario =([kylian],[],[])
redUnapubyunUs = ([kylian], [], [publi_kylian4])
redPubsVacias = (usuariosA, [], [])

-- Ejemplos Catedra

usuario1 = (1, "Juan")
usuario2 = (2, "Natalia")
usuario3 = (3, "Pedro")
usuario4 = (4, "Mariela")
usuario5 = (5, "Natalia")

relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_4 = (usuario4, usuario1) -- Notar que el orden en el que aparecen los usuarios es indistinto
relacion2_3 = (usuario3, usuario2)
relacion2_4 = (usuario2, usuario4)
relacion3_4 = (usuario4, usuario3)

publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4])
publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4])
publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5])
publicacion1_4 = (usuario1, "Este es mi cuarto post", [])
publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5])

publicacion2_1 = (usuario2, "Hello World", [usuario4])
publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4])

publicacion3_1 = (usuario3, "Lorem Ipsum", [])
publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])
publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5])

publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])
publicacion4_2 = (usuario4, "I am Bob", [])
publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])


usuariosACat = [usuario1, usuario2, usuario3, usuario4]
relacionesACat = [relacion1_2, relacion1_4, relacion2_3, relacion2_4, relacion3_4]
publicacionesACat = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redACat = (usuariosACat, relacionesACat, publicacionesACat)

usuariosBCat = [usuario1, usuario2, usuario3, usuario5]
relacionesBCat = [relacion1_2, relacion2_3]
publicacionesBCat = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redBCat = (usuariosBCat, relacionesBCat, publicacionesBCat)
