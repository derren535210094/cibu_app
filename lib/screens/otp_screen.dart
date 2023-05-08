import 'package:cibu_app/screens/PasswordScreen.dart';
import 'package:cibu_app/screens/user_information_screen.dart';
import 'package:cibu_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/SignUp.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
        final ap = Provider.of<AuthProvider>(context, listen: false);
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(137,146,231,1),
      body: SafeArea(
            child: isLoading == true
            ? const Center(
              child: CircularProgressIndicator(
              color: Colors.orangeAccent,
              ),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      
                      const SizedBox(height: 120),
                      GradientText('Verification',
                  style: const TextStyle(
                    fontSize: 25,
                    height: 0,
                    fontWeight: FontWeight.bold
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.btt,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),
                      
                      const SizedBox(height: 20),
                      GradientText('Masukkan kode OTP yang telah dikirim ke nomor anda.',
                    style: const TextStyle(
                    fontSize: 20,
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.btt,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),
                  
                      const SizedBox(height: 30),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white60,
                            border: Border.all(color: Colors.black
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value){
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('Verify'),
                          style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    ),
                  backgroundColor: const Color.fromRGBO(0,162,255,1),
                  ),
                          onPressed: () {
                            if(otpCode != null){
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Masukkan 6-Digit kode");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text("Tidak menerima kode OTP?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 15),

                       ElevatedButton(
                         child: const Text('Kirim Ulang'),
                          style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    ),
                  backgroundColor: const Color.fromRGBO(0,162,255,1),
                  ),
                          onPressed: () => {
                            Navigator.pop(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const SignUp(),
                    ),
                  ),
                          },
                        ), 
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // verify OTP
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: (){
        // Cek apakah user ada pada database

        ap.checkExistingUser().then((value) async {
          if(value == true){
            // user ada pada database
            ap.getDataFromFireStore().then((value) => ap
            .saveUserDataToSP()
            .then((value) => ap
            .setSignIn()
            .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordScreen(), // FirstPage
                ),
              (route) => false),
              ),
            ),
          );
          } else {
            // user baru

            Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
              builder: (context) => const UserInfromationScreen()),
              (route) => false);
          }
        },
       );
      },
    );
  }

}