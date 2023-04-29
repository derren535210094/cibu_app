import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cibu_app/provider/auth_provider.dart';
import 'package:cibu_app/screens/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

  class _FirstPageState extends State<FirstPage> {
    
  @override
  Widget build(BuildContext context){

    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(

      backgroundColor: const Color.fromRGBO(137,146,231,1),

      appBar: AppBar(
        
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
               onPressed: () {
               //  Navigator.pop(context);
               ap.userSignOut().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstScreen(),
                    ),
                  ),
                );
               },
               alignment: const Alignment(2.0, -0.5),
               
            ),

           // centerTitle: true,
            actions: [IconButton(
            icon: const Icon(Icons.settings),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,

            onPressed: () {
              null;
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
          padding: EdgeInsets.fromLTRB(20, 0, 240, 0),
          color:  Color.fromRGBO(137,146,231,1),
          child: Column(
            children: [
           GradientText('CIBU',
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
                   
                  ),

            ],
      ),
        ),
    ),

    body: Center(
        child: Container( 
          
           height: 750,
           width: 750,
                  
          child: Container(

             padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
          // color:  Colors.yellow,

                child: Column(
                  children: [
                  GradientText('Selamat datang,',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),

                  GradientText(ap.userModel.name, // 'Selamat datang,\n\$namauser'
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),

                  Container( // bs jg padding
                    padding: EdgeInsets.only(top: 20),
                 child: Row(
       children: [
        Expanded(
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
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
        ),

        Expanded(
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
              alignment: Alignment(3.5, 0.0),
            child:  IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
            icon: Icon(
          Icons.compare_arrows_sharp,
          color: Colors.white,
          size: 50,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("null 2")));
                    
            },
          ),
            ),
           
                ),

        ],
        ),
        ),

        Expanded(
        child: Column(
          children: [
                ShaderMask(
  shaderCallback: (bounds) => LinearGradient(
      colors: [Colors.white, Color.fromRGBO(27,237,244,1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Align(
              alignment: Alignment(5.7, 0.0),
            child:  IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
            icon: Icon(
          Icons.compare_arrows_sharp,
          color: Colors.white,
          size: 50,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("null 2")));
                    
            },
          ),
            ),
           
                ),

        ],
        ),
        ),

       ],
),
),

                 Container(

                  margin: EdgeInsets.fromLTRB(0, 5, 50, 0),
        
            child: Row(
            children: [
            Expanded(
              child: Column(
                children: [
                  ShaderMask(
  shaderCallback: (bounds) {
    return LinearGradient(
      colors: [Colors.white, Color.fromRGBO(27,237,244,1)],
      begin: Alignment.topRight, //topcenter
      end: Alignment.bottomLeft,  //bottomcenter
    ).createShader(bounds);
  },
                  
                  child: Align(
                   alignment: Alignment(1.5, 0.0),
            child: Text('Home',
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  
                ),
                  ),
                  ),
            ],
                ),
            ),

             Expanded(
              child: Column(
                children: [
                  ShaderMask(
  shaderCallback: (bounds) {
    return const LinearGradient(
      colors: [Colors.white, Color.fromRGBO(27,237,244,1)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).createShader(bounds);
  },
                  
                  child: Align(
                   alignment: Alignment(45, 0.0),
            child: Text('Transfer',
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  
                ),
                  ),
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
        ),
    ),

    );
  }  
} 