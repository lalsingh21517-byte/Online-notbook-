import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(KistSambhaloApp());

class KistSambhaloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'किस्त संभालo',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: LoanListScreen(),
    );
  }
}

class LoanListScreen extends StatefulWidget {
  @override
  _LoanListScreenState createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  List loans = [];

  // GitHub se JSON load karne ka function
  Future<void> loadLoans() async {
    final url = 'https://raw.githubusercontent.com/lalsingh21517-byte/Online-notbook-/main/data/loans.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        loans = json.decode(response.body)['loans'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadLoans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('किस्त संभालो 📱')),
      body: loans.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: loans.length,
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(loans[i]['bank'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("EMI: ₹${loans[i]['emi']} | Date: ${loans[i]['next_emi_date']}"),
                    trailing: Icon(Icons.notifications_active, color: Colors.orange),
                  ),
                );
              },
            ),
    );
  }
}
