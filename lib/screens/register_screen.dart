import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../widgets/custom_button_auth.dart';
import '../widgets/custom_logo_auth.dart';
import '../widgets/custom_text_form.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;



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
            color: Colors.white.withAlpha(210),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Form(
                key:formState ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 50),
                    const CustomLogoAuth(),
                    Container(height: 20),
                    const Text("SignUp",
                        style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(height: 10),
                    const Text("SignUp To Continue Using The App",
                        style: TextStyle(color: Colors.grey)),
                    Container(height: 20),
                    const Text(
                      "username",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextForm(
                      isPassword: false,
                        hinttext: "ُEnter Your username",
                        mycontroller: username,
                        validator: (val) {
                          if (val == "") {
                            return "Can't To be Empty";
                          }
                        }),
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
                          if (val!.length < 6) {
                            return "Password is too short";
                          }

                        }),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                ? Center(child: CircularProgressIndicator(color: Color(0xff169E3C),))
                : CustomButtonAuth(
                  title: "SignUp",
                  onPressed: () async {

                    if (formState.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        setState(() {
                          isLoading = false;
                        });
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Verify',
                          desc: 'Verify your email address before logging in.',
                        ).show();
                        Future.delayed(Duration(seconds: 4), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        });

                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The password provided is too weak.',
                          ).show();
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The account already exists for that email',
                          ).show();
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  }),
              Container(height: 20),

              Container(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );

                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Have An Account ? ",
                    ),
                    TextSpan(
                        text: "Login",
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