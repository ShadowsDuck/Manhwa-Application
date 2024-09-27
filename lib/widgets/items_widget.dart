import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<String> img = [
    'Yor',
    'Solo-Leveling',
    'Omniscient-Reader',
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap the grid in a Consumer to listen for changes in TransactionProvider
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        // Check if transactions exist, otherwise display a fallback message
        if (provider.transactions.isEmpty) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.55,
              child: const Text(
                'No contents available.',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: (150 / 236),
          children: List.generate(provider.transactions.length, (index) {
            var transaction = provider.transactions[index];

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      // Display the image URL from the transaction
                      child: Image.network(
                        'https://baro7.com/cdn/shop/files/solo-leveling-only-i-level-up-manhwa-297985.jpg?v=1721243007&width=480',
                        // transaction.imageUrl ??
                        //     'https://via.placeholder.com/150',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(transaction.date),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Confirm deletion with a dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Delete'),
                          content:
                              const Text('Are you sure you want to delete?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                provider.deleteTransaction(transaction);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
