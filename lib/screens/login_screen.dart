// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_mobile/models/loginError.dart';
// import 'package:flutter_mobile/models/token.dart';
// import 'package:flutter_mobile/screens/home.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isLoggedIn = false;
//   bool isLoginInProgress = false;

//   //email controller
//   final TextEditingController _emailController =
//       TextEditingController(text: "superadmin@gmail.com");
//   //password controller
//   final TextEditingController _passwordController =
//       TextEditingController(text: "password");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             TextFormField(
//               controller: _passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   setState(() {
//                     isLoginInProgress = true;
//                   });
//                   //request login
//                   Map<String, String> headers = {"Accept": "application/json"};
//                   final response = await http.post(
//                     Uri.parse('http://192.168.1.20:8000/api/auth/login'),
//                     headers: headers,
//                     body: {
//                       'email': _emailController.text,
//                       'password': _passwordController.text,
//                       'device_name': 'android',
//                     },
//                   );
//                   if (response.statusCode == 200) {
//                     final jsonResponse = json.decode(response.body);
//                     final token = Token.fromJson(jsonResponse);
//                     final prefs = await SharedPreferences.getInstance();
//                     print("Token From Api ${token.token}");
//                     if (token.token != null) {
//                       // await prefs.setString(
//                       //     'token', jsonDecode(response.body)['token']);
//                       await prefs.setString('token', token.token!);
//                       setState(() {
//                         isLoginInProgress = false;
//                         isLoggedIn = true;
//                       });

//                       if (!mounted) {
//                         return;
//                       }

//                       if (isLoggedIn) {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     const HomePage()));
//                       }
//                     }
//                   } else {
//                     final jsonResponse = json.decode(response.body);
//                     final loginError = LoginError.fromJson(jsonResponse);
//                     // print(loginError.message);
//                     // print(loginError.errors?.email?.elementAt(0));
//                     setState(() {
//                       isLoginInProgress = false;
//                       isLoggedIn = false;
//                     });
//                   }
//                 },
//                 child: const Text("Login"),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Row(
//                 children: [
//                   const Text("Belum punya akun?"),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushReplacementNamed(context, '/register');
//                     },
//                     child: Text("Daftar"),
//                   )
//                 ],
//               ),
//             ),
//             Visibility(
//               visible: isLoginInProgress,
//               child: const CircularProgressIndicator(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starter_stisla/components/background.dart';
import 'package:flutter_starter_stisla/models/loginError.dart';
import 'package:flutter_starter_stisla/models/token.dart';
import 'package:flutter_starter_stisla/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;
  bool isLoginInProgress = false;

  //email controller
  final TextEditingController _emailController =
      TextEditingController(text: "superadmin@gmail.com");
  //password controller
  final TextEditingController _passwordController =
      TextEditingController(text: "password");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // Text Email
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            // Text Password
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),
            // Button Login
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoginInProgress = true;
                  });
                  //request login
                  Map<String, String> headers = {"Accept": "application/json"};
                  final response = await http.post(
                    Uri.parse('http://192.168.1.20:8000/api/auth/login'),
                    headers: headers,
                    body: {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'device_name': 'android',
                    },
                  );
                  if (response.statusCode == 200) {
                    final jsonResponse = json.decode(response.body);
                    final token = Token.fromJson(jsonResponse);
                    final prefs = await SharedPreferences.getInstance();
                    print("Token From Api ${token.token}");
                    if (token.token != null) {
                      // await prefs.setString(
                      //     'token', jsonDecode(response.body)['token']);
                      await prefs.setString('token', token.token!);
                      setState(() {
                        isLoginInProgress = false;
                        isLoggedIn = true;
                      });

                      if (!mounted) {
                        return;
                      }

                      if (isLoggedIn) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomePage()));
                      }
                    }
                  } else {
                    final jsonResponse = json.decode(response.body);
                    final loginError = LoginError.fromJson(jsonResponse);
                    // print(loginError.message);
                    // print(loginError.errors?.email?.elementAt(0));
                    setState(() {
                      isLoginInProgress = false;
                      isLoggedIn = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41),
                    ]),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Page Sign Up
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                children: [
                  const Text("Belum punya akun?"),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(" Sign Up"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
