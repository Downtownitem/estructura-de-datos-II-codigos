from tabulate import tabulate

# Nombres de los archivos que contienen los tiempos de ejecución
archivos = [
    "python_execution_time.txt",
    "javascript_execution_time.txt",
    "java_execution_time.txt",
    "cpp_execution_time.txt",
    "rust_execution_time.txt"
]

# Lista para almacenar los datos de la tabla
datos = []

# Leer cada archivo y extraer el tiempo de ejecución
for archivo in archivos:
    try:
        with open(archivo, 'r') as f:
            tiempo = f.read().strip()
            lenguaje = archivo.split('_')[0].capitalize()
            datos.append([lenguaje, tiempo])
    except FileNotFoundError:
        print(f"Error: El archivo {archivo} no se encontró.")
    except Exception as e:
        print(f"Error al leer el archivo {archivo}: {e}")

# Encabezados de la tabla
encabezados = ["Lenguaje", "Tiempo de Ejecución"]

# Imprimir la tabla formateada en la consola
print(tabulate(datos, headers=encabezados, tablefmt="grid"))
