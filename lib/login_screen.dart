import 'package:flutter/material.dart';
import 'package:multiroleapp/admin_screen.dart';
import 'package:multiroleapp/student_screen.dart';
import 'package:multiroleapp/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String selectedUserTypes = 'Select User Type';
  List<String> UserTypes = [ 'Select User Type','Student', 'Teacher', 'Admin'];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedUserTypes,
              onChanged: (String? newValue){
                setState(() {
                  selectedUserTypes = newValue!;
                });
              },
              items: UserTypes.map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                hintText: 'Age',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();

                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());

                // admin, student , teacher
                sp.setString('UserType', selectedUserTypes);
                // sp.setString('UserType', 'student');
                sp.setBool('isLogin', true);

                if (sp.getString('UserType') == 'Student') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StudentScreen()));
                } else if (sp.getString('UserType') == 'Teacher') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TeacherScreen()));
                }else if (sp.getString('UserType') == 'Admin') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AdminScreen()));
                }

                else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StudentScreen()));
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.green,
                child: const Center(child: Text('LOGIN')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Future<void> sher() async {
//   await Future.delayed(const Duration(seconds: 3));
// }

/* Shared prefrences library code
SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('name', 'Sheryar');
                sp.setInt('age', 24);
                sp.setBool('login', false);
                print(sp.getBool('login').toString());
                print(sp.getString('name'));
                print(sp.getInt('age'));
 */
