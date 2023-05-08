import 'package:cibu_app/model/user_model.dart';
import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/kalkulator.dart';
import 'package:cibu_app/screens/settings.dart';
import 'package:cibu_app/screens/topup.dart';
import 'package:cibu_app/services/notifi_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late AuthProvider ap;

  int _totalNumber = 0;
  int decreaseNumber = 0;
  var value = '';
  bool checks = false;
  String timetransaksi = "";

  int pencet = 0;

  Country selectedCountry = Country(
    phoneCode: "62",
    countryCode: "ID",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Indonesia",
    example: "Indonesia",
    displayName: "Indonesia",
    displayNameNoCountryCode: "ID",
    e164Key: "",
  );

  int validasiphone = 0;

  final GlobalKey<FormState> validatorKey = GlobalKey<FormState>();
  final TextEditingController transfervalue = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    transfervalue.dispose();
  }

  bool showhome = false;
  bool showtransfer = false;
  bool showhistory = false;
  bool _isTapped1 = false;
  bool _ishighlight1 = false;
  bool _isTapped2 = false;
  bool _ishighlight2 = false;
  bool _isTapped3 = false;
  bool _ishighlight3 = false;
  String phonenumber = "+6281314931980";

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> saveValue(int valuess) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('myValue', valuess);
  }

