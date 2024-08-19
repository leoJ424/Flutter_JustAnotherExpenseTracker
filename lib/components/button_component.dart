import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;

  const ButtonComponent({
    super.key, 
    required this.buttonText,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(buttonText),
        ),
      ),
    );
  }
}