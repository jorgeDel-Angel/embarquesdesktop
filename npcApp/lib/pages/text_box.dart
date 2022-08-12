import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBox extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final bool enable;
  TextBox(
    this._controller,
    this._label, this.enable, 
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: this._controller,
        decoration: InputDecoration(
          enabled: this.enable,
            filled: true,
            labelText: this._label,  
            suffix: GestureDetector(
              child: const Icon(Icons.close),
              onTap: () {
                _controller.clear();
              },
            )
            ),
  

      ),
    );
  }
}
