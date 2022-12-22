// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_mobile/models/categories.dart';
// import 'package:flutter_mobile/screens/add_screen.dart';
// import 'package:flutter_mobile/screens/edit_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   var categoryList = <Category>[];

//   Future<List<Category>?> getList() async {
//     final prefs = await _prefs;
//     var token = prefs.getString('token');
//     print(token);
//     var headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     try {
//       var url = Uri.parse("http://192.168.1.20:8000/api/categories");

//       final response = await http.get(url, headers: headers);

//       print(response.statusCode);
//       print(categoryList.length);
//       print(jsonDecode(response.body));

//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         return categoryFromJson(jsonString);
//       }
//     } catch (error) {
//       print('Testing');
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => const AddScreen()));
//         },
//         child: const Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('List Categories'),
//               FutureBuilder<List<Category>?>(
//                 future: getList(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       padding: const EdgeInsets.all(0),
//                       shrinkWrap: true,
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(snapshot.data![index].name),
//                             trailing: IconButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                             EditScreen(
//                                               id: snapshot.data![index].id,
//                                               category:
//                                                   snapshot.data![index].name,
//                                             )));
//                               },
//                               icon: const Icon(
//                                 Icons.edit,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     //request logout
//                     final pref = await SharedPreferences.getInstance();
//                     final token = pref.getString('token');

//                     final logoutRequest = await http.post(
//                       Uri.parse('http://192.168.1.20:8000/api/auth/logout'),
//                       headers: {
//                         'Content-Type': 'application/json',
//                         'Accept': 'application/json',
//                         'Authorization': 'Bearer $token',
//                       },
//                     );
//                     if (!mounted) return;
//                     if (logoutRequest.statusCode == 200) {
//                       print("logout success");
//                       //logout success
//                       pref.clear();
//                       //navigate to login page
//                       Navigator.of(context).pushReplacementNamed('/');
//                     }
//                   },
//                   child: Text('Logout'),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starter_stisla/components/background.dart';
import 'package:flutter_starter_stisla/models/categories.dart';
import 'package:flutter_starter_stisla/screens/add_screen.dart';
import 'package:flutter_starter_stisla/screens/edit_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var categoryList = <Category>[];

  Future<List<Category>?> getList() async {
    final prefs = await _prefs;
    var token = prefs.getString('token');
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var url = Uri.parse("http://192.168.1.20:8000/api/categories");

      final response = await http.get(url, headers: headers);

      print(response.statusCode);
      print(categoryList.length);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return categoryFromJson(jsonString);
      }
    } catch (error) {
      print('Testing');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const AddScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "List Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 116, 38, 250),
                  fontSize: 36,
                ),
              ),
            ),
            FutureBuilder<List<Category>?>(
              future: getList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index].name),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditScreen(
                                            id: snapshot.data![index].id,
                                            category:
                                                snapshot.data![index].name,
                                          )));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              // width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  //request logout
                  final pref = await SharedPreferences.getInstance();
                  final token = pref.getString('token');

                  final logoutRequest = await http.post(
                    Uri.parse('http://192.168.1.20:8000/api/auth/logout'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer $token',
                    },
                  );
                  if (!mounted) return;
                  if (logoutRequest.statusCode == 200) {
                    print("logout success");
                    //logout success
                    pref.clear();
                    //navigate to login page
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.bottomLeft,
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
                      Color.fromARGB(255, 255, 34, 170),
                      Color.fromARGB(255, 255, 41, 98),
                    ]),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "LOGOUT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
