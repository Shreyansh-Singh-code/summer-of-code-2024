import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_2/internet.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox.expand(
        child: Container(
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
                    
                    
                    ],
                  ),
            
                ),
                ConnectivityWidget(),
                
               ]
            ),
          )
        ),
      )

    );
  }
}