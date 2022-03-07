import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//initialize firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //login function
  static Future<User?> loginUsingEmailPassword(required string email, required string password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found" )  {
        print("No user found for that email");

      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My App Title",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            const Text("Login to your App",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 44.0,
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "User Email",
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "User Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.black))),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Don't Remember your password?",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                child: RawMaterialButton(
                    fillColor: Color(0xFF0069FE),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    onPressed: () {},
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )))),
          ],
        ));
  }
}
