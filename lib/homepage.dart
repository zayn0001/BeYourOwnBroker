import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:micetalks/components/cardblock.dart';
import 'package:micetalks/provider/data.dart';
import 'package:provider/provider.dart';
import "package:micetalks/provider/constants.dart" as constants;

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
          return ListView.builder(
            itemCount: allCards.cards.length,
            itemBuilder: (context, index) {
              CardModel card = allCards.cards[index];
              return CardBlock(card: card);
            },
          );
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
