import 'package:flutter/material.dart';
import 'package:glamify/pages/users/admin/bottom_nav.dart';
import 'package:glamify/pages/users/barber/bottom_nav.dart';
import 'package:glamify/pages/users/customer/bottom_nav.dart';
import 'package:glamify/pages/auth/signup.dart';

import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:math';
// import 'package:cryptography/cryptography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //states
  String username = '';
  String password = '';
  String email = '';
  String hashedPassword = '';

  // ** Regex for email and password validation
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  // ** hashPassword Method **
  // Future<String> hashPasswordArgon2(String password) async {
  //   final algorithm = Argon2id(
  //     parallelism: 2,
  //     memory: 4096,
  //     iterations: 3,
  //     hashLength: 32,
  //   );

  //   final salt = Uint8List.fromList(
  //     List<int>.generate(16, (i) => Random.secure().nextInt(256)),
  //   );

  //   final secretKey = await algorithm.deriveKey(
  //     secretKey: SecretKey(utf8.encode(password)),
  //     nonce: salt,
  //   );

  //   final hashedBytes = await secretKey.extractBytes();

  //   return '${base64.encode(salt)}:${base64.encode(hashedBytes)}';
  // }

  @override
  void dispose() {
    // Dispose controllers
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pre-fill's user data if passed from signup.
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args != null) {
      usernameController.text = args['username'] ?? '';
      emailController.text = args['email'] ?? '';
      passwordController.text = args['password'] ?? '';
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/glamify_logo.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Glamify',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Log in',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Form(
                key: _formKey,
                child:
                // UserName Field
                TextFormField(
                  cursorColor: Colors.black,
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ), // when not focused
                    floatingLabelStyle: TextStyle(
                      color:
                          Colors.black, // this color will be shown when focused
                      fontWeight: FontWeight.normal, // optional styling
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ), // Change this to any color
                    ),
                    icon: Icon(Icons.person_sharp, color: Colors.black),
                  ),
                  onChanged: (value) => username = value.trim(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'username is required';
                    }
                    if (value.trim().length < 3) {
                      return 'username must be at least 3 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),

              // Email Field
              TextFormField(
                cursorColor: Colors.black,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ), // when not focused
                  floatingLabelStyle: TextStyle(
                    color:
                        Colors.black, // this color will be shown when focused
                    fontWeight: FontWeight.normal, // optional styling
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ), // Change this to any color
                  ),
                  icon: Icon(Icons.email_rounded, color: Colors.black),
                ),
                onChanged: (value) => email = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'email is required';
                  }
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Password field
              TextFormField(
                cursorColor: Colors.black,
                controller: passwordController,
                // keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ), // when not focused
                  floatingLabelStyle: TextStyle(
                    color:
                        Colors.black, // this color will be shown when focused
                    fontWeight: FontWeight.normal, // optional styling
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ), // Change this to any color
                  ),
                  icon: Icon(Icons.password_sharp, color: Colors.black),
                ),
                onChanged: (value) => password = value.trim(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password is required';
                  }
                  if (!passwordRegex.hasMatch(value)) {
                    return 'password must be at least 8 characters, include an uppercase, lowercase, digit, and special character';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    try {
                      final userCredential = await fbAuth.FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                      final userDoc =
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .get();

                      final role = userDoc['role'];
                      final username = userDoc['username'];

                      // Greeting message
                      String greetingMessage(String name) {
                        final hour = DateTime.now().hour;
                        String greet;
                        if (hour < 12) {
                          greet = 'Good morning';
                        } else if (hour < 17) {
                          greet = 'Good afternoon';
                        } else {
                          greet = 'Good evening';
                        }
                        return 'Hey $name! $greet!,\n Let’s get glam! ';
                      }

                      // Create SnackBar
                      final snackBar = SnackBar(
                        elevation: 2,
                        backgroundColor: Color(0xff191B06),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 5),
                        content: Text(
                          greetingMessage(username),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      );

                      // Show SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      // Clear Fields and State
                      usernameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      _formKey.currentState!.reset();

                      // Navigate to role-based screens
                      if (role == 'Admin') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminBottomNavBar(),
                          ),
                        );
                      } else if (role == 'Barber') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BarberBottomNavBar(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => UserBottomNavBar()),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 2,
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 5),
                          content: Text(
                            'Log in failed !',
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.red[800],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Sign Up Link
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Center(
                  child: Text(
                    "Don’t have an account!!!\nSign up here...",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
