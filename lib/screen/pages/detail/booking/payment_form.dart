import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentForm extends StatefulWidget {
  final Function(String, String) onPaymentCreated;
  final Map<String, String> cardCompanyIcons;

  PaymentForm(
      {required this.onPaymentCreated,
      required this.cardCompanyIcons,
      required String initialPaymentType});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController _paymentController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  bool _isCardPayment = true;
  String _cardCompany = '';

  final _key = GlobalKey<FormState>();

  void _detectCardCompany(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      _cardCompany = 'Visa';
    } else if (cardNumber.startsWith('5')) {
      _cardCompany = 'MasterCard';
    } else if (cardNumber.startsWith('37') || cardNumber.startsWith('34')) {
      _cardCompany = 'American Express';
    } else if (cardNumber.startsWith('6')) {
      _cardCompany = 'Discover';
    } else {
      _cardCompany = 'Paypal';
    }
  }

  @override
  void dispose() {
    _paymentController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Payment System',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: _isCardPayment,
                onChanged: (value) {
                  setState(() {
                    _isCardPayment = value!;
                  });
                },
              ),
              Text('Card Payment'),
              Radio(
                value: false,
                groupValue: _isCardPayment,
                onChanged: (value) {
                  setState(() {
                    _isCardPayment = value!;
                  });
                },
              ),
              Text('PayPal'),
            ],
          ),
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: _paymentController,
                  decoration: InputDecoration(
                    labelText: _isCardPayment ? 'Card Number' : 'PayPal Email',
                  ),
                  onChanged: (value) {
                    if (_isCardPayment) {
                      _detectCardCompany(value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _isCardPayment
                          ? 'Please enter a card number'
                          : 'Please enter a PayPal email';
                    }
                    if (_isCardPayment) {
                      // Add card number validation logic here
                      if (value.length < 12 || value.length > 19) {
                        return 'Invalid card number';
                      }
                    } else {
                      // Add PayPal email validation logic here
                      if (!value.contains('@')) {
                        return 'Invalid PayPal email';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                if (_isCardPayment)
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CVV';
                      }
                      // Add CVV validation logic here
                      if (value.length != 3 && value.length != 4) {
                        return 'CVV must be 3 or 4 digits';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      String paymentType = _isCardPayment
                          ? 'Credit Card'
                          : (_paymentController.text.contains('@')
                              ? 'PayPal'
                              : 'Crypto');
                      Map<String, dynamic> paymentInfo = {
                        'address': _paymentController.text,
                        'amount': _isCardPayment
                            ? 0
                            : 100, // Amount for crypto payments
                      };

                      widget.onPaymentCreated(paymentInfo.toString(),
                          paymentType); // Convert map to string and pass as a single argument
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                  child: Text('Add Payment System'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main(context) {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Payment Form Modal Bottom Sheet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showPaymentFormModal(context);
          },
          child: Text('Show Payment Form'),
        ),
      ),
    ),
  ));
}

void _showPaymentFormModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return PaymentForm(
        onPaymentCreated: (paymentInfo, cardCompany) {
          // Handle payment creation logic here
          // For simulation purposes, just print payment info
          print('Payment Info: $paymentInfo');
          print('Card Company: $cardCompany');
          Navigator.pop(context); // Close the bottom sheet after payment
        },
        cardCompanyIcons: {
          'Visa': 'https://example.com/visa_icon.png',
          'MasterCard': 'https://img.icons8.com/office/16/mastercard.png',
          'American Express': 'https://example.com/amex_icon.png',
          'Discover': 'https://example.com/discover_icon.png',
          'Paypal':
              'https://commons.wikimedia.org/wiki/File:Paypal_2014_logo.png',
        },
        initialPaymentType: '',
      );
    },
  );
}
