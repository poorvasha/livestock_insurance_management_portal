import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DropDown extends StatefulWidget {
  final String? value;
  final Widget? hint;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;

  const DropDown(
      {super.key,
      required this.value,
      required this.hint,
      required this.items,
      this.onChanged});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: widget.hint,
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: widget.value,
            items: widget.items,
            onChanged: widget.onChanged,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
