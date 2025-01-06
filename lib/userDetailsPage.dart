import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailsPage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(color: Colors.white),
        title: Text(
          "User Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    "Field",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Value",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                ),
              ],
              rows: [
                _buildRow("ID", userData['id']),
                _buildRow("Name", userData['name']),
                _buildRow("Loan No", userData['loan_no']),
                _buildRow("Amount", "₹${userData['collection_amount'] ?? 'N/A'}"),
                _buildRow("Status", userData['status'], isStatus: true),
                _buildRow("Bank Utility Code", userData['bank_utility_code']),
                _buildRow("Txn Ref No", userData['txn_reference_number']),
                _buildRow("Status Description", userData['status_description']),
                _buildRow("UMRN", userData['umrn']),
                _buildRow("Presentation Date", userData['presentation_date']),
                _buildRow("Submission Date", userData['submission_date']),
                _buildRow("Mobile No", userData['mobile_no']),
                _buildRow("Email", userData['email']),
                _buildRow("Auth Type", userData['auth_type']),
                _buildRow("Payment Status", userData['pymt_status']),
                _buildRow("Created By", userData['created_by']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildRow(String field, dynamic value, {bool isStatus = false}) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            field,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.teal[600],
            ),
          ),
        ),
        DataCell(
            Text(
              value ?? 'N/A',
              style: TextStyle(
                fontWeight: isStatus
                    ? (value == "Success"
                    ? FontWeight.bold // Bold for Success
                    : value == "Rejected"
                    ? FontWeight.w600 // Semi-bold for Rejected
                    : FontWeight.w400) // Regular for other cases
                    : FontWeight.w400,
                color: isStatus
                    ? (value == "Success"
                    ? Colors.green
                    : value == "Rejected"
                    ? Colors.red
                    : Colors.black87)
                    : Colors.black87,
              ),
            )
        ),
      ],
    );
  }
}
