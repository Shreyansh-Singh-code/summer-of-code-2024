import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'login_page.dart';
import 'welcome_page.dart';
import 'register_page.dart';

void main() {
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
  // TODO: implement key
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  String scannedResult = 'No barcode scanned yet!';
  Future<void> scanBarcode() async {
    
    
    bool permissionGranted = await Permission.camera.request().isGranted;

    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission is required to scan barcodes")),
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
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      Text(
                        'Scanned Result: $scannedResult\n',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),

                      )
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



