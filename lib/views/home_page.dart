import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/views/full_output.dart';
import 'package:flutter_opdracht_7/views/output.dart';
import 'package:flutter_opdracht_7/models/TypeList.dart';
import 'package:flutter_opdracht_7/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool error404 = false;
var isLoaded = false;
String textoutput = '';
String errormessage = ' ';
String statuscode = '';
String type = 'normal';

class _HomePageState extends State<HomePage> with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var dropDownValue;
  List<String>? types;
  TypeList? typeList;
  var isLoaded = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  double fontSize = 20;

  @override
  void initState() {
    super.initState();
    getTypes();
  }

  getTypes() async {
    typeList = await RemoteServices().getTypeList();
    if (typeList != null) {
      setState(() {
        dropDownValue = typeList?.results.first.name;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double textfieldWidth;
    if (deviceWidth >= 800) {
      textfieldWidth = 450;
    } else {
      textfieldWidth = deviceWidth - 40;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pokedex', textAlign: TextAlign.center),
          backgroundColor: Colors.red.shade700,
          shape:
              Border(bottom: BorderSide(color: Colors.grey.shade800, width: 6)),
          elevation: 5,
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w700),
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
                              'Enter the name or number of a Pokemon from generation 1 to 8\r\n\r\nThen tap the search button\r\n\r\nOr select a type and search all pokemon with that type',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ),
                      ]),
                  if (error404) ...[
                    Text(
                      errormessage,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.red.shade900),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
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
                                      decoration: InputDecoration(
                                        labelText:
                                            "Enter a Pokemon name or number",
                                        labelStyle: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14),
                                      ),
                                      validator: (input) {
                                        if (isInputValid(input!)) {
                                          return null;
                                        } else {
                                          return 'Only use valid characters';
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 40),
                                    RawMaterialButton(
                                        fillColor: Colors.red.shade700,
                                        onPressed: () {
                                          if (formGlobalKey.currentState!
                                              .validate()) {
                                            formGlobalKey.currentState!.save();
                                            setState(() {
                                              textoutput = myController.text;
                                            });
                                            Navigator.of(context)
                                                .push(_routeOutput());
                                          }
                                        },
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        constraints: BoxConstraints.tightFor(
                                            width: textfieldWidth,
                                            height: 50.0),
                                        child: Text(
                                          "Search",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Container(
                                      width: textfieldWidth,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(15),
                                        value: dropDownValue,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        underline: Container(
                                          height: 1,
                                          color: Colors.grey.shade500,
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropDownValue = value!;
                                            type = dropDownValue;
                                          });
                                        },
                                        items: typeList?.results
                                            .map<DropdownMenuItem<String>>(
                                                (Result value) {
                                          return DropdownMenuItem<String>(
                                            value: value.name,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    RawMaterialButton(
                                        fillColor: Colors.red.shade700,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(_routeFullOutput());
                                        },
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        constraints: BoxConstraints.tightFor(
                                            width: textfieldWidth,
                                            height: 50.0),
                                        child: Text(
                                          "Show All With Type: $type",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Route _routeOutput() {
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

Route _routeFullOutput() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const TypeOutput(),
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
