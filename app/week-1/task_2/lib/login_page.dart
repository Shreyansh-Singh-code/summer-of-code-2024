import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_2/auth.dart' as custom_auth;
import 'internet.dart';




class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signInWithEmail(BuildContext context) async {
    final authProvider = Provider.of<custom_auth.AuthProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      authProvider.setLoading(true);

      try {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final userId = userCredential.user!.uid;

        final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
        if(doc.exists) {
          final userData = doc.data()!;
          authProvider.setFullname(userData['name']);
          authProvider.setEmail(userData['email']);
          authProvider.setPhone(userData['phone']);

          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );

        Navigator.pushNamed(context, '/profile');
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found in Firestore.')),
          );
        }
  
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      } finally {
        authProvider.setLoading(false);
      }
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

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signed in with Google")),
      );

      Navigator.pushNamed(context, '/profile'); 
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
      key: _formKey,
      child:  Padding(
        padding: const EdgeInsets.only(left: 0.1, right: 0.1),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 7,),
            

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

            const SizedBox(height: 60,),

            const Text(
              'Password',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
            ),
            const SizedBox(
              height: 7,
            ),
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

            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                        value: false,
                        onChanged: (value) {

                        },
                        activeColor: Colors.blue,
                        
                      ),
                      const Text(
                        "Remember Me",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                      ],
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            
                        
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                        ),
                      )

                      ],
                  ),
            const SizedBox(height: 60,),     

            SizedBox(
              width: double.infinity,
              height:50,
            
              child: ElevatedButton(
                onPressed: () => signInWithEmail(context),



               style:ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 192, 163),
                elevation: 10,
                shadowColor: Colors.black12
                
              ),
              
               child: Consumer<custom_auth.AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white,)
                  : const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ); 
                }
              ),
              ),
              
            ),
            SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              height:50,
            
              child: ElevatedButton(
                onPressed: () => signInWithGoogle(context),



               style:ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 192, 163),
                elevation: 10,
                shadowColor: Colors.black12
                
              ),
              
               child: Consumer<custom_auth.AuthProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white,)
                  : const Text(
                    'Sign In with Google',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ); 
                }
              ),
              ),
              
            )

            
          ],
        ),
      )
      
    
    );
  }
}


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Login to continue",
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
          child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                ConnectivityWidget(),
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
                const SizedBox(height: 60,),
            
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back!',
                         style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                         ),
                        ),
                      const SizedBox(height: 12,),
                      const Text(
                        'Login to continue',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 30,),
            
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
            
                      
                      
                      const MyCustomForm(),
            
                      const SizedBox(height: 30,),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
            
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
            
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color.fromARGB(255, 218, 192, 163),
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                decorationColor: Color.fromARGB(255, 218, 192, 163),
                                decorationThickness: 2.5
                              ),
                            ),
                          )
                        ],
                      ),
                      ConnectivityWidget(),
                      
            
                    ],
                  ),
            
                  )
            
              ],
            
            ),
          ),
        ),
      )
      
    );
  }
}