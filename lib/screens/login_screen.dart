
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/custom_button_auth.dart';
import '../widgets/custom_logo_auth.dart';
import '../widgets/custom_text_form.dart';
import 'home_screen.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return; //==================
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.white.withAlpha(240),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 50),
                    const CustomLogoAuth(),
                    Container(height: 20),
                    const Text("Login",
                        style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(height: 20),
                    const Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      isPassword: false,
                        hinttext: "ُEnter Your Email",
                        mycontroller: email,
                        validator: (val) {
                          if (val == "") {
                            return "Can't To be Empty";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val!)) {
                            return 'Please enter a valid email';
                          }
                        }),
                    Container(height: 10),
                    const Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                        suffixIcon: IconButton(
                          icon: Icon(
                            !isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        isPassword: !isPasswordVisible,
                        hinttext: "ُEnter Your Password",
                        mycontroller: password,
                        validator: (val) {
                          if (val == "") {
                            return "Can't To be Empty";
                          }
                        }),
                    InkWell(
                      onTap: () async {
                        if (email.text == "") {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Missing Email',
                            desc:
                             "Please enter your email and press Forget Password",
                          ).show();
                          return;
                        }
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Link Sent',
                            desc:
                              "We've sent you a link to reset your password. Please check your email",
                          ).show();
                        }catch (e) {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Invalid Email',
                              desc:
                              "Please make sure the email address you entered is correct")
                              .show();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.topRight,
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                ? Center(child: CircularProgressIndicator(color: Color(0xff169E3C),))
                : CustomButtonAuth(
                  title: "login",
                  onPressed: () async {

                    if (formState.currentState?.validate() ?? false) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                        if (credential.user!.emailVerified) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                            '"Please verify your email address before logging in."',
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'No user found for that email.',
                          ).show();
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided for that user',
                          ).show();
                        } else {
                          print("==========Not Valid");
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided for that user',
                          ).show();
                        }
                      }
                    }
                  }),
              Container(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xff169E3C), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(color: Color(0xff169E3C), width: 2),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login With Google  "),
                    Image.asset(
                      "assets/images/google.png",
                      width: 20,
                    )
                  ],
                ),
              ),
              Container(height: 20),
              // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context, // First argument is context
                    MaterialPageRoute(
                      builder: (context) => SignUp(), // Second argument is the route
                    ),
                  );
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Don't Have An Account ? ",
                    ),
                    TextSpan(
                        text: "Register",
                        style: TextStyle(
                            color: Color(0xff169E3C), fontWeight: FontWeight.bold)),
                  ])),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
