// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2/components/text_field_component.dart';
import 'package:project_2/pages/logged_in_page.dart';

import '../api/api_client.dart';
import '../components/button_component.dart';
import '../components/datepicker_component.dart';
import '../components/dropdown_field_map_string_int_component.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({super.key});

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  final TextEditingController creditCardNumberController = TextEditingController();
  final TextEditingController creditCardNameController = TextEditingController();
  final TextEditingController creditCardOwnerController = TextEditingController();
  final TextEditingController creditCardBankNameController = TextEditingController();
  final TextEditingController creditCardExpiryDateController = TextEditingController();
  final TextEditingController creditCardCVCController = TextEditingController();
  final TextEditingController creditCardLimitController = TextEditingController();
  final TextEditingController creditCardStatementGenDayController = TextEditingController();
  final TextEditingController creditCardPaymentDueController = TextEditingController();

  //Params for the api
  String first4Digits = "";
  String second4Digits = "";
  String third4Digits = "";
  String last4Digits = "";
  int? selectedNetwork;

  void splitCardNumber()
  {
    first4Digits = "";
    second4Digits = "";
    third4Digits = "";
    last4Digits = "";

    for(int i = 0; i < 3; ++i) {
      first4Digits += creditCardNumberController.text[i] + ' ';
    }
    first4Digits += creditCardNumberController.text[3];

    for(int i = 4; i < 7; ++i) {
      second4Digits += creditCardNumberController.text[i] + ' ';
    }
    second4Digits += creditCardNumberController.text[7];

    for(int i = 8; i < 11; ++i) {
      third4Digits += creditCardNumberController.text[i] + ' ';
    }
    third4Digits += creditCardNumberController.text[11];

    for(int i = 12; i < 15; ++i) {
      last4Digits += creditCardNumberController.text[i] + ' ';
    }
    last4Digits += creditCardNumberController.text[15];
  }

  Future<Map<String, int>> mapNetworks() async {
    Map<String,int> networksMap = {'VISA' : 0, 'MasterCard' : 1, 'American Express' : 2, 'Discover' : 3};
    return networksMap;
  }

  void addCreditCard(BuildContext context) async {
    final apiClient = ApiClient();
    splitCardNumber();

    if(first4Digits.length == 7 && second4Digits.length == 7 && third4Digits.length == 7 && last4Digits.length == 7 && selectedNetwork != null)
    {
      var status = await apiClient.addNewCreditCard(first4Digits, second4Digits, third4Digits, last4Digits, creditCardNameController.text, creditCardOwnerController.text, selectedNetwork!, creditCardBankNameController.text, creditCardExpiryDateController.text, int.parse(creditCardCVCController.text), double.parse(creditCardLimitController.text), int.parse(creditCardStatementGenDayController.text), int.parse(creditCardPaymentDueController.text));

      if(status == true)
      {
        debugPrint("Added Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoggedIn()),
        );
      }
      else{
        debugPrint("Failed");
        first4Digits = "";
      
      }
    }
  }

  void clearFields() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoggedIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a credit card"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          
          children: [
            //Card Number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter Card Number')),
                Expanded(child: TextField(
                  controller: creditCardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 16,
                ))
              ],
            ),

            SizedBox(height: 10),

            //Card name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter a name for the Card')),
                Expanded(
                  child: TextFieldComponent(
                    hintText: 'Card Name',
                    controller: creditCardNameController,))
              ],
            ),

            //CardHolder Name
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter the name of the CardHolder')),
                Expanded(
                  child: TextFieldComponent(
                    hintText: 'Name on card',
                    controller: creditCardOwnerController,))
              ],
            ),

            //Network
            SizedBox(height: 20,),
            DropDownComponent_MapStringInt(
              mainText: "Select Network", 
              hintText: "Card Network", 
              selectedValue: selectedNetwork, 
              getData: mapNetworks, 
              onChanged: (value) {
                setState(() {
                  selectedNetwork = value;
                });
              }
            ),

            //Bank Name

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter card issuing bank')),
                Expanded(
                  child: TextFieldComponent(
                    hintText: 'Bank Name',
                    controller: creditCardBankNameController,))
              ],
            ),

            //Exp Date
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Enter card expiry date')
                  ),
                  Expanded(
                    child: DatePickerComponent(
                      dateController: creditCardExpiryDateController,
                    )
                  )
                ],
              ),
            ),

            //CVC
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter Card CVC/CVV')),
                Expanded(child: TextField(
                  controller: creditCardCVCController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                ))
              ],
            ),

            //Credit Limit

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter Credit Limit')),
                Expanded(
                  child: TextFieldComponent(
                    hintText: 'Credit Limit',
                    controller: creditCardLimitController,))
              ],
            ),

            //Statement Generation Day
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter Statement Generation Day')),
                Expanded(child: TextField(
                  controller: creditCardStatementGenDayController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 2,
                ))
              ],
            ),

            //Payment Due from statement day
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Enter number of days before statement is due')),
                Expanded(child: TextField(
                  controller: creditCardPaymentDueController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 2,
                ))
              ],
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonComponent(buttonText: "Add Credit Card", onTap: () => addCreditCard(context))
                ),
                Expanded(
                  child: ButtonComponent(buttonText: "Clear Fields", onTap: () => clearFields())
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}