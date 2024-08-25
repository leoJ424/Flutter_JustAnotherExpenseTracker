import 'package:flutter/material.dart';
import 'package:project_2/components/dropdown_field_component.dart';
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
  final TextEditingController amountController = TextEditingController();
  String? selectedCardName;
  String? selectedCategoryName;
  String? selectedRecipientName;

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
            )
          ],
        ),
      ),
    );
  }
}