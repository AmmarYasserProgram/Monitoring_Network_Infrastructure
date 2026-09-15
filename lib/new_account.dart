import 'package:flutter/material.dart';
import 'package:project_futter_m_3/login_system.dart';
class NewAccount extends StatefulWidget {
  const NewAccount({super.key});
  @override
  State<NewAccount> createState() => _NewAccountState();
}


class _NewAccountState extends State<NewAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void createAccount() {
    String name = nameController.text;
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

// التأكد من أن الحقول ليست فارغة

    if (name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }
    print("Name: $name");
    print("Username: $username");
    print("Email: $email");
    print("Password: $password");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully"),
      ),
    );
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("New Account"),
        backgroundColor: Color(0xFF0A1730),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // Icon
              const Icon(
                Icons.person_add,
                size: 80,
                color: Color(0xFF0A1730),
              ),
              const SizedBox(height: 15),
              const Text("Create New Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
// Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your name",
                  prefixIcon: const Icon(Icons.person,color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
// Username
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter username",
                  prefixIcon: const Icon(Icons.account_circle,color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
// Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email ,color:  Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",
                  prefixIcon: const Icon(Icons.lock,color: Colors.blue,),
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off,),
                    onPressed: () {
                      setState(()=> hidePassword = !hidePassword);
                      },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
// Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Enter password again",
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue,),
                  suffixIcon: IconButton(
                    icon: Icon(hideConfirmPassword ? Icons.visibility : Icons.visibility_off,),
                    onPressed: () {
                      setState(() => hideConfirmPassword = !hideConfirmPassword);
                      },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
// Create Account Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: createAccount,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color(0xFF0A1730)
                    ),
                  ),
                  child: const Text("Create Account",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
// Back to Login
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  },
                child: const Text("Already have an account? Login",
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