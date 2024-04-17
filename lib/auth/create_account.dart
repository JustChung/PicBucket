import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _clearAll() {
    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';
  }

  // sign user in method
  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pop(context);
        _clearAll();
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e.code"))
        );
      }
    }
  }

  bool passwordConfirmed(){
    bool matchConfirmed = _passwordController.text.trim() == _confirmPasswordController.text.trim();
    bool lengthConfirmed = _passwordController.text.length >= 6;
    if (!matchConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match.'))
      );
    } else if (!lengthConfirmed){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password length must be greater than 6 characters.'))
      );
    }
    return matchConfirmed && lengthConfirmed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height-100,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child:
                      Image.asset(
                        'assets/bucket.png',
                        height: 200,
                      ),

                ),

                // welcome back, you've been missed!
                Text(
                  'Join the Bucket.',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // sign in button
                Padding(
                    padding: EdgeInsets.all(20),
                    child: MyButton(
                      onTap: signUp,
                      text: "Sign Up",
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}