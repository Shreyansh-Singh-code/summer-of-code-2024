import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'auth.dart';
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
                onPressed: () async {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  if (_formKey2.currentState!.validate()) {
                    authProvider.setLoading(true);
                    await Future.delayed(const Duration(seconds: 2));

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('full_name', _nameController.text);
                    await prefs.setString('email', _emailController.text);
                    await prefs.setString('password', _passwordController.text);
                    await prefs.setString('phone_no', _phonenoController.text);
                    authProvider.setLoading(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registered Successfully!'))
                    );
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                ),
                child: Consumer<AuthProvider>(
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
            const SizedBox(height: 35,)


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
      body: SizedBox.expand(
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 87),
          child:  const SingleChildScrollView(
            child: Column(
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
        ),
      )
    );
  } 
}