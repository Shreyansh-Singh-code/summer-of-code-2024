import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_2/inventory_page.dart';
import 'login_page.dart';
import 'welcome_page.dart';
import 'register_page.dart';
import 'internet.dart';
import 'auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: const Task5App(),
    )
  );
}

class Task5App extends StatelessWidget {
  const Task5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile' : (context) => ProfilePage(),
        '/inventory': (context) => Inventory_Page(),

      },
    );
  }
}
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  
  
 @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Profile",
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
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.only(left: 40,right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ${authProvider.fullName ?? 'Guest'}!",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        "Email: ${authProvider.email ?? 'Guest@email'}",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        "Phone: ${authProvider.phone ?? 0}",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40,),

                      SizedBox(
                        height: 50,
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            authProvider.logout();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      ),
                      SizedBox(height: 60,),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/inventory');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                          ),
                          child: const Text(
                            'Open Inventory',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      
                      const SizedBox(height: 30,),
                      ConnectivityWidget(),


                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  } 
}



