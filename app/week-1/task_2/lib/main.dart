import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Task5App());
}

class Task5App extends StatelessWidget {
  const Task5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
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
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  final prefs = await SharedPreferences.getInstance();
                  final savedemail = prefs.getString('email') ?? '';
                  final savedpwd = prefs.getString('password') ?? '';

                  if (_emailController.text == savedemail && _passwordController.text == savedpwd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Successful!')),
                    );
                  } else {
                    print('$savedemail, $savedpwd, ${_emailController.text}, ${_passwordController.text}');
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
              
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                
              ),
              ),
              
            ),

            
          ],
        ),
      )
      
    
    );
  }
}



class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromARGB(255, 16, 44, 87),
        child:  SingleChildScrollView(
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
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(right: 40,left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
          
                  children: [
          
                    Image.asset('assests/images/welcome.png', height: 300, width: 350,fit: BoxFit.cover,),
                    SizedBox(height: 40,),
          
                    const Text(
                    'Hello, Welcome !',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    'welcome to DSOC 2024',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      
                    ),
                  ),
                  const SizedBox(height: 50,),
          
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255,218,192,163)
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
          
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255,218,192,163)
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60,),
          
                  const Text(
                    'Or via Social Media',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
          
                  const SizedBox(height: 10,),
          
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
          
                    children: [
                      FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Color.fromARGB(255, 218, 192, 163),
                        size: 20
                      ),
                      SizedBox(width: 15,),
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Color.fromARGB(255, 218, 192, 163),
                        size: 20
                      ),
                      SizedBox(width: 15,),
                      FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: Color.fromARGB(255, 218, 192, 163),
                        size: 20
                      ),
                    ],
                  ),
                  SizedBox(height: 35,)
          
          
                
          
                  ],
                ),
          
              )
              
             ]
          ),
        )
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
      body: Container(
        color: const Color.fromARGB(255, 16, 44, 87),
        child:  SingleChildScrollView(
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
                    )
                    
          
                  ],
                ),
          
                )
          
            ],
          
          ),
        ),
      )
      
    );
  }
}


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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                onPressed: () async {
                  if (_formKey2.currentState!.validate()) {
                    print('validation passed!');

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('full_name', _nameController.text);
                    await prefs.setString('email', _emailController.text);
                    await prefs.setString('password', _passwordController.text);
                    await prefs.setString('phone_no', _phonenoController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registered Successfully!'))
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ),
            SizedBox(height: 35,)


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
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromARGB(255, 16, 44, 87),
        child:  SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Padding(
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
          
                    Text(
                      'Create Account Now!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 35,),
          
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height:20 ,),
          
                    MyCustomForm2(),
          
                
          
                    
          
          
          
          
                  ],
          
                ),
              )
            ]
          ),
        )
      )
    ); 
  } 
}
