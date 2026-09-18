import 'package:flutter/material.dart';
import 'package:project_futter_m_3/new_account.dart';
import 'package:project_futter_m_3/system_infrastructure/dashboard.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  void login() {
    String username = usernameController.text;
    String password = passwordController.text;
    print("Username: $username");
    print("Password: $password");
    Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: "DashBoard"),
            builder: (context)=> Dashboard()),
    );

// هنا لاحقاً نرسل البيانات إلى Flask
}
@override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.network_check,
                size: 90,
                color: Color(0xFF0A1730),
              ),
              const SizedBox(height: 20),
              const Text("Network Monitor",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 10),
              const Text("Login to your account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                )
              ),
              const SizedBox(height: 35),
              //username
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter your username",
                  prefixIcon: const Icon(Icons.person ,color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock , color: Colors.blue,),
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off,),
                      onPressed: () {
                        setState(() => hidePassword = !hidePassword);
                        },
                    ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: login,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730)),
                  ),
                  child: const Text("Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // New Account
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NewAccount()) );
              } ,
                child: const Text(
                  "Create New Account",
                  style: TextStyle(
                    fontSize: 16,
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