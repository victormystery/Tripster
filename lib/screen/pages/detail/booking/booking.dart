import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripster/screen/pages/detail/booking/booking_payment.dart';
import '../../../../services/providers/helper.dart';
import '../../../../widget/widget.dart';

class BookingDetails extends StatefulWidget {
  final String tripPrice;

  BookingDetails({required this.tripPrice, Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  String userName = "";
  TextEditingController dateController = TextEditingController();
  TextEditingController numberOfParticipantsController =
      TextEditingController(text: '1');
  TextEditingController dateEndController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int numberOfParticipants = 1;
  int numberOfDays = 1;
  int additionalCostPerDay = 20000;
  int totalPrice = 0;
  bool useDefaultPrice = true;
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final value = await HelperFunctions.getUserNameSf();
    setState(() {
      userName = value!;
    });
  }

  void updateTotalPrice() {
    setState(() {
      if (pickedStartDate != null && pickedEndDate != null) {
        numberOfDays = pickedEndDate!.difference(pickedStartDate!).inDays + 1;
      }

      if (useDefaultPrice) {
        totalPrice = calculateTotalPrice(numberOfParticipants,
            int.parse(widget.tripPrice), numberOfDays, additionalCostPerDay);
      } else {
        totalPrice = calculateTotalPrice(numberOfParticipants,
            int.parse(widget.tripPrice), numberOfDays, additionalCostPerDay);
      }
    });
  }

  int calculateTotalPrice(int numberOfParticipants, int tripPrice,
      int numberOfDays, int additionalCostPerDay) {
    return (numberOfParticipants * tripPrice) +
        ((numberOfDays - 1) * additionalCostPerDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_outlined),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Detail Booking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF243757),
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Person Responsible',
                        style: TextStyle(
                          color: Color(0xFF15294B),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: userName,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Contact Info',
                        style: TextStyle(
                          color: Color(0xFF15294B),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          }
                          return "Enter Your Phone number";
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'No of Participant\'s',
                        style: TextStyle(
                          color: Color(0xFF15294B),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: numberOfParticipantsController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            numberOfParticipants = int.tryParse(value) ?? 1;
                            useDefaultPrice = numberOfParticipants == 1;
                            updateTotalPrice();
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Start Date',
                        style: TextStyle(
                          color: Color(0xFF15294B),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? newPickedStartDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2100),
                          );
                          if (newPickedStartDate != null) {
                            String formattedDate = DateFormat("yyyy/MM/dd")
                                .format(newPickedStartDate);
                            setState(() {
                              dateController.text = formattedDate.toString();
                              pickedStartDate = newPickedStartDate;
                              updateTotalPrice();
                            });
                          } else {
                            print("no Date selected");
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Select a Date ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'End Date',
                        style: TextStyle(
                          color: Color(0xFF15294B),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: dateEndController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 1),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? newPickedEndDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2100),
                          );
                          if (newPickedEndDate != null) {
                            String formattedDate = DateFormat("yyyy/MM/dd")
                                .format(newPickedEndDate);
                            setState(() {
                              dateEndController.text = formattedDate.toString();
                              pickedEndDate = newPickedEndDate;
                              updateTotalPrice();
                            });
                          } else {
                            print("no Date selected");
                          }
                        },
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      ' \₦${useDefaultPrice ? widget.tripPrice : totalPrice} ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '/Person',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                nextScreen(context, PaymentMethodsScreen());
                              } else {
                                showSnackbar(context, Colors.red, 'error');
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: Container(
                              width: 180,
                              height: 54,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF6B3FA0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Process Booking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
