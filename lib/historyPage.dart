import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assingment/searchFeature.dart';
import 'package:flutter_assingment/userDetailsPage.dart'; // Import the new UserDetailsPage
import 'package:flutter_assingment/userProfilePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const HistoryPage({Key? key, required this.data}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> _history = [];
  List<dynamic> _filteredHistory = [];
  bool _isLoading = false;
  String _errorMessage = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserHistory();

    _searchController.addListener(() {
      _filterHistory();
    });
  }

  Future<void> _fetchUserHistory() async {
    const String apiUrl = "https://api.mobifintech.in/uat/presentation_transaction";
    const String apiKey = "h4xEKQUFUEE8PSL";

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {"api-key": apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == "MOB00") {
          setState(() {
            _history = data['data'] ?? [];
            _filteredHistory = _history;  // Initialize filtered list
          });
        } else {
          setState(() {
            _errorMessage = data['message'] ?? "Failed to fetch history.";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Server error: ${response.statusCode}. Please try again later.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please check your internet connection.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterHistory() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      _filteredHistory = _history.where((item) {
        String name = item['name']?.toLowerCase() ?? '';
        String loanNo = item['loan_no']?.toLowerCase() ?? '';
        return name.contains(query) || loanNo.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text("User History", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.white,),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: HistorySearchDelegate(_history),
                  );
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.person_alt_circle_fill, size: 30, color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Userprofilepage(data: widget.data)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
            : _filteredHistory.isEmpty
            ? Center(child: Text("No history found."))
            : ListView.builder(
          itemCount: _filteredHistory.length,
          itemBuilder: (context, index) {
            final item = _filteredHistory[index];
            return GestureDetector(
              onTap: () {
                // Navigate to UserDetailsPage with the selected user's data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailsPage(userData: item),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 3, // Adds shadow for better depth
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // Center trailing vertically
                        children: [
                          // Circular Avatar for ID with gradient and shadow
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.teal[900]!, Colors.teal[300]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                item['id']?.toString().substring(0, 2) ?? "N/A",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0), // Space between avatar and details
                          // Column for Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Username
                                Text(
                                  item['name'] ?? 'N/A',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                // Loan Number
                                Row(
                                  children: [
                                    Icon(Icons.numbers, color: Colors.grey, size: 16),
                                    SizedBox(width: 2),
                                    Text(
                                      "Loan No: ${item['loan_no'] ?? 'N/A'}",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Trailing Icon Centered
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 13.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      // Collection Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Amount: ₹${item['collection_amount'] ?? 'N/A'}",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          // Status
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: item['status'] == "Success" ? Colors.green : Colors.red,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Status: ${item['status'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: item['status'] == "Success" ? Colors.green : Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



