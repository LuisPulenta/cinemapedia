//Función sin argumentos que devuelve un String // Con cuerpo
String saludar1() {
  return 'Hola!';
}
//-----------------------------------------------------------

//Función sin argumentos que devuelve un String //Con funcion de flecha
String saludar2() => 'Hola!';
//-----------------------------------------------------------

//Funcion con argumentos posicionales que devuelve un entero //Con funcion de flecha
int addTwoNumbers1(int a, int b) => a + b;
//-----------------------------------------------------------

//Funcion con argumentos posicionales que devuelve un entero //Con cuerpo
int addTwoNumbers2(int a, int b) {
  return a + b;
}
//-----------------------------------------------------------

//Funcion con argumentos posicionales obligatorios y opcionales que devuelve un entero //Con funcion de flecha
int addTwoNumbers3(int a, [int b = 20]) => a + b;
//-----------------------------------------------------------

//Funcion con argumentos posicionales obligatorios y opcionales que pueden ser nulas //Con cuerpo
int addTwoNumbers4(int a, int? b) {
  b = b ?? 0;
  return a + b;
}
//-----------------------------------------------------------

//Funcion con argumentos por nombre obligatorios y opcionales
String saludarPersona({required String nombre, message = 'como estás?'}) {
  return 'Hola $nombre $message';
}
