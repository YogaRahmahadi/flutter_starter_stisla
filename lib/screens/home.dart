import 'package:flutter/material.dart';
import 'package:flutter_starter_stisla/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_starter_stisla/components/background.dart';
import 'package:flutter_starter_stisla/helpers/http_helpers.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    final url = Uri.parse('${HttpHelper.baseUrl}/auth/logout');
    http.Response response = await http.post(url, headers: headers);
    print(token);
    _prefs.clear();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              logout();
            },
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
