from procesamiento_pedidos import procesamiento_pedidos
from queue import Queue

tests = [
    {
        "lista_pedidos": [{
            'id': 5,
            'cliente': 'María',
            'productos': {'Manzana': 3, 'Leche': 2, 'Pan': 1}
        },
            {
            'id': 10,
            'cliente': 'Pedro',
            'productos': {'Leche': 4, 'Factura': 2}
        }],
        "stock_productos": {'Manzana': 10, 'Leche': 5, 'Pan': 3, 'Factura': 5},
        "precio_productos": {'Manzana': 3.5, 'Leche': 5.5, 'Pan': 3.5, 'Factura': 2.75},
        "resultado_esperado": [
            {
                'id': 5,
                'cliente': 'María',
                'productos': {'Manzana': 3, 'Leche': 2, 'Pan': 1},
                'precio_total': 25.0,
                'estado': 'completo'
            },
            {
                'id': 10,
                'cliente': 'Pedro',
                'productos': {'Leche': 3, 'Factura': 2},
                'precio_total': 22.0,
                'estado': 'incompleto'
            }
        ],
        "stock_esperado": {'Manzana': 7, 'Leche': 0, 'Pan': 2, 'Factura': 3},
    },
    {
        "lista_pedidos": [
            {
                'id': 21,
                'cliente': 'Gabriela',
                'productos': {'Manzana': 2}
            },
            {
                'id': 1,
                'cliente': 'Juan',
                'productos': {'Manzana': 2, 'Pan': 4, 'Factura': 6}
            }
        ],
        "stock_productos": {'Manzana': 10, 'Leche': 5, 'Pan': 3, 'Factura': 0},
        "precio_productos": {'Manzana': 3.5, 'Leche': 5.5, 'Pan': 3.5, 'Factura': 2.75},

        "resultado_esperado": [
            {
                'id': 21,
                'cliente': 'Gabriela',
                'productos': {'Manzana': 2},
                'precio_total': 7.0,
                'estado': 'completo'
            },
            {
                'id': 1,
                'cliente': 'Juan',
                'productos': {'Manzana': 2, 'Pan': 3, 'Factura': 0},
                'precio_total': 17.5,
                'estado': 'incompleto'
            }
        ],
        "stock_esperado": {'Manzana': 6, 'Leche': 5, 'Pan': 0, 'Factura': 0},
    },
]

fallos = []

for i, test in enumerate(tests):
    pedidos: Queue = Queue()
    [pedidos.put(p) for p in test["lista_pedidos"]]
    print(test["stock_productos"])
    res = procesamiento_pedidos(
        pedidos, test["stock_productos"], test["precio_productos"])
    print(test["stock_productos"])
    if res != test["resultado_esperado"] or test["stock_productos"] != test["stock_esperado"]:
        fallos.append(i+1)

if len(fallos):
    string = "Fallos --> "
    for fallo in fallos:
        string += "Test " + str(fallo) + ". "
    print(string)
else:
    print("Sin fallos ;)")
