import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/single_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
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
          childAspectRatio: (150 / 247),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleItemScreen(
                            title: transaction.title,
                            author: transaction.authors,
                            genre: transaction.genres,
                            status: transaction.status,
                            synopsis: transaction.synopsis,
                            imageUrl: transaction.imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 1, // ความกว้างของเงา
                            blurRadius: 5, // ความเบลอของเงา
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 200,
                          width: 150,
                          child: Image.network(
                            transaction.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // ตัดข้อความด้วย ...
                            maxLines: 1, // กำหนดให้แสดงข้อความในบรรทัดเดียว
                          ),
                          Text(
                            transaction.status,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: 20,
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
                                provider.deleteTransaction(transaction.keyID);
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
