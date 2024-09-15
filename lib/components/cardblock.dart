import 'package:flutter/material.dart';
import 'package:micetalks/provider/data.dart';

class CardBlock extends StatelessWidget {
  final CardModel card;

  const CardBlock({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.album),
            title: Text(card.mfname),
            subtitle: Column(
              children: [
                Row(
                  children: [Text("${card.units}"), const Text(" Units")],
                ),
              ],
            ),
          ),
          ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Spent'), Text('Rs ${card.spent}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Current Valuation:'),
                    Text('Rs ${card.currentValuation}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Profit'), Text('Rs ${card.profit}')],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
