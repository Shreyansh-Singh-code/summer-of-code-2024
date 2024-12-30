import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

      },
    );
  }
}
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  String scannedResult = 'No barcode scanned yet!';
  List<String> scannedResults = [];
  
  Future<void> scanBarcode() async {
    
    
    bool permissionGranted = await Permission.camera.request().isGranted;

    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission is required to scan barcodes")),
      );
      return;
    }

    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 
        "Cancel",  
        true,      
        ScanMode.BARCODE, 
      );
      if (barcode != "-1") {
        setState(() {
          scannedResult = barcode;
        });
        saveScannedResult(barcode);
      } else {
        setState(() {
          scannedResult = "Scan canceled!";
        });
      }
    } catch (e) {
      setState(() {
        scannedResult = "Error occurred: $e";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    loadScannedResults(); 
  }
  Future<void> loadScannedResults() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      scannedResults = prefs.getStringList('scannedResults') ?? [];
    });
  }

  Future<void> saveScannedResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      scannedResults.add(result); 
    });
    await prefs.setStringList('scannedResults', scannedResults);
  }
  
 @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        "Welcome ${authProvider.fullName ?? 'Guest'}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Email: ${authProvider.email ?? 'Guest@email'}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Phone: ${authProvider.phone ?? 0}",
                        style: TextStyle(
                          fontSize: 25,
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
                            scanBarcode();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                          ),
                          child: const Text(
                            'Barcode Scanner',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        'Scanned Result: $scannedResult\n',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Previously Scanned Result:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: scannedResults.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            leading: const Icon(Icons.qr_code,color: Colors.white,),
                            title: Text(
                              scannedResults[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
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



