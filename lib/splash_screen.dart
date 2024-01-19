import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiroleapp/home_screen.dart';
import 'package:multiroleapp/login_screen.dart';
import 'package:multiroleapp/student_screen.dart';
import 'package:multiroleapp/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    isLogin();
  }
void isLogin() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool isLogin = sp.getBool('isLogin') ?? false;
    String UserType = sp.getString('UserType') ?? '';

    if(isLogin){

      if(UserType == 'student'){
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const StudentScreen()),
          );
        });
      }
      else if(UserType == 'teacher'){
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const TeacherScreen()),
          );
        });
      }
      else{
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
          );
        });
      }
    }
    else{
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
        );
      });
    }
}


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Image(
        height: double.infinity,
        fit: BoxFit.fitHeight,
        image: NetworkImage('https://images.pexels.com/photos/8229945/pexels-photo-8229945.jpeg?auto=compress&cs=tinysrgb&w=600'),)),
    );
  }
}
