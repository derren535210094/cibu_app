import 'package:cibu_app/model/user_model.dart';
import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  var value = '';
  final GlobalKey<FormState> validatorKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmpassword = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(137, 146, 231, 1),
        body: SafeArea(
          // Tadinya center
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 5.0),
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orangeAccent,
                    ),
                  )
                : Form(
                    key: validatorKey,
                    //height: 750,

                    child: Column(
                      children: [
                        GradientText(
                          'Biodata',
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
                            GradientText(
                              'Masukkan Nama :',
                              style: const TextStyle(fontSize: 25, height: 3),
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
                                controller: nameController, // Untuk nama
                                keyboardType: TextInputType.name,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.people,
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
                                  hintText: 'Masukkan nama',
                                  fillColor: Colors.white,
                                  errorStyle: const TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Masukkan nama";
                                  } else if ((value.length < 3)) {
                                    return "Nama terlalu singkat";
                                  } else if ((value
                                          .contains(RegExp(r'[1-9]')) ==
                                      true)) {
                                    return "Nama tidak boleh menggunakan angka";
                                  } else if ((value
                                          .contains(RegExp(r'[^\w\s]')) ==
                                      true)) {
                                    return "Nama wajib huruf";
                                  } else if ((value.contains(RegExp(r'\s')) ==
                                      true)) {
                                    return "Nama tidak boleh ada spasi";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GradientText(
                              'Masukkan Email :',
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
                                controller: emailController, // untuk email
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.email,
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
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Icon(Icons.keyboard,
                                        color: Colors.black, size: 25),
                                  ),

                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintStyle: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      height: 2),
                                  hintText: 'Masukkan Email',
                                  fillColor: Colors.white,
                                  errorStyle: const TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Masukkan Email";
                                  } else if ((value.length < 5)) {
                                    return "Email terlalu singkat";
                                  } else if ((value.contains(RegExp(r'\s')) ==
                                      true)) {
                                    return "Email tidak boleh ada spasi";
                                  } else if ((value.contains(RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')) ==
                                      false)) {
                                    return "Email tidak valid";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
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
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
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
                                  } else if ((value.length < 8) ||
                                      (value.contains(RegExp(r'[A-Z]')) ==
                                          false) ||
                                      (value.contains(
                                              RegExp(r'[1-9].*[1-9].*[1-9]')) ==
                                          false)) {
                                    return "Password belum memenuhi kriteria";
                                  }

                                  return null;
                                },
                              ),
                            ),
                            FlutterPwValidator(
                              controller: passwordController,
                              minLength: 8,
                              uppercaseCharCount: 1,
                              numericCharCount: 3,
                              width: 300,
                              height: 100,
                              successColor: Colors.lightGreenAccent,
                              defaultColor: Colors.yellow,
                              onSuccess: () {
                                print("MATCHED");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            "Password sudah memenuhi kriteria")));
                              },
                              onFail: () {},
                            )
                          ],
                        ),
                        Column(
                          children: [
                            GradientText(
                              'Konfirmasi Password :',
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
                              margin: const EdgeInsets.fromLTRB(40, 10, 50, 20),
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.yellow
                                ),
                                controller: confirmpassword,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  // icon: const Icon(Icons.password_sharp, color: Colors.white, size: 35),
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
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Icon(Icons.keyboard,
                                        color: Colors.black, size: 25),
                                  ),

                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  hintStyle: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      height: 2),
                                  hintText: 'Masukkan Password',
                                  fillColor: Colors.white,
                                  errorStyle: const TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Masukkan konfirmasi password";
                                  } else if (passwordController.text !=
                                      confirmpassword.text) {
                                    return "Masukkan konfirmasi password dengan benar";
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
                            backgroundColor:
                                const Color.fromRGBO(0, 162, 255, 1),
                          ),
                          onPressed: () => {
                            if (validatorKey.currentState != null)
                              {
                                if (validatorKey.currentState!.validate())
                                  {
                                    storeData(),
                                  }
                                else if ((value == null || value.isEmpty) ||
                                    (passwordController.text !=
                                        confirmpassword.text))
                                  {
                                    print("UnSuccessfull"),
                                  }
                                else
                                  {
                                    print("UnSuccessfull"),
                                  }
                              }
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      createdAt: "",
      phoneNumber: "",
      uid: "",
      money: "0",
      password: passwordController.text.trim(),
      createdAtMonth: "",
      createdAtYear: "",
    );

    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      onSuccess: () {
        ap.saveUserDataToSP().then(
              (value) => ap.setSignIn().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstPage(),
                        ),
                        (route) => false),
                  ),
            );
      },
    );
  }
}
