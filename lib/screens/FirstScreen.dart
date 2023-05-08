import 'package:cibu_app/screens/PasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/SignUp.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key}); // const MyApp({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    
    final ap = Provider.of<AuthProvider>(context, listen: false);

     return MaterialApp(
          title: 'CIBU App',
          home: Scaffold(

            backgroundColor: const Color.fromRGBO(137,146,231,1),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText('CIBU',
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),

                 const SizedBox(height: 25),
                  ElevatedButton(
                  child: const Text('Sign-up / Login'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                      
                  ),
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  backgroundColor: const Color.fromRGBO(0,162,255,1),
                  ),
                  onPressed: () async {
                    if(ap.isSignedIn == true){ // Ketika true, maka mengambil shared preference data.
                    await ap.getDataFromSP().whenComplete(() =>
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context)=> const PasswordScreen(), // FirstPage
                        ),
                      ),
                    );
                    
                    } else {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                      ),
                    ); 
                    }
                  },

                  ),
                  
                ],

              ),
              ),

      ), 

    ); 

  }
}




/*

Column(
              children: [
                GradientText('Password :',
                  style: TextStyle(
                    fontSize: 25,
                    height: 2
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.btt,
                  radius: .4,
                  colors: [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),
                  Container(
            margin: EdgeInsets.fromLTRB(20,10,70,0),
            child:  TextField(
            decoration: InputDecoration(
            icon: Icon(Icons.password_sharp, color: Colors.white, size: 35),
            // prefixIcon: Icon(Icons.phone_iphone, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ), 
              filled: true,
              suffix: Icon(Icons.keyboard, color: Colors.black, size: 25),
              hintStyle: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w500, height: 2),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Masukkan Password',
              fillColor: Colors.white,
            ),
            
                  ),
           ),
              ],
             ), 

*/