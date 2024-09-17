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
                  if (index == allCards.cards.length + 2) {
                    return const SizedBox(height: 80);
                  }
                  if (index == 1) {
                    String totalSpent = AllCards()
                        .convertToIndianCurrencyFormat(allCards.cards.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                double.parse(item.spent.replaceAll(",", ""))));

                    String totalValuation = AllCards()
                        .convertToIndianCurrencyFormat(allCards.cards.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                double.parse(item.currentValuation
                                    .replaceAll(",", ""))));

                    String totalProfit = AllCards()
                        .convertToIndianCurrencyFormat(allCards.cards.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                double.parse(item.profit.replaceAll(",", ""))));

                    return Card(
                      color: const Color.fromARGB(255, 191, 204, 226),
                      margin: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Spent'),
                                  Text('Rs $totalSpent')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Current Total Valuation'),
                                  Text('Rs $totalValuation')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Profit'),
                                  Text('Rs $totalProfit')
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  }

                  CardModel card = allCards.cards[index - 2];
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
