import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isPasswordCheckVisible = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordCheckTextController = TextEditingController();
  String _signUpFailMessageText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Leading 버튼 클릭 시 실행되는 로직
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _emailTextController,
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
                controller: _passwordTextController,
                obscureText: !_isPasswordVisible, // 비밀번호 숨김 설정
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
              SizedBox(height: 15),
              TextField(
                controller: _passwordCheckTextController,
                obscureText: !_isPasswordCheckVisible, // 비밀번호 숨김 설정
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), // 자물쇠 아이콘 추가
                  hintText: 'Confirm the password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.white, // 테두리 색상을 흰색으로 설정
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordCheckVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordCheckVisible = !_isPasswordCheckVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _firebaseSignUp(_emailTextController.text.trim(),
                          _passwordTextController.text.trim());
                      showDialog(
                        context: context,
                        barrierDismissible: false, // 바깥을 탭해도 대화상자가 닫히지 않습니다.
                        builder: (context) {
                          return AlertDialog(
                            content: Text("$_signUpFailMessageText"),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // OK 버튼을 누르면 대화상자를 닫습니다.
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // 원하는 둥근 모서리 반지름 설정
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _firebaseSignUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _signUpFailMessageText = "The password provided is too weak.";
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _signUpFailMessageText = "The account already exists for that email.";
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _signUpFailMessageText =
              "The email address is not formatted correctly.";
        });
      } else if (e.code == 'operation-not-allowed') {
        setState(() {
          _signUpFailMessageText = "Email/password accounts are not enabled.";
        });
      } else if (e.code == 'user-disabled') {
        setState(() {
          _signUpFailMessageText =
              "The user account has been disabled by an administrator.";
        });
      } else if (e.code == 'too-many-requests') {
        setState(() {
          _signUpFailMessageText = "Too many requests to sign in as this user.";
        });
      } else {
        setState(() {
          _signUpFailMessageText = "An undefined Error happened.";
        });
      }
    }
  }
}
