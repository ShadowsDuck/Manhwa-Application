import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final imageUrlController =
      TextEditingController(); // เพิ่ม controller สำหรับ URL รูปภาพ
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ชื่อรายการ',
              ),
              autofocus: true,
              controller: titleController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'จำนวนเงิน',
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              validator: (String? input) {
                try {
                  double amount = double.parse(input!);
                  if (amount < 0) {
                    return 'กรุณากรอกข้อมูลมากกว่า 0';
                  }
                } catch (e) {
                  return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'URL รูปภาพ', // เพิ่มช่องกรอก URL รูปภาพ
              ),
              controller:
                  imageUrlController, // ใช้ controller เพื่อเก็บค่า URL รูปภาพ
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอก URL ของรูปภาพ';
                }
                return null;
              },
            ),
            TextButton(
              child: const Text('บันทึก'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // สร้าง object ของ transaction
                  var statement = Transactions(
                    title: titleController.text,
                    imageUrl: imageUrlController.text,
                    amount: double.parse(amountController.text),
                    date: DateTime.now(),
                  );

                  // เพิ่ม transaction data ไปที่ provider
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
