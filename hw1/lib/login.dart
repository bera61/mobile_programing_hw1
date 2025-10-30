import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'singUpPage.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => loginState(); 
}


class loginState extends State<login> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }
  void _login() async{
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    final storedPassword = prefs.getString(username);
    if(storedPassword != null && storedPassword == password){
      _showResultDialog(
        'login succesful',
        'Welcome!',
        (){
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
        } 
      );
    }else {
      _showResultDialog(
        'Log In Failed!',
        'Please try again!',
        () {
          Navigator.of(context).pop(); 
        },
      );
    }
  }

  void _showResultDialog(String title, String message , VoidCallback onOkPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onOkPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Departmant Application",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue, 
              ),
              onPressed: () {
                _login();

              },
              child: const Text('Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("or"),
                TextButton(
                  onPressed: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const singUpPage()),
                    )
                  },
                  child: const Text("sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}