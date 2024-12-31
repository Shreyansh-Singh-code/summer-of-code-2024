import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_2/auth.dart' as custom_auth;
import 'internet.dart';
import 'package:provider/provider.dart';

class MyCustomForm2 extends StatefulWidget {
  const MyCustomForm2({super.key});

  @override
  MyCustomFormState2 createState() {
    return MyCustomFormState2();
  }
}

class MyCustomFormState2 extends State<MyCustomForm2> {

  final _formKey2 = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phonenoController = TextEditingController();

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    final authProvider = Provider.of<custom_auth.AuthProvider>(context, listen: false);

    if(_formKey2.currentState!.validate()) {
      authProvider.setLoading(true);
    
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phonenoController.text,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered Successfully!')),
        );

      Navigator.pushReplacementNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
    } catch(e) {
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e"))
      );
    } finally {
      authProvider.setLoading(false);
    }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out all the correctly."))
      );
    }

  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final authProvider = Provider.of<custom_auth.AuthProvider>(context, listen: false);
    authProvider.setLoading(true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Sign-In canceled")),
        );
        authProvider.setLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signed in with Google")),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In error: $e")),
      );
    } finally {
      authProvider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey2,
      child: Padding(
        padding: const EdgeInsets.only(left: 0.1,right: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(

                filled: true,
                fillColor: const Color.fromARGB(255, 248, 240, 229),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 30,),

            const Text(
              'Email',
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20,),

            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(

                filled: true,
                fillColor: const Color.fromARGB(255, 248, 240, 229),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 30,),

            const Text(
              'Password',
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20,),

            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(

                filled: true,
                fillColor: const Color.fromARGB(255, 248, 240, 229),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 30,),

            const Text(
              'Phone No',
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20,),

            TextFormField(
              controller: _phonenoController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              
              decoration: InputDecoration(

                filled: true,
                fillColor: const Color.fromARGB(255, 248, 240, 229),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 50,),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () => signUpWithEmailAndPassword(context),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                ),
                child: Consumer<custom_auth.AuthProvider>(
                  builder: (context, authProvider,child) {
                    return authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    );
                  }
                ),
              ),
            ),
            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () => signInWithGoogle(context),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                ),
                child: Consumer<custom_auth.AuthProvider>(
                  builder: (context, authProvider,child) {
                    return authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : const Text(
                      'Sign In with Google',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    );
                  }
                ),
              ),
            ),
            const SizedBox(height: 20,)


          ],

        ),
      )

      
    );
  } 
}

class RegisterPage extends StatelessWidget {


  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Register New User",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: const Color.fromARGB(255, 218, 235, 228),
      ),
      body: SizedBox.expand(
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 87),
          child:   SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50,right: 40, left: 40,bottom:20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'DSOC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.menu_outlined,color: Colors.white,size: 35,)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40,right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
            
                    children: [
                      SizedBox(height: 60,),
            
                      const Text(
                        'Create Account Now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 35,),
            
                      const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height:20 ,),
            
                      MyCustomForm2(),
                      ConnectivityWidget(),

                      
                    ],
            
                  ),
                )
              ]
            ),
          )
        ),
      )
    );
  } 
}