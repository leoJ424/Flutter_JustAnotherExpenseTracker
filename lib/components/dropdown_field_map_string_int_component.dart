import 'package:flutter/material.dart';

class DropDownComponent_MapStringInt extends StatefulWidget {
  final String mainText;
  final String hintText;
  final int? selectedValue;
  final Future<Map<String, int>> Function() getData;
  final ValueChanged<int?> onChanged;

  const DropDownComponent_MapStringInt({
    super.key,
    required this.mainText,
    required this.hintText,
    required this.selectedValue,
    required this.getData,
    required this.onChanged,
  });

  @override
  State<DropDownComponent_MapStringInt> createState() => _DropDownComponent_MapStringIntState();
}

class _DropDownComponent_MapStringIntState extends State<DropDownComponent_MapStringInt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(250, 0, 250, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(widget.mainText),
          ),
          Expanded(
            child: FutureBuilder<Map<String, int>> (
              future: widget.getData(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return DropdownButton(
                    hint: Text(widget.hintText),
                    value: widget.selectedValue,

                    items: snapshot.data!.entries.map((e){
                      return DropdownMenuItem(
                        value: e.value, 
                        child: Text(e.key),
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
      ),
    );
  }
}