import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityWidget extends StatefulWidget {
  @override
  _ConnectivityWidgetState createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  late Stream<List<ConnectivityResult>> _connectivityStream;
  bool _isDialogVisible = false;
  bool _wasConnected = false; 
  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleConnectivityChange(results);
    });
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    bool isConnected = results.isNotEmpty && results.any((result) => result != ConnectivityResult.none);

    if (!isConnected) {
      _showNoConnectionDialog();
    } else if (!_wasConnected) {
      
      if (_isDialogVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop(); 
        });
        _isDialogVisible = false;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showConnectionPopup();
      });
    }

    _wasConnected = isConnected; 
  }

  void _showNoConnectionDialog() {
    if (!_isDialogVisible) {
      _isDialogVisible = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (context) => AlertDialog(
            title: const Text("No Internet Connection"),
            content: const Text(
                "You are not connected to the internet. Please check your connection."),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  List<ConnectivityResult> results = await Connectivity().checkConnectivity();
                  if (results.isNotEmpty &&
                      results.any((result) => result != ConnectivityResult.none)) {
                    Navigator.of(context).pop(); 
                    _isDialogVisible = false;
                  }
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      });
    }
  }

  void _showConnectionPopup() {
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: _connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _handleConnectivityChange(snapshot.data!);
          });
        }
        return Container(); 
      },
    );
  }
}

