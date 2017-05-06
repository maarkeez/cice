//: Playground - noun: a place where people can play

import UIKit
//---------------------------------
// SINTAXIS BASICA - SWIFT
//---------------------------------
var str = "Hello, playground"

/*
 Comentario varias lineas
 */

//Comentario de una linea

//---------------------------------
// TIPOS BASICOS
//---------------------------------
var nombre : String = "David" // La paralabra "var" define una variable mutable, es decir, se puede sobreescribir su contenido.
let apellido = "Márquez" // INFERENCIA DE TIPO: define una variable inmutable, es decir, no va a cambiar. Al no indicar el tipo, estoy haciendo una inferencia del tipo.

nombre = "Felipe"
//apellido = "El jaiek"

let profesion = "Desarrollador de iOS"

//Impresión
print(profesion)

//Interpolación de String
print("El Sr. \(nombre), es \(profesion)")

//Interpolacio de String en Objetive C
//NSLog(@"El Sr. %@, es %@", nombre, profesion)

//Un entero es un puntero a la memoria
var numeroA : Int = 4
var numeroB = 3.5

//Casting de Int to Double
var multiplicacion = Double(numeroA) * numeroB
//Casting de Double to Int. Trunca el valor del Double.
var multiplicacionB = numeroA * Int(numeroB)

typealias EnteroDavid = Int
var numeroC : EnteroDavid = 34

multiplicacion = multiplicacion + Double(numeroC)
multiplicacion += Double(numeroA)

print("Mi nombre es \(nombre) y mi apellido es \(apellido) y soy \(profesion) y tengo \(numeroC) años")


//---------------------------------
// OPERADORES
//---------------------------------
var numeroD = 0
numeroD = 2 * 5 + 7
numeroD += 1
print(numeroD)
numeroD += 5
numeroD -= 10
var sino : Bool = true

if (sino) {
    print("OK")
}else {
    print("KO")
}

if ( nombre == "" || apellido == "" ) {
    print ("Coloca datos")
}else{
    print ("Ya hay datos")
}


if numeroD >= 7 {
    print("Correcto")
}else{
    print("incorrecto")
}

//if ternario
var resultado = numeroD != 0 ? Double(numeroA) / numeroB : 0


//---------------------------------
// STRINGS Y CARACTERES
//---------------------------------
var emptyString = ""
var anotherEmptyStrig = String()
var despedida = "Hola"
emptyString.isEmpty
despedida.isEmpty
var variableStringMutable = "David "
variableStringMutable += "Márquez "
variableStringMutable += "Delgado"

for character in despedida.characters{
    print(character)
}

let exclamacion : Character = "!"
despedida += String(exclamacion)

//Array de caracteres:
var categoriaCaracteres : [Character] = ["C", "b", "r", "t"]
var catString = String(categoriaCaracteres)



//---------------------------------
// ARRAYs
//---------------------------------
var iPhones = ["iPhone 4","iPhone 5","iPhone 6"]
var iPads = ["iPad Air","iPad Pro","iPad Mini"]

var dispositivos = iPhones + iPads

//Inserción al final
dispositivos.append("Mac Book Pro")
//Inserción en índice
dispositivos.insert("Watch 42 mm", at: 0)

//Puede que el espacio de memoria reservado tenga basura. Debería de limpiarse al principio
//dispositivos.removeAll()
dispositivos.remove(at: 5)

let iPhone5 = dispositivos[2]
let ultimoDispositivo = dispositivos.last
let primerDispositivo = dispositivos.first

for dispositivo in dispositivos{
    print(dispositivo)
}

//Borra del 0 a 1 e inserta el array que estamos asignando.
dispositivos[0...1] = ["Andres","Felipe","Ocampo"]
print (dispositivos)

var inArray = [String]()


//---------------------------------
// DICCIONARIOS
//---------------------------------
var diccionario : [String : String] = [:]

var otroDiccionarioVacio : [String : String] = Dictionary()

var coche : [String:String] = ["marca":"Renault","modelo":"Megane", "CVPotencia":"145 Caballos"]


//let sortedKeysAndValues = Array(coche.keys).sorted(<)
//let ordenadoYValores = sorted(coche) { $0 < $1}
//let ordenado = coche.sorted(by: <#T##((key: String, value: String), (key: String, value: String)) -> Bool#>)
// Ordenar Hash a partir de claves de manera ASC
let ordenadoB = coche.sorted(by: <)

let marcha = coche["marca"]
print(coche)
coche["modelo"] = "Seat"
print(coche)
coche["Año"] = "2016"
print(coche)

for elemento in coche{
    print("Clave: \(elemento.key), Valor: \(elemento.value)")
}


//---------------------------------
// OPCIONALES
//---------------------------------
var numeroEntero = 34
var numeroString = "3"
// Desempaquetado sensato: das por hecho que va a ser de ese tipo
var sumatorioStringEntero = numeroEntero + Int(numeroString)!
print (sumatorioStringEntero)
// MAL --> Optional binding: cojo el número opcional y lo inserto en una variable temporal para poder trabajar con ella.
// var sumatorio2StringEntero = numeroEntero + !(Int(numeroString) != nil)

// OPCIONAL Indicas que puede tener o NO tener valor. Es decir, puede ser nil
var nombreAA : String? = "Andres"
nombreAA = "Andres"

var nombreBB : String? = nil
var nombreModA : String! // Arranca en nulo directamente. Es lo mismo que la sentencia anterior.

if nombreModA != nil {
    print (" Es nil")
}else {
    print ("CRASH")
}

var nombreModB : String?
if let nombreModBDes = nombreModA {
    print(nombreModBDes)
}

var xOptional : Int?
xOptional = 2
var nuevoValorXOptional : String?
nuevoValorXOptional = String(describing: xOptional!) //Con esto accedemos al valor de OPCIONAL si no se pone el ! el valor sería "Optional(2)"
var ySumatoria : Int = 20
var resultadoSumaXY = nuevoValorXOptional! + String(ySumatoria)

//Lo imprimo si tiene contenido
if let resultadoSumatoria = nuevoValorXOptional{
    print(resultadoSumatoria)
}

let comidasDelDia = ["desayuno":"Leche con cereales", "comida":"Lentejas" , "cena":"Lasagna"]
let cena : String? = comidasDelDia["cena"]

if let cenaLunes = cena{
    print(cenaLunes)
}else{
    print("Hoy no ceno")
}

if cena != nil {
    print(cena!)
}else{
    print("Aquí NULL")
}

//---------------------------------
// FUNCIONES
//---------------------------------
func miSerieFavorita(){
    print("Lost")
}

miSerieFavorita()

func funcionConRetorno() -> String{
    return "Hola Mundo"
}

print(funcionConRetorno())

func miFuncionconParametro( param : String){
    print (param)
}
miFuncionconParametro( param : "Hola holita vecinito")

func miFuncionconParametro2( _ param : String){
    print (param)
}
miFuncionconParametro2( "Hola holita vecinito")

func numeroSecuencia(a : Int, b : Int, c : Int) -> Int {
    return ( a * b ) + c
}

let numeroRetornoSecuencia = numeroSecuencia(a: 2,b: 2,c: 3)