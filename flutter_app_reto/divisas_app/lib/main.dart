import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reto_1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Divisas G1 APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class entorno {
  final titulo;
  final color;
  final icnono;

  entorno(this.titulo, this.color, this.icnono);
}

//listado de monedas disponibles
List<DropdownMenuItem<String>> moneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(value: "USD", child: Text("USD")),
  DropdownMenuItem(value: "EUR", child: Text("EUR")),
  DropdownMenuItem(value: "COP", child: Text("COP"))
];

// cajas de texto programadas
final textOrigen = TextEditingController();
final textDestino = TextEditingController();

// para el boton de borrado
var str = "";
int neg = 0;
var edi = "";

//valores predeterminados para los select
String org = "USD";
String des = "USD";

// esta funcion me permite hacer la conversión
String conversionMoneda(origen, destino, cantidad) {
  String valor = "";
  if (origen == destino) {
    valor = cantidad;
  } else if (origen == "USD" && destino == "COP") {
    valor = (double.parse(cantidad) * 5000).toStringAsFixed(3);
  } else if (origen == "COP" && destino == "USD") {
    valor = (double.parse(cantidad) / 5000).toStringAsFixed(3);
  } else if (origen == "EUR" && destino == "COP") {
    valor = (double.parse(cantidad) * 5116).toStringAsFixed(3);
  } else if (origen == "COP" && destino == "EUR") {
    valor = (double.parse(cantidad) / 5116).toStringAsFixed(3);
  } else if (origen == "EUR" && destino == "USD") {
    valor = (double.parse(cantidad) * 1.001).toStringAsFixed(3);
  } else if (origen == "USD" && destino == "EUR") {
    valor = (double.parse(cantidad) / 1.001).toStringAsFixed(3);
  }

  return valor;
}

//listado de botones visuales
List<entorno> ent = <entorno>[
  entorno("1", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("2", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("3", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("4", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("5", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("6", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("7", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("8", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("9", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("0", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno(".", Color.fromARGB(255, 234, 161, 14), Icon(Icons.abc)),
  entorno("", Color.fromARGB(255, 133, 29, 29),
      Icon(Icons.cleaning_services_rounded)),
  entorno("", Colors.grey, Icon(Icons.arrow_back)),
  entorno("Cambiar", Colors.blueAccent, Icon(Icons.import_export_outlined))
];

class _MyHomePageState extends State<MyHomePage> {
  // la siguiente void me permite cambiar el valor de los select en tiempo real
  void intercambio(new_des, new_org, cantidad) {
    setState(() {
      org = new_org;
      des = new_des;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Origen :"),
                DropdownButton(
                    value: org,
                    items: moneda,
                    // cuando coloco el signo de interrogacion estoy engañando al sistema
                    onChanged: (String? xCoin) {
                      setState(() {
                        org = xCoin.toString();

                        //dentro de la actualización del select tambien actualizo el resultado
                        textDestino.text =
                            conversionMoneda(org, des, textOrigen.text);
                      });
                    }),
                Text("Destino :"),
                DropdownButton(
                    value: des,
                    items: moneda,
                    onChanged: (String? xCoin) {
                      setState(() {
                        des = xCoin.toString();

                        //dentro de la actualización del select tambien actualizo el resultado
                        textDestino.text =
                            conversionMoneda(org, des, textOrigen.text);
                      });
                    })
              ],
            ),
            TextField(
              controller: textOrigen,
              enabled: false,
              decoration: InputDecoration(
                  labelText: "Moneda de origen",
                  hintText: "0",
                  prefixIcon: Icon(Icons.money)),
            ),
            TextField(
              controller: textDestino,
              enabled: false,
              decoration: InputDecoration(
                  labelText: "Moneda de destino",
                  hintText: "0",
                  prefixIcon: Icon(Icons.money)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    //controla el hading del card
                    childAspectRatio: 1.8,
                  ),
                  itemCount: ent.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      color: ent[index].color,
                      elevation: 10,
                      child: ListTile(
                        title: Center(
                          child: index > 10
                              ? ent[index].icnono
                              : Text(
                                  ent[index].titulo,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                        ),
                        onTap: () {
                          if (index == 11) {
                            //boton de limpiado
                            textOrigen.text = "";
                            textDestino.text = "";
                          } else if (index == 12) {
                            //boton de borrado
                            str = textOrigen.text;
                            neg = str.length - 1;
                            edi = str.substring(0, neg);
                            textOrigen.text = edi;

                            if (neg < 1) {
                              //si no hay nada en origen, limpiar destino
                              textDestino.text = "";
                            } else {
                              // recalcular
                              textDestino.text =
                                  conversionMoneda(org, des, textOrigen.text);
                            }
                          } else if (index == 13) {
                            // boton para intercabiar valores del select
                            intercambio(org, des, textOrigen.text);
                            textDestino.text =
                                conversionMoneda(org, des, textOrigen.text);
                          } else {
                            //ejecución de lectura de origen y conversión en automatico
                            textOrigen.text =
                                textOrigen.text + ent[index].titulo;

                            textDestino.text =
                                conversionMoneda(org, des, textOrigen.text);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
