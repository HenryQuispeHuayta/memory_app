import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool b1 = false;
  bool b2 = false;

  Timer? timer;
  int cont = 20;
  int cont2 = 2;

  int preIndex = -1;
  bool flip = false;

  List<GlobalKey<FlipCardState>> keyEstados = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];

  List<bool> tarjetas = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<int> imagen = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage('assets/imgs/0.jpg')),
              Text(
                'Henry Quispe Huayta',
                style: TextStyle(fontSize: 40),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '$cont',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: imagen.length,
                  itemBuilder: (context, index) => FlipCard(
                    key: keyEstados[index],
                    onFlip: () {
                      tarjeta(index);
                    },
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: tarjetas[index],
                    front: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    back: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.white,
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/imgs/${imagen[index]}.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: b1 ? null : contador,
                    // () {
                    //   contador();
                    // },
                    child: Text('INICIAR'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: b2 ? null : reiniciar,
                    // () {
                    //   reiniciar;
                    // },
                    child: Text('REINICIAR'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  reiniciar() {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
    setState(() {
      b1 = false;
      b2 = true;
      timer?.cancel();
      cont = 20;
      imagen.shuffle();
      tarjetas = [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true
      ];
      keyEstados = [
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
        GlobalKey<FlipCardState>(),
      ];
    });
  }

  contador() {
    imagen.shuffle();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        b1 = true;
        b2 = false;
        if (cont > 0) {
          cont--;
        } else {
          timer.cancel();
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('PERDISTE!!!'),
              content: const Text('Continuar?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: const Text('Si'),
                ),
              ],
            ),
          );

          cont = 10;
        }
      });
    });
  }

  tarjeta(int index) {
    if (!flip) {
      flip = true;
      preIndex = index;
    } else {
      flip = false;
      if (preIndex != index) {
        if (imagen[preIndex] != imagen[index]) {
          keyEstados[preIndex].currentState?.toggleCard();
          preIndex = index;
        } else {
          tarjetas[preIndex] = false;
          tarjetas[index] = false;
          if (tarjetas.every((t) => t == false)) {
            verRes();
          }
        }
      }
    }
  }

  verRes() {
    timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('GANSTE!!!'),
        content: const Text('Continuar?'),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: const Text('Si'),
          ),
        ],
      ),
    );
  }
}
