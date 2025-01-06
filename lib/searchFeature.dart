import 'package:flutter/material.dart';
import 'package:flutter_assingment/userDetailsPage.dart';

class HistorySearchDelegate extends SearchDelegate {
  final List<dynamic> history;

  HistorySearchDelegate(this.history);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Show clear button only if query has text
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear, color: Colors.black54),
          onPressed: () {
            query = ''; // Clear search query
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, null); // Close search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> results = history.where((item) {
      String name = item['name']?.toLowerCase() ?? '';
      String loanNo = item['loan_no']?.toLowerCase() ?? '';
      String id = item['id']?.toString().toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) ||
          loanNo.contains(query.toLowerCase()) ||
          id.contains(query.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ListView(
        children: results.map((item) {
          return InkWell(
            onTap: () {
              // Navigate to UserDetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(userData: item,),
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
        }).toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestions = history.where((item) {
      String name = item['name']?.toLowerCase() ?? '';
      String loanNo = item['loan_no']?.toLowerCase() ?? '';
      String id = item['id']?.toString().toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) ||
          loanNo.contains(query.toLowerCase()) ||
          id.contains(query.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ListView(
        children: suggestions.map((item) {
          return InkWell(
            onTap: () {
              // Navigate to UserDetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(userData: item,),
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
        }).toList(),
      ),
    );
  }


  @override
  TextInputType get keyboardType => TextInputType.text;

  @override
  String? get searchFieldLabel => 'Search by name or loan number';

  @override
  TextStyle? get searchFieldStyle => TextStyle(color: Colors.black, fontSize: 16);

  @override
  InputDecorationTheme? get inputDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[600]),
  );
}
