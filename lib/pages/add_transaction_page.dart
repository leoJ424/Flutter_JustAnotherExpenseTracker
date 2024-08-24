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
  var selectedCategoryName;
  var selectedRecipientName;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Text("Select the card"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: FutureBuilder<List<String>> (
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
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Text('Select Category')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: FutureBuilder<List<String>> (
                      future: apiClient.getCategoryNames(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return DropdownButton(
                            hint: Text('Select Category'),
                            value: selectedCategoryName,
                  
                            items: snapshot.data!.map( (e){
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                  
                            onChanged: (value){
                              selectedCategoryName = value;
                              setState(() {
                                
                              });
                            }
                          );
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),           
              ],
            ),
            SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Text('Select Recipient')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: FutureBuilder<List<String>> (
                      future: apiClient.getRecipientNames(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return DropdownButton(
                            hint: Text('Select Recipient'),
                            value: selectedRecipientName,
                  
                            items: snapshot.data!.map( (e){
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                  
                            onChanged: (value){
                              selectedRecipientName = value;
                              setState(() {
                                
                              });
                            }
                          );
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),           
              ],
            ),
          ],
        ),
      ),
    );
  }
}