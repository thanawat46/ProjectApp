import 'package:appproject/src/page/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Caldividendpage extends StatefulWidget {
  const Caldividendpage({super.key});

  @override
  State<Caldividendpage> createState() => _CaldividendpageState();
}

class _CaldividendpageState extends State<Caldividendpage> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppRoute.home);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, AppRoute.savings);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, AppRoute.loan);
    }
  }

  final TextEditingController _amountController = TextEditingController();
  double _memberAmount = 0.0;
  double _directorAmount = 0.0;
  double _utilityAmount = 0.0;
  double _contributionAmount = 0.0;
  double _insuranceAmount = 0.0;
  double _totalAmount = 0.0;
  double _paidMemberAmount = 0.0;

  void _calculateAmounts() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    setState(() {
      _memberAmount = amount * 0.7;
      _directorAmount = amount * 0.15;
      _utilityAmount = amount * 0.1;
      _contributionAmount = amount * 0.3;
      _insuranceAmount = amount * 0.23;
      _totalAmount = _memberAmount + _directorAmount + _utilityAmount + _contributionAmount + _insuranceAmount;;
      _paidMemberAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("คำนวณเงินปันผล"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "จำนวนเงิน",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _calculateAmounts(); // Recalculate amounts every time input changes
                },
              ),
              SizedBox(height: 30),
              _buildRow("สมาชิก", _memberAmount),
              SizedBox(height: 10),
              _buildRow("กรรมการ", _directorAmount),
              SizedBox(height: 10),
              _buildRow("สาธารณูปโภค", _utilityAmount),
              SizedBox(height: 10),
              _buildRow("สมทบทุน", _contributionAmount),
              SizedBox(height: 10),
              _buildRow("ประกันเสียง", _insuranceAmount),
              SizedBox(height: 10),
              _buildRow("รวม", _totalAmount),
              SizedBox(height: 10),
              _buildRow("จ่ายสมาชิก", _paidMemberAmount),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildMenuBar(),
    );
  }

  Widget _buildRow(String label, double amount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: amount.toStringAsFixed(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuBar() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GNav(
          activeColor: Colors.white,
          tabBackgroundColor: Colors.green.shade300,
          gap: 10,
          padding: EdgeInsets.all(15),
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'หน้าหลัก',
            ),
            GButton(
              icon: Icons.savings,
              text: 'เงินฝาก',
            ),
            GButton(
              icon: Icons.account_balance,
              text: 'เงินกู้',
            ),
          ],
        ),
      ),
    );
  }
}
