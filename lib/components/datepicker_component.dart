import 'package:flutter/material.dart';

class DatePickerComponent extends StatefulWidget {
  final TextEditingController dateController;
  const DatePickerComponent({
    super.key,
    required this.dateController,
  });

  @override
  State<DatePickerComponent> createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal : 35),
      child: TextField(
        controller: widget.dateController,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.calendar_today),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
          )
        ),
        readOnly: true,
        onTap: () {
          _selectDate();
        },
      ),
    );
  }
  Future<void> _selectDate() async{
    DateTime? picked =  await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if(picked != null){
      setState(() {
        widget.dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
