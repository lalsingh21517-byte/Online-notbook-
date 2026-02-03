import 'dart:convert';
import 'dart:io';

void main() {
  // Aapka JSON data
  String jsonString = '''
  {
    "loans": [
      {"bank": "Unity Bank", "emi": 4140, "next_date": "2025-10-15"},
      {"bank": "SATIN", "emi": 1730, "next_date": "2025-10-01"}
    ]
  }
  ''';

  var data = jsonDecode(jsonString);
  DateTime today = DateTime.now();

  for (var loan in data['loans']) {
    DateTime emiDate = DateTime.parse(loan['next_date']);
    int daysLeft = emiDate.difference(today).inDays;

    print("Bank: ${loan['bank']} | Days Left: $daysLeft");

    if (daysLeft <= 5 && daysLeft >= 0) {
      print("📢 Notification: ${loan['bank']} ki kist ₹${loan['emi']} bharne ka samay hai!");
    }
  }
}
