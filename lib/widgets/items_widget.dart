import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/single_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsWidget extends StatefulWidget {
  final String searchQuery;
  final String selectedGenre;

  const ItemsWidget(
      {super.key, required this.searchQuery, required this.selectedGenre});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        List<Transactions> filteredTransactions =
            provider.transactions.where((transaction) {
          bool matchesGenre = widget.selectedGenre == 'ทั้งหมด' ||
              transaction.genres.toLowerCase() ==
                  widget.selectedGenre.toLowerCase();
          bool matchesSearchQuery = transaction.title
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase());

          return matchesGenre && matchesSearchQuery;
        }).toList();

        if (filteredTransactions.isEmpty) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.55,
              child: const Text(
                'โปรดเพิ่มมันฮวาที่คุณสนใจ',
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
          children: List.generate(filteredTransactions.length, (index) {
            var transaction = filteredTransactions[index];
            var statement = provider.transactions[index];

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
                          builder: (context) {
                            return SingleItemScreen(statement: statement);
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ส่วนของดาวและข้อความ 5.0
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // ส่วนของไอคอนถังขยะ
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          iconSize: 20,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('ยืนยันการลบข้อมูล'),
                                content: const Text(
                                    'คุณต้องการลบเรื่องนี้ทิ้งใช่ไหม?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('ไม่'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      provider
                                          .deleteTransaction(transaction.keyID);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('ใช่'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
