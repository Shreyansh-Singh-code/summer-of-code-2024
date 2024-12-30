import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
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
                onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                if (_formKey.currentState!.validate()) {
                  authProvider.setLoading(true);
                  await Future.delayed(Duration(seconds: 2));

                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  final prefs = await SharedPreferences.getInstance();
                  final savedemail = prefs.getString('email') ?? '';
                  final savedpwd = prefs.getString('password') ?? '';
                  

                  if (_emailController.text == savedemail && _passwordController.text == savedpwd) {
                    authProvider.setLoading(false);
                    authProvider.setEmail(savedemail);
                    ScaffoldMessenger.of(context).showSnackBar(
                      
                      SnackBar(content: Text('Login Successful!')),
                    );
                    Navigator.pushNamed(context, '/profile');
                  } else {
                    authProvider.setLoading(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid Credentials!")),
                    );
                  }
                }
              },



              style:ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 192, 163),
                elevation: 10,
                shadowColor: Colors.black12
                
              ),
              
              child: Consumer<AuthProvider>(
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