import 'package:flutter/material.dart';
import 'package:flutter_assingment/loginPage.dart';

class Userprofilepage extends StatefulWidget {
  final Map<String, dynamic> data;

  const Userprofilepage({Key? key, required this.data}) : super(key: key);

  @override
  State<Userprofilepage> createState() => _UserprofilepageState();
}

class _UserprofilepageState extends State<Userprofilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(color: Colors.white),
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                // Navigate to the LoginPage and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false, // Remove all previous routes
                );
              } catch (e) {
                // Handle any errors if necessary
                print('Error during logout: $e');
              }
            },
            icon: Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("Personal Information"),
              _buildProfileDetail("Name", "${widget.data['first_name']} ${widget.data['last_name']}", Icons.person),
              _buildProfileDetail("Email", widget.data['email'], Icons.email),
              _buildProfileDetail("Phone", widget.data['phone_number'], Icons.phone),
              _buildProfileDetail("Date of Birth", widget.data['date_of_birth'], Icons.calendar_today),
              _buildProfileDetail("Gender", widget.data['gender'], Icons.accessibility),
              Divider(color: Colors.grey.withOpacity(0.3)),

              _buildSectionHeader("Company Details"),
              _buildProfileDetail("Company Name", widget.data['company_name'], Icons.business),
              _buildProfileDetail("Position Title", widget.data['position_title'], Icons.account_circle),
              _buildProfileDetail("Start Date", widget.data['start_date'], Icons.date_range),
              _buildProfileDetail("Annual Revenue", "₹${widget.data['annual_revenue']}", Icons.monetization_on),
              Divider(color: Colors.grey.withOpacity(0.3)),

              _buildSectionHeader("Address & Location"),
              _buildProfileDetail("Street Address", widget.data['street_address'], Icons.location_on),
              _buildProfileDetail("City", widget.data['city'], Icons.location_city),
              _buildProfileDetail("State", widget.data['state'], Icons.map),
              _buildProfileDetail("Postal Code", widget.data['postal_code'], Icons.location_pin),
              _buildProfileDetail("Country", widget.data['country'], Icons.flag),
              Divider(color: Colors.grey.withOpacity(0.3)),

              _buildSectionHeader("Banking Details"),
              _buildProfileDetail("Bank Name", widget.data['bank_name'], Icons.account_balance),
              _buildProfileDetail("Account Number", widget.data['account_number'], Icons.credit_card),
              _buildProfileDetail("Account Type", widget.data['account_type'], Icons.card_membership),
              _buildProfileDetail("IFSC Code", widget.data['ifsc_code'], Icons.code),
              Divider(color: Colors.grey.withOpacity(0.3)),

              _buildSectionHeader("Contact Information"),
              _buildProfileDetail("Address Type", widget.data['address_type'], Icons.home),
              _buildProfileDetail("Contact Type", widget.data['contact_type'], Icons.contact_phone),
              _buildProfileDetail("Contact Value", widget.data['contact_value'], Icons.contact_mail),
              Divider(color: Colors.grey.withOpacity(0.3)),

              _buildSectionHeader("Other Details"),
              _buildProfileDetail("Active Status", widget.data['Active_status'] == "1" ? "Active" : "Inactive", Icons.check_circle),
              _buildProfileDetail("Role", widget.data['Role'], Icons.supervisor_account),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
            size: 28,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.teal,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
