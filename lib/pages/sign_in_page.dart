import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = true;
  /* 
  //로직 테스트
  FirebaseAuth auth = FirebaseAuth.instance;
  void signUpTest() async {
    FirebaseFirestore.instance
        .collection('test')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["s"]);
      });
    });
    try {
      // Create a new user
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: "skykhs3@naver.com",
        password: "testtest",
      );

      print("User signed up: ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), // 이메일 아이콘 추가
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.white, // 테두리 색상을 흰색으로 설정
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: _isPasswordVisible, // 비밀번호 숨김 설정
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), // 자물쇠 아이콘 추가
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.white, // 테두리 색상을 흰색으로 설정
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // signUpTest();
                    },
                  
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // 원하는 둥근 모서리 반지름 설정
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(onTap:(){},child: Text("Forgot your password?"))
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text("You don't have an account?"),
                        SizedBox(width: 5),
                        Text("Register"),
                      ],
                    ),
                  ),
                  Spacer()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
