import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micetalks/components/cardblock.dart';
import 'package:micetalks/provider/data.dart';
import 'package:micetalks/provider/add.dart';
import 'package:provider/provider.dart';
import "package:micetalks/provider/constants.dart" as constants;

import 'package:micetalks/components/additionblock.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllCards>(context, listen: false).fetchCardsFromFirestore();
  }

  Future<void> _handleSubmit(
      BuildContext context, Map<String, dynamic> form) async {
    try {
      await FirebaseFirestore.instance
          .collection('investments')
          .add(form)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Investment Added Successfully')),
        );
        Provider.of<AllCards>(context, listen: false).fetchCardsFromFirestore();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add investment')),
        );
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(constants.title, style: GoogleFonts.openSans()),
      ),
      body: Consumer<AllCards>(
        builder: (context, allCards, _) {
          if (allCards.cards.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: allCards.cards.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InputBox(
                        onSubmit: (form) => _handleSubmit(context, form));
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
