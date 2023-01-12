import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nataraja_games/api_files/login_response.dart';
import 'package:nataraja_games/api_files/shared_preferense.dart';
import 'package:nataraja_games/presentation/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:nataraja_games/presentation/webViewController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _links = 'https://natarajagames.in/app/login.php';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getUserNameField(),
          getPasswordField(),
          getButton(),
        ],
      ),
    );
  }

  Widget getUserNameField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 1)),
          child: TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "UserName",
                hintStyle: TextStyle(color: Colors.black26, fontSize: 15)),
          ),
        ),
      ],
    );
  }

  Widget getPasswordField() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1)),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black26, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getButton() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: GestureDetector(
        onDoubleTap: () {},
        onTap: () {
          usernameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty
              ? getLoginUsers()
              : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please Enter the Username and Password")));
        },
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future<LoginResponse> getLoginUsers() async {
    try {
      final result = await http.post(
          Uri.parse("https://natarajgames.codingwala.com/login_api.php"),
          body: {
            "username": usernameController.text.trim(),
            "password": passwordController.text.trim(),
          });

      print("new user:" + result.body);
      print("statusCode:" + result.statusCode.toString());


        Map<String, dynamic> body = jsonDecode(result.body);

        if(body['message'] == "Login Success"){
          AppPreferences.setUserName(usernameController.text.trim());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${body['message']}")));
          print("balance ${body['balance']}");
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(coin: body['balance'],)));
          _handleURLButtonPress(context, _links, body['balance']);
        }
        else{
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${body['message']}")));
        }

      return loginResponseFromJson(result.body);
    } catch (e) {
      rethrow;
    }
  }

  void _handleURLButtonPress(BuildContext context, String url, String coin) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url, coin)));
  }

}
