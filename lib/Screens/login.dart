import 'package:aitbar_admin_panel/Services/helper_functions.dart';
import 'package:flutter/material.dart';
import 'dash_board.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Phalsa Admin Panel"),
            TextFormField(
              // autovalidateMode: AutovalidateMode.always,
              controller: _email,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (String? value){
                if(value!.isEmpty){
                  return "email is required";
                } else if(!value.contains("@")){
                  return "Invalid Email";
                } else if(!value.contains(".com")){
                  return "Invalid Email";
                }
                else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(labelText: "password"),
              validator: (String? value){
                if(value!.isEmpty){
                  return "pasword is required";
                } else {
                  return null;
                }
              },
            ),
            TextButton(
              onPressed: (){
                login();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  login(){
    if(_formKey.currentState!.validate()){
      if(_email.text == "admin@admin.com"  && _password.text == "admin"){
        print("loggin");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashBoard()), (route) => false);
      } else {
        print(" not loggin");
        Helper().message(context, "Email or Password is incorrect");
      }
    } else {
      return null;
    }
  }

}
