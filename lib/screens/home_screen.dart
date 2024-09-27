import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:account/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("แอพบัญชี"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, TransactionProvider provider, Widget? child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(statement.title),
                    subtitle: Text(DateFormat('dd MMM yyyy hh:mm:ss')
                        .format(statement.date)),
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('${statement.amount}'),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Confirm deletion with a dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this transaction?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  provider.deleteTransaction(statement);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
