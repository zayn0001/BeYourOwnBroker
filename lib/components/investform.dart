import 'package:flutter/material.dart';

class InvestmentForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onInvest;
  final Map<String, TextEditingController> _formControllers = {
    "mfname": TextEditingController(),
    "ticker": TextEditingController(),
    "units": TextEditingController(),
    "spent": TextEditingController()
  };
  InvestmentForm({
    super.key,
    required this.onInvest,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _formControllers["mfname"],
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                labelText: "Mutual Fund",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
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
                      MapEntry(key, double.tryParse(value.text) ?? value.text));
                  onInvest(form);
                },
                child: const Text("Invest"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
