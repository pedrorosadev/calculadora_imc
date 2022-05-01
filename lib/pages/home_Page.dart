import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController mass = TextEditingController();

  final TextEditingController height = TextEditingController();

  TextEditingController user = TextEditingController();

  String infoText = 'Informe seus dados !';

  void calculate() {
    double massNumber = double.parse(mass.text);
    double heightNumber = double.parse(height.text) / 100;
    double imc = massNumber / (heightNumber * heightNumber);

    setState(() {
      if (imc < 18.5) {
        infoText = 'Abaixo do peso: ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 18.5 && imc <= 24.9) {
        infoText = 'Peso Normal: ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 25 && imc <= 29.9) {
        infoText = 'Sobrepeso: ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 30 && imc <= 34.9) {
        infoText = 'Obesidade Grau I: ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 35 && imc <= 39.9) {
        infoText = 'Obesidade Grau II: ${imc.toStringAsPrecision(4)}';
      } else {
        infoText =
            'Obesidade Grau III ou Mórbida: ${imc.toStringAsPrecision(4)}';
      }
    });
  }

  //Controle para o TextField Usuário
  List<String> dataIMC = [];

  //Os dados do usuário irão ser armazenados nesta lista.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora IMC',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (builder) => AlertDialog(
                  title: const Text('Alerta !'),
                  content: const Text(
                      'Ao resetar essas informações,não será possível resgata-las posteriormente, deseja mesmo resetar tudo?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          dataIMC.clear();
                          user.clear();
                          height.clear();
                          mass.clear();
                          Navigator.of(context).pop();
                          infoText = 'Informe seus dados !';
                        });
                      },
                      child: Text('Resetar'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: user,
                    decoration: const InputDecoration(
                      label: Text(
                        'Nome Completo',
                        style: TextStyle(color: Colors.green),
                      ),
                      hintText: 'Digite seu nome completo aqui',
                      border: OutlineInputBorder(),
                      hoverColor: Colors.green,
                      focusColor: Colors.green,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira seu nome completo !!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: mass,
                    decoration: const InputDecoration(
                      label: Text(
                        'Massa',
                        style: TextStyle(color: Colors.green),
                      ),
                      hintText: 'Digite sua massa corpórea em kg',
                      suffixText: 'kg',
                      border: OutlineInputBorder(),
                      hoverColor: Colors.green,
                      focusColor: Colors.green,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira sua massa corporal !';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: height,
                    decoration: const InputDecoration(
                      label: Text(
                        'Altura',
                        style: TextStyle(color: Colors.green),
                      ),
                      hintText: 'Digite sua altura em cm',
                      suffixText: 'cm',
                      border: OutlineInputBorder(),
                      hoverColor: Colors.green,
                      focusColor: Colors.green,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira sua altura !';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calculate();
                        }
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '$infoText',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (builder) => AlertDialog(
                            title: const Text('Alerta !'),
                            content: const Text(
                                'Ao apagar essas informações,não será possível resgata-las posteriormente, deseja mesmo apagar tudo?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    dataIMC.clear();
                                    mass.clear();
                                    height.clear();
                                    user.clear();
                                    infoText = 'Informe seus dados !';
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('Apagar tudo'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        'Limpar Tudo',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
