import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient{
  final String baseUrl;
  String? bearerToken;

  ApiClient._privateConstructor(this.baseUrl);

  static final ApiClient _instance = ApiClient._privateConstructor('https://localhost:7057/api');

  factory ApiClient(){
    return _instance;
  }

  Future<bool> authenticate(String userName, String password) async {
    final url = Uri.parse('$baseUrl/Account/login');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'username':userName,
        'password':password
      })
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      bearerToken = data['token'];
      //bearerToken = bearerToken!.substring(1, bearerToken!.length - 1);
      return true;
    }

    else{
      return false;
      //throw Exception('Failed to Authenticate');
    }
  }

  Future<List<String>> getCardIds() async {
    final url = Uri.parse('$baseUrl/CreditCard');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-type': 'application/json',
      },
    );
    if(response.statusCode == 200)
    {
      var result = json.decode(response.body); 
      List<String> cardNames = [];
      for(var id in result)
      {
        cardNames.add(await getCardName(id));
      }
      return cardNames;
    }
    else
    {
      return [];
    }
  }

  Future<String> getCardName(String cardId) async {

    final url = Uri.parse('$baseUrl/CreditCard/cardName?cardId=$cardId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-type': 'application/json',
      },
    );
    if(response.statusCode == 200)
    {
      return response.body.toString();
    }
    else
    {
      throw Exception();
    }
  }

  Future<List<String>> getCategoryNames() async {
    final url = Uri.parse('$baseUrl/Category/categoryNames');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-type': 'application/json',
      },
    );

    if(response.statusCode == 200)
    {
      var result = json.decode(response.body); 
      List<String> catNames = [];
      for(var name in result){
        catNames.add(name);
      }

      return catNames;
    }
    else
    {
      throw Exception();
    }
  }

  Future<List<String>> getRecipientNames() async {
    final url = Uri.parse('$baseUrl/Recipient/recipientNames');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-type':'application/json',
      }
    );

    if(response.statusCode == 200)
    {
      var result = json.decode(response.body);
      List<String> recipientNames = [];
      for(var name in result){
        recipientNames.add(name);
      }

      return recipientNames;
    }
    else
    {
      throw Exception();
    }
  }

  Future<bool> addNewCardTransaction(String cardName, String categoryName, String recipientName, double amount, int paymentMode, int transactionMode, double rewardPoints, String transactionDate, String generalComments) async {
    final url = Uri.parse('$baseUrl/Transaction?cardName=$cardName');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'categoryName' : categoryName,
        'recipientName' : recipientName,
        'amount' : amount,
        'paymentMode' : paymentMode,
        'transactionMode' : transactionMode,
        'rewardPoints' : rewardPoints,
        'date' : transactionDate,
        'generalComments' : generalComments
      })
    );

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
  

}