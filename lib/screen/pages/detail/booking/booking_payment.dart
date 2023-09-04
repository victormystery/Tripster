import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../widget/success.dart';
import '../../../../widget/widget.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  PaymentMethod? selectedPaymentMethod;
  List<PaymentMethod> paymentMethods = [];

  @override
  void initState() {
    super.initState();
    loadPaymentMethods(); // Load saved payment methods on initialization
  }

  Future<void> loadPaymentMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? paymentMethodStrings =
        prefs.getStringList('paymentMethods');

    if (paymentMethodStrings != null) {
      setState(() {
        paymentMethods = paymentMethodStrings
            .map((string) => PaymentMethod.fromJson(string))
            .toList();
      });
    }
  }

  Future<void> savePaymentMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final paymentMethodStrings =
        paymentMethods.map((method) => method.toJson()).toList();
    prefs.setStringList('paymentMethods', paymentMethodStrings);
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });
  }

  void deletePaymentMethod(int index) {
    setState(() {
      if (selectedPaymentMethod == paymentMethods[index]) {
        selectedPaymentMethod = null;
      }
      paymentMethods.removeAt(index);
      savePaymentMethods(); // Save updated payment methods after deletion
    });
  }

  void addPaymentMethod(PaymentMethod newMethod) {
    setState(() {
      paymentMethods.add(newMethod);
      savePaymentMethods(); // Save updated payment methods after addition
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(paymentMethods[index].cardNumber!),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      deletePaymentMethod(index);
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectPaymentMethod(paymentMethods[index]);
                      },
                      child: PaymentMethodCard(
                        paymentMethod: paymentMethods[index],
                        isSelected:
                            selectedPaymentMethod == paymentMethods[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showAddPaymentMethodBottomSheet(context);
                  },
                  child: Text('Add Payment Method'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    if (selectedPaymentMethod != null) {
                      nextScreenReplace(context, PaymentSuccess());
                      print(
                          'Payment confirmed using ${selectedPaymentMethod!.type}');
                    } else {
                      showSnackbar(context, Colors.red,
                          'Please select a payment method.');
                    }
                  },
                  child: Text('Confirm Payment'),
                ),
                SizedBox(width: 8.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddPaymentMethodBottomSheet(BuildContext context) {
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController cardholderNameController =
        TextEditingController();
    final TextEditingController expirationDateController =
        TextEditingController();
    final TextEditingController cvvController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Payment Method',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: cardNumberController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  maxLength: 19, // Including the hyphens
                  decoration: InputDecoration(labelText: 'Card Number'),
                ),
                TextField(
                  controller: cardholderNameController,
                  decoration: InputDecoration(labelText: 'Cardholder Name'),
                ),
                TextField(
                  controller: expirationDateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ExpirationDateFormatter(),
                  ],
                  maxLength: 5, // Including the '/'
                  decoration:
                      InputDecoration(labelText: 'Expiration Date (MM/YY)'),
                ),
                TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'CVV'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String cardNumber =
                        cardNumberController.text.replaceAll("-", "");
                    if (cardNumber.isNotEmpty) {
                      String cardholderName = cardholderNameController.text;
                      String expirationDate = expirationDateController.text;
                      String cvv = cvvController.text;

                      addPaymentMethod(PaymentMethod(
                        type: 'Credit Card',
                        cardNumber: cardNumber,
                        cardholderName: cardholderName,
                        expirationDate: expirationDate,
                        cvv: cvv,
                      ));
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                  child: Text('Add Payment Method'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentMethod {
  String? type;
  String? cardNumber;
  String? cardholderName;
  String? expirationDate;
  String? cvv;

  PaymentMethod({
    required this.type,
    required this.cardNumber,
    this.cardholderName = '',
    this.expirationDate = '',
    this.cvv = '',
  });

  PaymentMethod.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    type = map['type'];
    cardNumber = map['cardNumber'];
    cardholderName = map['cardholderName'];
    expirationDate = map['expirationDate'];
    cvv = map['cvv'];
  }

  String toJson() {
    final Map<String, dynamic> map = {
      'type': type,
      'cardNumber': cardNumber,
      'cardholderName': cardholderName,
      'expirationDate': expirationDate,
      'cvv': cvv,
    };
    return jsonEncode(map);
  }
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;

  PaymentMethodCard({
    required this.paymentMethod,
    required this.isSelected,
  });

  Map<String, IconData> cardIcons = {
    '4': FontAwesomeIcons.ccVisa,
    '5': FontAwesomeIcons.ccMastercard,
    '37': FontAwesomeIcons.ccAmex,
  };

  @override
  Widget build(BuildContext context) {
    String cardCompany = detectCardCompany(paymentMethod.cardNumber!);

    return Card(
      color: isSelected ? Colors.blue[100] : null,
      child: ListTile(
        title: Text(paymentMethod.type!),
        subtitle: Text(paymentMethod.cardNumber!),
        trailing: cardCompany.isNotEmpty
            ? Icon(
                cardIcons[cardCompany] ??
                    Icons.credit_card, // Use the icon or default to credit_card
                size: 24,
                color: Colors.blue, // Customize the color if needed
              )
            : null,
      ),
    );
  }

  String detectCardCompany(String cardNumber) {
    String cardNumberWithoutSpaces = cardNumber.replaceAll(RegExp(r'\s+'), '');
    for (String prefix in cardIcons.keys) {
      if (cardNumberWithoutSpaces.startsWith(prefix)) {
        return prefix;
      }
    }
    return '';
  }

  String getCardCompanyImage(String cardCompany) {
    return 'images/${cardCompany.toLowerCase()}.png'; // Replace with actual image paths
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length <= 16) {
      String formattedText = '';
      for (int i = 0; i < newText.length; i++) {
        if (i > 0 && i % 4 == 0) {
          formattedText += '-';
        }
        formattedText += newText[i];
      }

      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      return oldValue;
    }
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length <= 4) {
      String formattedText = '';
      for (int i = 0; i < newText.length; i++) {
        if (i == 2 && newText[i] != '/') {
          formattedText += '/';
        }
        formattedText += newText[i];
      }

      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      return oldValue;
    }
  }
}

void main() {
  runApp(MaterialApp(home: PaymentMethodsScreen()));
}
