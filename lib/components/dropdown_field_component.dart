import 'package:flutter/material.dart';

class DropDownComponent extends StatefulWidget {
  final String mainText;
  final String hintText;
  final String? selectedValue;
  final Future<List<String>> Function() getData;
  final ValueChanged<String?> onChanged;

  const DropDownComponent({
    super.key,
    required this.mainText,
    required this.hintText,
    required this.selectedValue,
    required this.getData,
    required this.onChanged,
  });

  @override
  State<DropDownComponent> createState() => _DropDownComponentState();
}

class _DropDownComponentState extends State<DropDownComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(widget.mainText),
        ),
        Expanded(
          child: FutureBuilder<List<String>> (
            future: widget.getData(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return DropdownButton(
                  hint: Text(widget.hintText),
                  value: widget.selectedValue,

                  items: snapshot.data!.map((e){
                    return DropdownMenuItem(
                      value: e, 
                      child: Text(e),
                    );
                  }).toList(),

                  onChanged: widget.onChanged,
                );
              }
              else{
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}