import 'package:flutter/material.dart';
import 'package:flutter_assingment/historyPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    final String apiUrl = "https://api.mobifintech.in/uat/user_details";
    final String apiKey = "h4xEKQUFUEE8PSL";

    final String userId = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (userId.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in both User ID and Password.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "api-key": apiKey,
        },
        body: {
          "user_id": userId,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Handle different status responses
        if (responseData['status'] == "MOB00") {
          // Login successful
          final userData = responseData['data'];
          if (userData is Map<String, dynamic>) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HistoryPage(data: userData)),
            );
          } else {
            setState(() {
              _errorMessage = "Invalid User ID or Password.";
            });
          }
        } else if (responseData['data'] == "INVALID_USER_ID") {
          setState(() {
            _errorMessage =
            "The User ID you entered is incorrect. Please try again.";
          });
        } else if (responseData['status'] == "INVALID_PASSWORD") {
          setState(() {
            _errorMessage =
            "The Password you entered is incorrect. Please try again.";
          });
        } else {
          setState(() {
            _errorMessage =
                responseData['message'] ?? "Login failed. Please try again.";
          });
        }
      } else {
        setState(() {
          _errorMessage =
          "Server error: ${response.statusCode}. Please try again later.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
        "Network error: Unable to connect. Please check your internet connection.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 20),
                    // User ID Input
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "User ID",
                        labelStyle: TextStyle(color: Colors.teal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.teal.shade50,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Password Input
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.teal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.teal.shade50,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Error Message
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    SizedBox(height: 16.0),
                    // Login Button
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


