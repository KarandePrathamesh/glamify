import 'package:flutter/material.dart';
import 'package:glamify/pages/auth/login.dart';

// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:math';
// import 'package:cryptography/cryptography.dart';

import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // State
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  // String hashedPassword = '';
  String role = 'User';

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

  // **Build Method**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  Back Arrow icon
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, left: 5.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      color: Colors.white,
                      highlightColor: Color(0xff414040),
                      hoverColor: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip: ("Back to log in"),
                    ),
                  ),
                ],
              ),

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
                'Sign up',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.5),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  //
                  // **Username Field**
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ), // when not focused
                      floatingLabelStyle: TextStyle(
                        color:
                            Colors
                                .black, // this color will be shown when focused
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

                    // ** setState
                    onChanged: (value) {
                      setState(() {
                        username = value.trim();
                      });
                    },
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
                  SizedBox(height: 10),

                  // **Email Field**
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ), // when not focused
                      floatingLabelStyle: TextStyle(
                        color:
                            Colors
                                .black, // this color will be shown when focused
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
                    keyboardType: TextInputType.emailAddress,

                    // ** setState
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
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

                  // **Password Field**
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ), // when not focused
                      floatingLabelStyle: TextStyle(
                        color:
                            Colors
                                .black, // this color will be shown when focused
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
                      icon: Icon(Icons.password, color: Colors.black),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must be at least 8 characters, include an uppercase, lowercase, digit, and special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  //** Confirm password
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ), // when not focused
                      floatingLabelStyle: TextStyle(
                        color:
                            Colors
                                .black, // this color will be shown when focused
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
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please confirm your password';
                      }
                      if (value != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  //**Dropdown User List */
                  DropdownButtonFormField<String>(
                    value: role,
                    decoration: InputDecoration(
                      labelText: 'Select Role',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ), // when not focused
                      floatingLabelStyle: TextStyle(
                        color:
                            Colors
                                .black, // this color will be shown when focused
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
                      icon: Icon(
                        Icons.verified_user_rounded,
                        color: Colors.black,
                      ),
                    ),
                    items:
                        ['User', 'Barber', 'Admin']
                            .map(
                              (role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        role = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // **Sign Up Button**
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // hashedPassword = await hashPasswordArgon2(
                        //   password,
                        // ); // Update hashedPassword

                        try {
                          // Create user in Firebase Auth
                          fbAuth.UserCredential userCred = await fbAuth
                              .FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                          // Add user data to Firestore
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCred.user!.uid)
                              .set({
                                'username': username,
                                'email': email,
                                'role': role,
                                'password': password,
                                'createdAt': Timestamp.now(),
                              });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                              settings: RouteSettings(
                                arguments: {
                                  'username': username,
                                  'password': password,
                                  'email': email,
                                },
                              ),
                            ),
                          );

                          // Clear Fields and State
                          usernameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                          _formKey.currentState!.reset();
                          setState(() {
                            username = '';
                            email = '';
                            password = '';
                            confirmPassword = '';
                            role = 'User';
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration Successful'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Signup failed due to : $e'),
                            ),
                          );
                        }
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 90,
                        vertical: 20,
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  //** back to login **
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Already have an account!!!\nlog in here...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
