import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class singUpPage extends StatefulWidget {
  const singUpPage({super.key});

  @override
  State<singUpPage> createState() => _singUpPageState();
}

class _singUpPageState extends State<singUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose(){
    _usernameController.clear();
    _passwordController.clear();
    super.dispose();
  }
  void _signUp() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if(username.isEmpty || password.isEmpty){
      _showDialog('Error', 'Username and password cannot be empty.');
      return;
    }
    if(prefs.containsKey(username)){
      _showDialog('Error', 'Username already exists. Please choose another one.');
    } else {
      await prefs.setString(username, password);
      _showDialog('Success', 'Account created successfully!', () {
        Navigator.of(context).pop();
        Navigator.of(context).pop(); // Go back to login page
      });
    }
  }
  void _showDialog(String title, String content, [VoidCallback? onOkPressed]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: onOkPressed ?? () => Navigator.of(context).pop(),
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
              'sign up',
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
                _signUp();
              },
              child: const Text('sign up',
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
                const Text("already have an account?"),
                TextButton(
                  onPressed: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const login()),
                    )
                  },
                  child: const Text("log in"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}