import 'package:cibu_app/services/notifi_service.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:intl/intl.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final textController = TextEditingController();

  final GlobalKey<FormState> validatorKey = GlobalKey<FormState>();
  final TextEditingController TopUpvalue = TextEditingController();
  var value = '';
  bool checks = false;
  int? inputNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(137, 146, 231, 1),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              await Future.delayed(const Duration(milliseconds: 100));
              Navigator.pop(
                context,
                inputNumber,
              );
            },
            alignment: const Alignment(2.0, -0.5),
          ),
          toolbarHeight: 110,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 240, 0),
            color: const Color.fromRGBO(137, 146, 231, 1),
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Colors.white,
                        Color.fromRGBO(27, 237, 244, 1),
                      ],
                      begin: Alignment.bottomLeft,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    'CIBU',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        height: 4),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: validatorKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(0, 0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            GradientText(
                              'Masukkan jumlah uang :',
                              style: const TextStyle(fontSize: 25, height: 2),
                              gradientType: GradientType.linear,
                              gradientDirection: GradientDirection.btt,
                              radius: .4,
                              colors: const [
                                Colors.white,
                                Color.fromRGBO(27, 237, 244, 1)
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 70, 20),
                              child: TextFormField(
                                controller: TopUpvalue,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.yellow
                                ),
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },

                                /*  onChanged: (value) {
                                  setState(() {
                                    inputNumber = double.tryParse(value) ?? 0;
                                  });
                                }, */

                                decoration: InputDecoration(
                                  icon: const Icon(Icons.format_list_numbered,
                                      color: Colors.white, size: 35),
                                  // prefixIcon: Icon(Icons.phone_iphone, color: Colors.white),

                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 3.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 3.0,
                                    ),
                                  ),

                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),

                                  filled: true,
                                  // suffix: const Icon(Icons.keyboard, color: Colors.black, size: 25),
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Icon(Icons.keyboard,
                                        color: Colors.black, size: 25),
                                  ),

                                  hintStyle: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      height: 2),
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintText: 'Masukkan Angka',
                                  fillColor: Colors.white,
                                  errorStyle: const TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                validator: (value) {
                                  if (value != null &&
                                      value.contains(
                                          RegExp(r'^[1-9][0-9]{1,20}$'))) {
                                    return null;
                                  }
                                  return "Input harus terdiri dari angka, tidak boleh berawal dengan 0, dan harus kurang dari 20 digit.";
                                },
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          child: const Text('Top Up (IDR)'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            backgroundColor:
                                const Color.fromRGBO(0, 162, 255, 1),
                          ),
                          onPressed: () async {
                            if (validatorKey.currentState != null) {
                              if (validatorKey.currentState!.validate()) {
                                /*   Navigator.pushNamed(
                  context,
                  '/result',
                  arguments: inputNumber,
                );*/

                                final inputNumber =
                                    int.tryParse(TopUpvalue.text) ?? 0;
                                // Navigator.pop(context, inputNumber);

                                final format = NumberFormat("#,###", "en_US");
                                final formatmoney = format
                                    .format(int.parse(inputNumber.toString()))
                                    .replaceAll(',', '.');
                                Navigator.pop(context, {
                                  'inputNumber': inputNumber,
                                  'formatmoney': formatmoney
                                });

                                NotificationService().showNotification(
                                    title: 'Cibu App',
                                    body:
                                        'Uang berhasil masuk ke saldo anda sebesar Rp.$formatmoney!');
                              } else {
                                setState(() {
                                  checks = false;
                                });
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text('Top Up (USD)'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            backgroundColor:
                                const Color.fromRGBO(0, 162, 255, 1),
                          ),
                          onPressed: () {
                            if (validatorKey.currentState != null) {
                              if (validatorKey.currentState!.validate()) {
                                /*   Navigator.pushNamed(
                                  context,
                                  '/result',
                                  arguments: inputNumber,
                                );*/

                                final int inputUSD =
                                    int.tryParse(TopUpvalue.text) ?? 0;
                                final int inputNumber = inputUSD * 15000;
                                // Navigator.pop(context, inputNumber);

                                final formatss = NumberFormat("#,###", "en_US");
                                final formatmoneys = formatss
                                    .format(int.parse(inputNumber.toString()))
                                    .replaceAll(',', '.');
                                Navigator.pop(context, {
                                  'inputNumber': inputNumber,
                                  'formatmoney': formatmoneys
                                });

                                NotificationService().showNotification(
                                    title: 'Cibu App',
                                    body:
                                        'Uang berhasil masuk ke saldo anda sebesar Rp.$formatmoneys!');
                              } else {
                                setState(() {
                                  checks = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
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
