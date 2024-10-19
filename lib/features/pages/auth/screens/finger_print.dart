import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class FingerprintAuthPage extends StatefulWidget {
  const FingerprintAuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FingerprintAuthPageState createState() => _FingerprintAuthPageState();
}

class _FingerprintAuthPageState extends State<FingerprintAuthPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _statusMessage = "Waiting for authentication...";

  @override
  void initState() {
    super.initState();
    _authenticateWithBiometrics();
  }

  Future<void> _authenticateWithBiometrics() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      setState(() {
        _isAuthenticating = false;
        _statusMessage = authenticated ? "Authentication successful!" : "Authentication failed or cancelled.";
      });

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(authenticated);
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _statusMessage = "Error: ${e.message}";
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isAuthenticating
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(_statusMessage),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

Future<bool?> showFingerprintAuthDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Fingerprint Authentication'),
        content: const Text('Please authenticate using your fingerprint.'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.fingerprint, color: Colors.green),
            onPressed: () async {
              Navigator.of(context).pop(true);
              // !!!!!!!!?!
              final bool? isAuthenticated = await _authenticate(context);
              if (isAuthenticated == true) {
            
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true);
              } else {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(false);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop(false); 
            },
          ),
        ],
      );
    },
  );
}

Future<bool?> _authenticate(BuildContext context) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const FingerprintAuthPage()),
  );
}
