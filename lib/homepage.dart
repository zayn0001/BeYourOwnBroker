import 'package:flutter/material.dart';
import 'package:micetalks/components/cardblock.dart';
import 'package:micetalks/provider/data.dart';
import 'package:micetalks/services/crud_service.dart';
import 'package:provider/provider.dart';

import 'package:micetalks/components/additionblock.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var crudservice = CrudService();
  @override
  void initState() {
    super.initState();
    Provider.of<AllCards>(context, listen: false).fetchCardsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AllCards>(
        builder: (context, allCards, _) {
          if (allCards.cards.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: allCards.cards.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InputBox(
                      allcards: allCards.cards,
                      onDelete: (form) =>
                          crudservice.deleteInvestment(context, form),
                      onWithdraw: (form) =>
                          crudservice.withdrawInvestment(context, form),
                      onAdd: (form) =>
                          crudservice.incrementInvestment(context, form),
                      onInvest: (form) =>
                          crudservice.createInvestment(context, form),
                    );
                  }
                  if (index == allCards.cards.length + 1) {
                    return const SizedBox(height: 80);
                  }
                  CardModel card = allCards.cards[index - 1];
                  return CardBlock(card: card);
                },
              ),
            ),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AllCards>(context, listen: false)
              .fetchCardsFromFirestore();
        },
        tooltip: 'Fetch Cards',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
