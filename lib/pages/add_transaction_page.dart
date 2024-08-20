import 'package:flutter/material.dart';

import '../api/api_client.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final apiClient = ApiClient();

  var selectedCardName;

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
            FutureBuilder<List<String>> (
              future: apiClient.getCardIds(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return DropdownButton(
                    hint: Text('Select Cards'),
                    value: selectedCardName,

                    items: snapshot.data!.map( (e){
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),

                    onChanged: (value){
                      selectedCardName = value;
                      setState(() {
                        
                      });
                    }
                  );
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}