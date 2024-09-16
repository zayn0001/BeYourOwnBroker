import 'package:flutter/material.dart';
import 'package:micetalks/components/addform.dart';
import 'package:micetalks/components/deleteform.dart';
import 'package:micetalks/components/investform.dart';
import 'package:micetalks/components/withdrawform.dart';
import 'package:micetalks/provider/data.dart';

class InputBox extends StatefulWidget {
  final Function(Map<String, dynamic>) onInvest, onAdd, onWithdraw, onDelete;
  final List<CardModel> allcards;

  const InputBox(
      {super.key,
      required this.onInvest,
      required this.onDelete,
      required this.onWithdraw,
      required this.onAdd,
      required this.allcards});

  @override
  State<InputBox> createState() => _InputBoxState();
}

enum Option { add, withdraw, delete, invest }

class _InputBoxState extends State<InputBox> {
  Option option = Option.add;
  Iterable<String> get allmfnames => super.widget.allcards.map((e) => e.mfname);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
              title: SegmentedButton<Option>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<Option>>[
              ButtonSegment<Option>(
                value: Option.invest,
                label: Text('Invest'),
              ),
              ButtonSegment<Option>(
                value: Option.add,
                label: Text('Add'),
              ),
              ButtonSegment<Option>(
                value: Option.withdraw,
                label: Text(
                  'Withdraw',
                  softWrap: false,
                ),
              ),
              ButtonSegment<Option>(
                value: Option.delete,
                label: Text('Delete'),
              ),
            ],
            selected: <Option>{option},
            onSelectionChanged: (Set<Option> newSelection) {
              setState(() {
                option = newSelection.first;
              });
            },
          )),
          ListTile(
            title: () {
              switch (option) {
                case Option.invest:
                  return InvestmentForm(onInvest: widget.onInvest);
                case Option.add:
                  return AddForm(onAdd: widget.onAdd, allmfnames: allmfnames);
                case Option.withdraw:
                  return WithdrawForm(
                      onWithdraw: widget.onWithdraw, allmfnames: allmfnames);
                case Option.delete:
                  return DeleteForm(
                      onDelete: widget.onDelete, allmfnames: allmfnames);
                default:
                  return const SizedBox.shrink();
              }
            }(),
          ),
        ],
      ),
    );
  }
}
