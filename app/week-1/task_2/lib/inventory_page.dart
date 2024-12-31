import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'internet.dart';


class ProductModel {
  final String productId;
  final String name;
  final double price;
  final String description;
  final int stock;

  ProductModel({required this.productId, required this.name, required this.price, required this.description, required this.stock});

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      productId: data['productId'],
      name: data['name'],
      price: data['price'],
      description: data['description'],
      stock: data['stock'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'description': description,
      'stock': stock,
    };
  }
}

class TransactionModel {
  final String transactionId;
  final String userId;
  final String productId;
  final String paymentId;
  final String invoiceUrl;
  final DateTime date;

  TransactionModel({required this.transactionId, required this.userId, required this.productId, required this.paymentId, required this.invoiceUrl, required this.date});

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    return TransactionModel(
      transactionId: data['transactionId'],
      userId: data['userId'],
      productId: data['productId'],
      paymentId: data['paymentId'],
      invoiceUrl: data['invoiceUrl'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'productId': productId,
      'paymentId': paymentId,
      'invoiceUrl': invoiceUrl,
      'date': date,
    };
  }
}


class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Map<String, dynamic>> cart = [];
  double totalPrice = 0.0;

  Future<void> scanAndFetchProduct() async {
    try {
      final scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE,
      );

      if (scannedBarcode != "-1") {
        final doc = await FirebaseFirestore.instance.collection('products').doc(scannedBarcode).get();
        if (doc.exists) {
          setState(() {
            final product = doc.data();
            cart.add(product!);
            totalPrice += product['price'];
          });
        } else {
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product not found! Adding new product...")),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
        }
      }
    } catch (e) {
      print("Error scanning barcode: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: scanAndFetchProduct,
            child: const Text("Scan Product"),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text("Price: \$${product['price']}"),
                  trailing: Text("Qty: 1"),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Total: ₹${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}



class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  String barcode = "";

  Future<void> scanBarcode() async {
    try {
      final scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Scanner line color
        "Cancel",  // Cancel button text
        true,      // Show flash icon
        ScanMode.BARCODE,
      );
      if (scannedBarcode != "-1") {
        setState(() {
          barcode = scannedBarcode;
        });
      }
    } catch (e) {
      print("Barcode scan error: $e");
    }
  }

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        final productId = barcode.isNotEmpty ? barcode : DateTime.now().toString();

        await FirebaseFirestore.instance.collection('products').doc(productId).set({
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'description': _descriptionController.text,
          'stock': int.parse(_stockController.text),
          'productId': productId,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product added successfully!")),
        );

        Navigator.pop(context);
      } catch (e) {
        print("Error adding product: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: scanBarcode,
                child: const Text("Scan Barcode"),
              ),
              const SizedBox(height: 10),
              Text("Barcode: $barcode"),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
                validator: (value) => value!.isEmpty ? "Please enter product name" : null,
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
                validator: (value) => value!.isEmpty ? "Please enter price" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextFormField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Stock"),
                validator: (value) => value!.isEmpty ? "Please enter stock quantity" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: addProduct,
                child: const Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Inventory_Page extends StatefulWidget {
  @override
  _Inventory_PageState createState() => _Inventory_PageState();
}

class _Inventory_PageState extends State<Inventory_Page> {
  String scannedResult = 'No barcode scanned yet!';
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts(); 
  }

  Future<void> fetchProducts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('products').get();
      setState(() {
        products = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

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
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Inventory Page",
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 40, right: 40, bottom: 20),
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
                padding: EdgeInsets.only(left: 40,right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                          ),
                          child: const Text(
                            'Add Products',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                          ),
                          child: const Text(
                            'Open Cart',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Products:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index){
                            final product = products[index];
                            return Card(
                              color: const Color.fromARGB(255, 218, 192, 163),
                              child: ListTile(
                                leading: const Icon(Icons.shopping_cart,color: Colors.black,),
                                title: Text(
                                  '${product['name'] ?? 'N/A'}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  'Price: ₹${product['price']}, Stock: ${product['stock']}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            );
                          },
                        )
                      ),

                    
                      
                      ConnectivityWidget(),
                  ],
                ),
              )
              ],
            ),
          ),
        ),
      ),

    );
  }
}





