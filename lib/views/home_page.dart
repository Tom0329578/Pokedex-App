import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/views/output.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool error404 = false;
var isLoaded = false;
String textoutput = '';
String errormessage = ' ';

class _HomePageState extends State<HomePage> with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double textfieldWidth;
    if (deviceWidth >= 800) {
      textfieldWidth = 450;
    } else {
      textfieldWidth = deviceWidth - 20;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pokedex', textAlign: TextAlign.center),
          backgroundColor: Colors.red,
          shape:
              Border(bottom: BorderSide(color: Colors.grey.shade800, width: 6)),
          elevation: 5,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            'Vul de naam of het nummer in van een pokemon uit generatie 1 tot en met generatie 7\r\n\r\nKlik daarna op zoeken',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: textfieldWidth,
                            child: Form(
                              key: formGlobalKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: myController,
                                    decoration: const InputDecoration(
                                        labelText:
                                            "Vul een Pokemon naam of nummer in"),
                                    validator: (input) {
                                      if (isInputValid(input!)) {
                                        return null;
                                      } else {
                                        return 'Gebruik alleen letters en nummers';
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  RawMaterialButton(
                                      fillColor: Colors.red,
                                      onPressed: () {
                                        if (formGlobalKey.currentState!
                                            .validate()) {
                                          formGlobalKey.currentState!.save();
                                          setState(() {
                                            textoutput = myController.text;
                                          });
                                          Navigator.of(context)
                                              .push(_createRoute());
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      constraints: BoxConstraints.tightFor(
                                          width: textfieldWidth, height: 50.0),
                                      child: Text(
                                        "Zoeken",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                            ),
                          )),
                    ))
                  ],
                ),
                if (error404) ...[
                  Text(
                    errormessage,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.red.shade900),
                    textAlign: TextAlign.center,
                  ),
                ]
              ],
            ),
          ),
        ));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Output(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

mixin InputValidationMixin {
  bool isInputValid(String input) {
    String pattern = r"^[A-Za-z0-9']+$";
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(input);
  }
}
