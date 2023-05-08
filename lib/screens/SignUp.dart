import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:cibu_app/screens/FirstScreen.dart';
import 'package:cibu_app/provider/auth_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key}); // const MyApp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
   
   var value = '';
   final GlobalKey<FormState> validatorKey = GlobalKey<FormState>(); //FlutterPwValidatorState
   final TextEditingController phoneController = TextEditingController();

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

 @override 
 Widget build(BuildContext context){

  final ap = Provider.of<AuthProvider>(context, listen: false);

  phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Scaffold(

      backgroundColor: const Color.fromRGBO(137,146,231,1),

      appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
               onPressed: (){
               //  Navigator.pop(context);
               ap.userSignOut().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const FirstScreen(),
                    ),
                  ),
                ); 
               },
               alignment: const Alignment(2.0, -0.5),
               
            ),

        toolbarHeight: 110,
        elevation: 0,
        flexibleSpace: Container(
          color: const Color.fromRGBO(137,146,231,1),
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

      body: 
      SingleChildScrollView( // Tadinya center
      padding: const EdgeInsets.symmetric(vertical: 150),
        child: Form( // Tadinya Container
          key: validatorKey,
          // height: 750,
                  
          child: Column(
                children: [
                  GradientText('Sign-Up',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),


         /*    Column(
          children: [
            GradientText('Masukkan no. telp :',
                  style: const TextStyle(
                    fontSize: 25,
                    height: 3
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.btt,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),
          Container(
            margin: const EdgeInsets.fromLTRB(20,10,70,0),
            child: IntlPhoneField(
             controller: phoneController,
             keyboardAppearance: Brightness.dark,
             textInputAction: TextInputAction.next,
            /* onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              }, */
            decoration: InputDecoration(
            icon: const Icon(Icons.phone_iphone, color: Colors.white, size: 35),
            // prefixIcon: Icon(Icons.phone_iphone, color: Colors.white),

              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 3.0
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),

              filled: true,
              hintStyle: const TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              hintText: 'Masukkan No. Telepon',
              fillColor: Colors.white,
              errorStyle: const TextStyle(color: Colors.yellow, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            initialCountryCode: 'ID',
            onChanged: (phone) {
            print(phone.completeNumber);
          },
          ),
           ),
          ],
             ), */

            Column(
          children: [
             GradientText('Masukkan no. telp :',
                  style: const TextStyle(
                    fontSize: 25,
                    height: 3
                  ),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.btt,
                  radius: .4,
                  colors: const [
                 Colors.white,
                 Color.fromRGBO(27,237,244,1)
                   ],
                   
                  ),

             Container(
             margin: const EdgeInsets.fromLTRB(20,10,70,0),
             child: TextFormField(
                  cursorColor: Colors.blue,
                  controller: phoneController,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: TextInputType.number,
                  onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),

                  decoration: InputDecoration(
                    icon: const Icon(Icons.phone_iphone, color: Colors.white, size: 35),

                    errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 3.0
                  ),
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
                hintStyle: const TextStyle(color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintText: 'Masukkan No. Telepon',
               // labelText: 'Nothing',
                fillColor: Colors.white,
                errorStyle: const TextStyle(color: Colors.yellow, fontSize: 13, fontWeight: FontWeight.bold),

                    prefixIcon: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
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
                    suffixIcon: phoneController.text.length > 9 && phoneController.text.length < 14
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
                            height:30,
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

                  validator: (value){

                     if(value == null || value.isEmpty)
                      {
                        return "\t\t\t\t\t\tMasukkan No. Telepon";
                      }
                      else if((value.length<10) || (value.length>13) || (value.contains(RegExp(r'[A-Z]'))==true) || (value.contains(RegExp(r'[a-z]'))==true)){
                        return "Masukkan No. Telepon dengan benar";
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
                  backgroundColor: const Color.fromRGBO(0,162,255,1),
                  ),
                  onPressed: () => {
                    if (validatorKey.currentState != null) {
                      if(validatorKey.currentState!.validate())
                      {
                         sendPhoneNumber(),

                      }
                      else if((value == null || value.isEmpty)){
                        print("UnSuccessfull"),
                      } else {print("UnSuccessfull"),}

                      }
                  },

                  ),      

      ],

      ),
        ),

    ),

      );
  }

void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }

}