/*  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    final valuess = prefs.getInt('myValue');
  if (valuess != null) {
    setState(() {
      _totalNumber = valuess;
    });
  }
}*/

  Future<void> _loadValue() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final formatter = NumberFormat("#,###", "en_US");
    final formattedMoney =
        formatter.format(int.parse(ap.userModel.money)).replaceAll(',', '');
    setState(() {
      _totalNumber = prefs.getInt('myValue') ?? int.parse(formattedMoney);
      //  _totalNumber = prefs.getInt('myValue') ?? int.tryParse(ap.userModel.money) ?? 0;
    });
  }

  List<Map<String, dynamic>> transactionDataList = [];

  void _onButtonTap() {
    setState(() {
      final DateTime now = DateTime.now();
      final String formattedTime =
          DateFormat('kk:mm:ss').format(now); // 24-hour format
      final int decreaseNumber = int.tryParse(transfervalue.text) ?? 0;
      final formatters = NumberFormat("#,###", "en_US");
      final formattedMoneys = formatters
          .format(int.parse(decreaseNumber.toString()))
          .replaceAll(',', '.');
      final transactionData = {
        'time': formattedTime,
        'amount': formattedMoneys,
        'phone': "+${selectedCountry.phoneCode}${phoneController.text}",
        'transfer': "Transfer",
      };
      transactionDataList = List.from(transactionDataList); // Buat copy data
      transactionDataList.add(transactionData);
    });
  }

  int tapCount = 0;
  List<Widget> buildTransactionWidgets() {
    return transactionDataList.map((transactionData) {
      return Container(
        alignment: const Alignment(-0.3, 0),
        padding: const EdgeInsets.only(top: 10),
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                Colors.white,
                Color.fromRGBO(27, 237, 244, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            "Pada pukul ${transactionData['time']} berhasil melakukan\n${transactionData['transfer']} ke nomor ${transactionData['phone']}\nsebesar = Rp.${transactionData['amount']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    final formatter = NumberFormat("#,###", "en_US");
    final formattedMoney =
        formatter.format(int.parse(ap.userModel.money)).replaceAll(',', '.');

    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(137, 146, 231, 1),
        appBar: AppBar(
          // centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const settings(),
                  ),
                );
              },
              alignment: const Alignment(-10.0, -0.5),
              iconSize: 30,
            ),

            /* IconButton(                // Dapat dipakai kembali
            icon: const Icon(Icons.phone),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,

            onPressed: () {
              null;
            },
              alignment: const Alignment(-10.0, -0.5),
              iconSize: 30,
            ), */
          ],

          toolbarHeight: 110,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 300, 0),
            color: const Color.fromRGBO(137, 146, 231, 1),
            child: Column(
              children: [
                /* GradientText('CIBU',
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    height: 4
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ), */

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
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 3.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 750,
            width: 750,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // color:  Colors.yellow,

              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(-0.7, 0),
                    child: GradientText(
                      'Selamat datang,',
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      radius: .4,
                      colors: const [
                        Colors.white,
                        Color.fromRGBO(27, 237, 244, 1)
                      ],
                    ),
                  ),

                  Align(
                    alignment: const Alignment(-0.8, 0),
                    child: GradientText(
                      ap.userModel.name, // 'Selamat datang,\n\$namauser'
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      radius: .4,
                      colors: const [
                        Colors.white,
                        Color.fromRGBO(27, 237, 244, 1)
                      ],
                    ),
                  ),

                  Container(
                    // bs jg padding
                    padding: const EdgeInsets.only(top: 30, right: 0),
                    child: Row(
                      children: [
                        /*  Expanded(
        child: Column(
          children: [
                ShaderMask(
  shaderCallback: (bounds) {
    return LinearGradient(
      colors: [Colors.white, Color.fromRGBO(27,237,244,1)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(bounds);
  },

            child: Align(
              alignment: Alignment(1.3, 0.0),
            child:  IconButton(
            //  splashColor: Colors.transparent,
             // highlightColor: Colors.transparent,
              
            icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 50,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("null 1")));
                    
            },
          ),
            ),
           
                ),

        ],
        ),
        ), */

                        Container(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              animationDuration:
                                  const Duration(milliseconds: 0),
                              backgroundColor: !showhome &&
                                      !showhistory &&
                                      !showtransfer
                                  ? const Color.fromRGBO(152, 156, 236, 1)
                                  : showhome && !showhistory && !showtransfer
                                      ? const Color.fromRGBO(152, 156, 236, 1)
                                      : const Color.fromRGBO(137, 146, 231, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              foregroundColor:
                                  const Color.fromRGBO(137, 146, 231, 1),
                              elevation: 0,
                            ).merge(
                              ButtonStyle(
                                side: !showhome && !showhistory && !showtransfer
                                    ? MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Colors.white, width: 2))
                                    : showhome && !showhistory && !showtransfer
                                        ? MaterialStateProperty.all(
                                            const BorderSide(
                                                color: Colors.white, width: 2))
                                        : null,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                // showhome = !showhome;
                                _isTapped1 = true;
                                _ishighlight1 = true;
                                _isTapped2 = false;
                                _ishighlight2 = false;
                                _isTapped3 = false;
                                _ishighlight3 = false;
                                showhome = true;
                                showtransfer = false;
                                showhistory = false;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color.fromRGBO(27, 237, 244, 1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color.fromRGBO(27, 237, 244, 1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      'Home',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              animationDuration:
                                  const Duration(milliseconds: 0),
                              backgroundColor: _isTapped2
                                  ? const Color.fromRGBO(152, 156, 236, 1)
                                  : const Color.fromRGBO(137, 146, 231, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              foregroundColor:
                                  const Color.fromRGBO(137, 146, 231, 1),
                              elevation: 0,
                            ).merge(
                              ButtonStyle(
                                side: _ishighlight2
                                    ? MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Colors.white, width: 2))
                                    : null,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                //  showtransfer = !showtransfer;
                                _ishighlight1 = false;
                                _isTapped1 = false;
                                _ishighlight2 = true;
                                _isTapped2 = true;
                                _isTapped3 = false;
                                _ishighlight3 = false;
                                showhome = false;
                                showtransfer = true;
                                showhistory = false;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color.fromRGBO(27, 237, 244, 1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(
                                    Icons.compare_arrows_sharp,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color.fromRGBO(27, 237, 244, 1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      'Transfer',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              animationDuration:
                                  const Duration(milliseconds: 0),
                              backgroundColor: _isTapped3
                                  ? const Color.fromRGBO(152, 156, 236, 1)
                                  : const Color.fromRGBO(137, 146, 231, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              foregroundColor:
                                  const Color.fromRGBO(137, 146, 231, 1),
                              elevation: 0,
                            ).merge(
                              ButtonStyle(
                                side: _ishighlight3
                                    ? MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Colors.white, width: 2))
                                    : null,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                //  showtransfer = !showtransfer;
                                _ishighlight1 = false;
                                _isTapped1 = false;
                                _ishighlight2 = false;
                                _isTapped2 = false;
                                _ishighlight3 = true;
                                _isTapped3 = true;
                                showhome = false;
                                showtransfer = false;
                                showhistory = true;
                                pencet++;
                                if (pencet >= 1 && pencet <= 3) {
                                  NotificationService().showNotification(
                                      title: 'Cibu App',
                                      body:
                                          'Perhatian: Jika aplikasi ter-refresh maka histori transaksi akan hilang karena bersifat sementara!');
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color.fromRGBO(27, 237, 244, 1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds);
                                  },
                                  child: const Icon(
                                    Icons.insert_chart_outlined_outlined,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color.fromRGBO(27, 237, 244, 1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      'History',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),
                  const Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 15),

                  if ((showhome == true || showhome == false) &&
                      !showhistory &&
                      !showtransfer)
                    Column(
                      children: [
                        Container(
                          alignment: const Alignment(-0.75, 0),
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color.fromRGBO(27, 237, 244, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: const Text(
                              'Saldo Cibu',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: const Alignment(-0.7, 0),
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color.fromRGBO(27, 237, 244, 1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Rp ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formattedMoney, // $_totalNumber
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // bs jg padding
                          padding: const EdgeInsets.only(top: 30, right: 0),
                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 30),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    animationDuration:
                                        const Duration(milliseconds: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    backgroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    foregroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    elevation: 0,
                                  ),

                                  /* onPressed: () {
                     Navigator.pushNamed(
                  context, '/Topup'
                  ); */
                                  onPressed: () async {
                                    final Map<String, dynamic>? result =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const topup(),
                                      ),
                                    );
                                    if (result != null) {
                                      final int inputNumber =
                                          result['inputNumber'];
                                      final String formatmoney =
                                          result['formatmoney'];
                                      setState(() {
                                        _totalNumber += inputNumber;
                                        saveValue(_totalNumber);
                                        storeData();
                                        transactionDataList.add({
                                          'time': DateFormat('kk:mm:ss').format(
                                              DateTime.now()), // 24-hour format
                                          'amount': formatmoney,
                                          'phone': "anda sendiri",
                                          'topup': inputNumber,
                                          'transfer': "Top Up",
                                        });
                                      });
                                      tapCount++;
                                    }
                                  },

                                  /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const topup(),
                    ),
                  );  */
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Color.fromRGBO(27, 237, 244, 1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ).createShader(bounds);
                                        },
                                        child: const Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: ShaderMask(
                                          shaderCallback: (bounds) {
                                            return const LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Color.fromRGBO(27, 237, 244, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds);
                                          },
                                          child: const Text(
                                            'Top Up',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    backgroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    foregroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const kalkulator(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Color.fromRGBO(27, 237, 244, 1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ).createShader(bounds);
                                        },
                                        child: const Icon(
                                          Icons.calculate,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: ShaderMask(
                                          shaderCallback: (bounds) {
                                            return const LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Color.fromRGBO(27, 237, 244, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds);
                                          },
                                          child: const Text(
                                            'Split bill\nkalkulator',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 10),
                                    backgroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    foregroundColor:
                                        const Color.fromRGBO(137, 146, 231, 1),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        phonenumber);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Color.fromRGBO(27, 237, 244, 1),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ).createShader(bounds);
                                        },
                                        child: const Icon(
                                          Icons.phone_rounded,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: ShaderMask(
                                          shaderCallback: (bounds) {
                                            return const LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Color.fromRGBO(27, 237, 244, 1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds);
                                          },
                                          child: const Text(
                                            'Customer\nSupport',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  if (showtransfer)
                    Form(
                      key: validatorKey,
                      child: Column(
                        children: [
                          GradientText(
                            'Masukkan no. telp :',
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
                            margin: const EdgeInsets.fromLTRB(20, 10, 70, 0),
                            child: TextFormField(
                              cursorColor: Colors.blue,
                              controller: phoneController,
                              keyboardAppearance: Brightness.dark,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                icon: const Icon(Icons.phone_iphone,
                                    color: Colors.white, size: 35),

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
                                hintStyle: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                hintText: 'Masukkan No. Telepon',
                                // labelText: 'Nothing',
                                fillColor: Colors.white,
                                errorStyle: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),

                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                          context: context,
                                          countryListTheme:
                                              const CountryListThemeData(
                                            bottomSheetHeight: 550,
                                          ),
                                          onSelect: (value) {
                                            setState(() {
                                              selectedCountry = value;
                                            });
                                          });
                                    },
                                    child: Text(
                                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                suffixIcon: phoneController.text.length > 9 &&
                                        phoneController.text.length < 14
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "\t\t\t\t\t\tMasukkan No. Telepon";
                                } else if ((value.length < 10) ||
                                    (value.length > 13) ||
                                    (value.contains(RegExp(r'[A-Z]')) ==
                                        true) ||
                                    (value.contains(RegExp(r'[a-z]')) ==
                                        true)) {
                                  return "Masukkan No. Telepon dengan benar";
                                }

                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                            style: const TextStyle(
                                                fontSize: 25, height: 2),
                                            gradientType: GradientType.linear,
                                            gradientDirection:
                                                GradientDirection.btt,
                                            radius: .4,
                                            colors: const [
                                              Colors.white,
                                              Color.fromRGBO(27, 237, 244, 1)
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 10, 70, 20),
                                            child: TextFormField(
                                              controller: transfervalue,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.yellow
                                              ),
                                              enableSuggestions: false,
                                              autocorrect: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              onTap: () {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);

                                                if (!currentFocus
                                                    .hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                              },

                                              /*  onChanged: (value) {
                  setState(() {
                    inputNumber = double.tryParse(value) ?? 0;
                  });
                }, */

                                              decoration: InputDecoration(
                                                icon: const Icon(
                                                    Icons.format_list_numbered,
                                                    color: Colors.white,
                                                    size: 35),
                                                // prefixIcon: Icon(Icons.phone_iphone, color: Colors.white),

                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3.0),
                                                ),

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0,
                                                  ),
                                                ),

                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),

                                                filled: true,
                                                // suffix: const Icon(Icons.keyboard, color: Colors.black, size: 25),
                                                suffixIcon: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Icon(Icons.keyboard,
                                                      color: Colors.black,
                                                      size: 25),
                                                ),

                                                hintStyle: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    height: 2),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                hintText: 'Masukkan Angka',
                                                fillColor: Colors.white,
                                                errorStyle: const TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Masukkan angka terlebih dahulu";
                                                } else if (value.length > 20) {
                                                  return "Angka yang di-input terlalu besar";
                                                } else if (value
                                                        .startsWith("0") &&
                                                    !(value.contains(
                                                        RegExp(r'^0*[1-9]')))) {
                                                  return "Angka tidak boleh 0";
                                                } else if (value
                                                        .startsWith("0") &&
                                                    (value.contains(
                                                        RegExp(r'^0*[1-9]')))) {
                                                  return "Tidak boleh ada 0 paling depan";
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        child: const Text('Transfer'),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 10, 50, 10),
                                          backgroundColor: const Color.fromRGBO(
                                              0, 162, 255, 1),
                                        ),
                                        onPressed: () async {
                                          if (validatorKey.currentState !=
                                              null) {
                                            if (validatorKey.currentState!
                                                .validate()) {
                                              final int validasiphone =
                                                  int.tryParse(phoneController
                                                          .text) ??
                                                      0;
                                              bool isExistingUser =
                                                  await UserDatabase
                                                      .checkExistingUserByPhone(
                                                          "+${selectedCountry.phoneCode}$validasiphone");
                                              /* if (isExistingUser) {
  print("ada");
  print("+${selectedCountry.phoneCode}$validasiphone");
} else {
  print("tidak ada");
  print("$validasiphone");
} */

                                              final int decreaseNumber =
                                                  int.tryParse(
                                                          transfervalue.text) ??
                                                      0;

                                              if ((decreaseNumber >
                                                      _totalNumber) &&
                                                  isExistingUser &&
                                                  (ap.userModel.phoneNumber !=
                                                      '+${selectedCountry.phoneCode}$validasiphone')) {
                                                setState(() {
                                                  _totalNumber -= 0;
                                                  saveValue(_totalNumber);
                                                  storeData();
                                                });
                                                NotificationService()
                                                    .showNotification(
                                                        title: 'Cibu App',
                                                        body:
                                                            'Saldo tidak mencukupi untuk transfer karena tersisa Rp.$formattedMoney!'); //$_totalNumber
                                              } else if (!isExistingUser &&
                                                  (ap.userModel.phoneNumber !=
                                                      '+${selectedCountry.phoneCode}$validasiphone')) {
                                                NotificationService()
                                                    .showNotification(
                                                        title: 'Cibu App',
                                                        body:
                                                            'Nomor +${selectedCountry.phoneCode}$validasiphone tidak terdaftar menggunakan App Cibu.');
                                              } else if ((decreaseNumber <=
                                                      _totalNumber) &&
                                                  isExistingUser &&
                                                  (ap.userModel.phoneNumber !=
                                                      '+${selectedCountry.phoneCode}$validasiphone')) {
                                                final QuerySnapshot<
                                                        Map<String, dynamic>>
                                                    result =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .where('phoneNumber',
                                                            isEqualTo:
                                                                "+${selectedCountry.phoneCode}$validasiphone")
                                                        .get();

                                                final UserModel receiver =
                                                    UserModel.fromMap(
                                                        result.docs.first.data()
                                                            as Map<String,
                                                                dynamic>);
                                                final int
                                                    receiverCurrentBalance =
                                                    int.tryParse(
                                                            receiver.money) ??
                                                        0;
                                                receiver.money =
                                                    (receiverCurrentBalance +
                                                            decreaseNumber)
                                                        .toString();

                                                setState(() {
                                                  _totalNumber -=
                                                      decreaseNumber.toInt();
                                                  saveValue(_totalNumber);
                                                  storeData();
                                                });

                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(result.docs.first.id)
                                                    .update(receiver.toMap());

                                                final formatters = NumberFormat(
                                                    "#,###", "en_US");
                                                final formattedMoneys =
                                                    formatters
                                                        .format(int.parse(
                                                            decreaseNumber
                                                                .toString()))
                                                        .replaceAll(',', '.');
                                                final formatternum =
                                                    NumberFormat(
                                                        "#,###", "en_US");
                                                final formattednums =
                                                    formatternum
                                                        .format(int.parse(
                                                            _totalNumber
                                                                .toString()))
                                                        .replaceAll(',', '.');

                                                NotificationService()
                                                    .showNotification(
                                                        title: 'Cibu App',
                                                        body:
                                                            'Uang berhasil ditransfer ke +${selectedCountry.phoneCode}$validasiphone sebesar Rp.$formattedMoneys!. Sisa saldo anda: Rp.$formattednums.');

                                                _onButtonTap();
                                                tapCount++;
                                              } else if ('+${selectedCountry.phoneCode}$validasiphone' ==
                                                  ap.userModel.phoneNumber) {
                                                NotificationService()
                                                    .showNotification(
                                                        title: 'Cibu App',
                                                        body:
                                                            'Tidak boleh memasukkan nomor anda sendiri "+${selectedCountry.phoneCode}$validasiphone".');
                                              }
                                            } else if ((value == null ||
                                                    value.isEmpty) ||
                                                ((transfervalue.text == null) ||
                                                    (transfervalue.text ==
                                                        null))) {
                                              setState(() {
                                                checks = false;
                                              });
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
                        ],
                      ),
                    ),

                  if (showhistory && tapCount > 0)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: buildTransactionWidgets(),
                        ),
                      ),
                    ),

                  if (showhistory && tapCount == 0)
                    Container(
                      alignment: const Alignment(-0.3, 0),
                      padding: const EdgeInsets.only(top: 130),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Colors.white,
                              Color.fromRGBO(27, 237, 244, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "Tidak Ada Transaksi Saat Ini",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
/*Container(
                      alignment: const Alignment(-0.3,0),
                      padding: const EdgeInsets.only(top: 30),
                child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromRGBO(27,237,244,1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              "Pada pukul $timetransaksi telah melakukan\ntransfer sebesar = Rp.${transfervalue.text}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
                    ), */
                  // - ${transfervalue.text}
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: ap.userModel.name,
      email: ap.userModel.email,
      createdAt: "",
      phoneNumber: "",
      uid: "",
      money: _totalNumber.toString(),
      password: ap.userModel.password,
      createdAtMonth: "",
      createdAtYear: "",
    );

    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      onSuccess: () {
        ap.saveUserDataToSP();
      },
    );
  }
}

class UserDatabase {
  static Future<bool> checkExistingUserByPhone(String phone) async {
    QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phone)
        .get();
    return result.docs.isNotEmpty;
  }
}
