import 'package:flutter/material.dart';
import 'package:project_2/components/button_component.dart';
import 'package:project_2/components/datepicker_component.dart';
import 'package:project_2/components/dropdown_field_component.dart';
import 'package:project_2/components/dropdown_field_map_string_int_component.dart';
import 'package:project_2/components/text_field_component.dart';

import '../api/api_client.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final apiClient = ApiClient();

  //var selectedCardName;
  //var selectedCategoryName;
  //var selectedRecipientName;
  
  String? selectedCardName;
  String? selectedCategoryName;
  String? selectedRecipientName;
  int? selectedTransactionMode;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController rewardPointsController = TextEditingController();
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController generalCommentsController = TextEditingController();


  void addTransaction(BuildContext context) async {
    final apiClient = ApiClient();
    if(selectedCardName != null && selectedCategoryName != null && selectedRecipientName != null && selectedTransactionMode != null)
    {
      var status = await apiClient.addNewCardTransaction(selectedCardName!, selectedCategoryName!, selectedRecipientName!, double.parse(amountController.text), 1, selectedTransactionMode!, double.parse(rewardPointsController.text), datePickerController.text, generalCommentsController.text);

      if(status == true)
      {
        debugPrint("Added Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddTransaction()),
        );
      }
      else{
        debugPrint("Failed");
      }
    }
  }

  void clearFields() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddTransaction()),
    );
  }

  Future<Map<String, int>> mapTansactionModes() async {
    Map<String,int> transactionModesMap = {'Credit' : 0, 'Debit' : 1};
    return transactionModesMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a transaction"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropDownComponent(
              mainText: "Select the Card", 
              hintText: "Select Cards", 
              selectedValue: selectedCardName, 
              getData: apiClient.getCardIds, 
              onChanged: (value) {
                setState(() {
                  selectedCardName = value;
                });
              }
            ),

            DropDownComponent(
              mainText: "Select the Category", 
              hintText: "Select Catogory", 
              selectedValue: selectedCategoryName, 
              getData: apiClient.getCategoryNames, 
              onChanged: (value) {
                setState(() {
                  selectedCategoryName = value;
                });
              }
            ),

            DropDownComponent(
              mainText: "Select the Recipient", 
              hintText: "Select Recipient", 
              selectedValue: selectedRecipientName, 
              getData: apiClient.getRecipientNames, 
              onChanged: (value) {
                setState(() {
                  selectedRecipientName = value;
                });
              }
            ),

            //Payment Mode
            DropDownComponent_MapStringInt(
              mainText: "Select Transaction Type", 
              hintText: "Payment Type", 
              selectedValue: selectedTransactionMode, 
              getData: mapTansactionModes, 
              onChanged: (value) {
                setState(() {
                  selectedTransactionMode = value;
                });
              }
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Enter Transaction Amount')
                  ),

                  Expanded(
                    child: TextFieldComponent(
                      hintText: 'Amount',
                      controller: amountController,
                    ),
                  )
                ],
              ),
            ),

            //Transaction date picker
            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Enter Transaction Date')
                  ),
                  Expanded(
                    child: DatePickerComponent(
                      dateController: datePickerController,
                    )
                  )
                ],
              ),
            ),
            
            //Reward Points
            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Enter Reward Points')
                  ),

                  Expanded(
                    child: TextFieldComponent(
                      hintText: 'Reward Points',
                      controller: rewardPointsController,
                    ),
                  )
                ],
              ),
            ),

            //General Comments
            Padding(
              padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Add Comments')
                  ),

                  Expanded(
                    child: TextFieldComponent(
                      hintText: 'Comments',
                      controller: generalCommentsController,
                    ),
                  )
                ],
              ),
            ),

            //Add Transaction Button and Clear Fields Button

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonComponent(buttonText: "Add Transaction", onTap: () => addTransaction(context))
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