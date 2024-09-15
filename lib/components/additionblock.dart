import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const InputBox({super.key, required this.onSubmit});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _formControllers = {
    "mfname": TextEditingController(),
    "ticker": TextEditingController(),
    "units": TextEditingController(),
    "spent": TextEditingController()
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _formControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          const ListTile(
            titleTextStyle: TextStyle(fontSize: 22, color: Colors.black),
            title: Text("Add Investment"),
          ),
          ListTile(
            title: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _formControllers["mfname"],
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        labelText: "Mutual Fund",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _formControllers["ticker"],
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      labelText: "Ticker",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _formControllers["units"],
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      labelText: "Units",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _formControllers["spent"],
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    decoration: const InputDecoration(
                      prefixText: "Rs ",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      labelText: "Total Spent",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: () {
                          final form = _formControllers.map((key, value) =>
                              MapEntry(key,
                                  double.tryParse(value.text) ?? value.text));
                          widget.onSubmit(form);
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
