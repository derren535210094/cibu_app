import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/FirstScreen.dart';
import 'package:cibu_app/screens/HomeScreen.dart';
import 'package:cibu_app/screens/ForgotPwChange.dart';
import 'package:cibu_app/screens/ForgotPwNotif.dart';
import 'package:cibu_app/services/notifi_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var value = '';
  String inputpassword = '';
  int counter = 0;
  final GlobalKey<FormState> validatorKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

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
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const FirstScreen(),
                ),
              );
            },
            alignment: const Alignment(2.0, -0.45),
          ),
          toolbarHeight: 110,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 3.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0),
            child: Form(
              key: validatorKey,
              //height: 750,

              child: Column(
                children: [
                  GradientText(
                    'Login',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ttb,
                    radius: .4,
                    colors: const [
                      Colors.white,
                      Color.fromRGBO(27, 237, 244, 1)
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          GradientText(
                            'Password :',
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                // color: Colors.yellow
                              ),
                              controller: passwordController, // Untuk pw
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.password_sharp,
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
                                contentPadding: const EdgeInsets.only(left: 20),
                                hintText: 'Masukkan Password',
                                fillColor: Colors.white,
                                errorStyle: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukkan password";
                                } else if (value != ap.userModel.password) {
                                  return "Password yang anda masukkan salah";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        child: const Text('Continue'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          backgroundColor: const Color.fromRGBO(0, 162, 255, 1),
                        ),
                        onPressed: () async {
                          counter++;
                          if (validatorKey.currentState != null) {
                            if (validatorKey.currentState!.validate()) {
                              final String inputpassword =
                                  passwordController.text;
                              //  bool correctpw = await UserDatabase.checkExistingUserByPassword(inputpassword);

                              if (inputpassword == ap.userModel.password) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FirstPage(),
                                    ),
                                    (route) => false);
                              }
                            } else if ((value == null || value.isEmpty)) {
                              if (counter >= 3) {
                                NotificationService().showNotification(
                                    title: 'Cibu App',
                                    body:
                                        'Password yang anda masukkan sudah salah ${counter}x.\nKlik "Kirim Password" atau "Ubah Password".');
                              }
                              print("UnSuccessfull");
                            } else {
                              print("UnSuccessfull");
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        "Lupa password?",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        child: const Text('Kirim Password'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color.fromRGBO(0, 162, 255, 1),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPwNotif(),
                            ),
                          ),
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        child: const Text('Ubah Password'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color.fromRGBO(0, 162, 255, 1),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPwChange(),
                            ),
                          ),
                        },
                      ),
                    ],
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

/*class UserDatabase {
  static Future<bool> checkExistingUserByPassword(String password) async {
    QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance.collection('users').where('password', isEqualTo: password).get();
    return result.docs.isNotEmpty;
  }
}*/
