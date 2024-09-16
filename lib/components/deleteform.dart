import 'package:flutter/material.dart';

class DeleteForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onDelete;
  final Iterable<String> allmfnames;
  final Map<String, TextEditingController> _formControllers = {
    "mfname": TextEditingController(),
  };
  DeleteForm({super.key, required this.onDelete, required this.allmfnames});

  @override
  Widget build(BuildContext context) {
    _formControllers["mfname"]?.text = allmfnames.first;
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField(
              value: _formControllers["mfname"]?.text,
              borderRadius: BorderRadius.circular(12),
              menuMaxHeight: 200,
              elevation: -20,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                labelText: "Mutual Fund",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              isExpanded: true,
              isDense: true,
              items: allmfnames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (selection) {
                _formControllers["mfname"]?.text = selection!;
              }),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () {
                  final form = _formControllers.map((key, value) =>
                      MapEntry(key, double.tryParse(value.text) ?? value.text));
                  onDelete(form);
                },
                child: const Text("Withdraw"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
