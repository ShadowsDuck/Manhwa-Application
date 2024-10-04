import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  FormScreenState createState() => FormScreenState(); // เปลี่ยนเป็น public
}

class FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final authorsController = TextEditingController();
  final synopsisController = TextEditingController();
  final imageUrlController = TextEditingController();

  String? selectedGenre;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลมันฮวา'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ชื่อเรื่อง',
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
                  labelText: 'ผู้แต่ง',
                ),
                autofocus: true,
                controller: authorsController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              // Dropdown สำหรับประเภท
              DropdownButtonFormField2<String>(
                decoration: const InputDecoration(
                  labelText: 'ประเภท',
                ),
                value: selectedGenre,
                isExpanded: true,
                hint: const Text('เลือกประเภท'),
                items: ['ต่อสู้', 'แฟนตาซี', 'โรแมนติก', 'อื่นๆ']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'กรุณาเลือกประเภท';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value as String;
                  });
                },
                onSaved: (value) {
                  selectedGenre = value.toString();
                },
              ),
              // Dropdown สำหรับสถานะ
              DropdownButtonFormField2(
                decoration: const InputDecoration(
                  labelText: 'สถานะ',
                ),
                value: selectedStatus,
                isExpanded: true,
                hint: const Text('เลือกสถานะ'),
                items: ['กำลังดำเนิน', 'จบแล้ว', 'หยุดชั่วคราว']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'กรุณาเลือกสถานะ';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value as String;
                  });
                },
                onSaved: (value) {
                  selectedStatus = value.toString();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'เรื่องย่อ',
                ),
                autofocus: true,
                controller: synopsisController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL รูปภาพ',
                ),
                controller: imageUrlController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอก URL ของรูปภาพ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // สีพื้นหลังของปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // ทำให้เป็นวงรี
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // สร้าง object ของ transaction
                    var statement = Transactions(
                      title: titleController.text,
                      authors: authorsController.text,
                      genres: selectedGenre!,
                      status: selectedStatus!,
                      synopsis: synopsisController.text,
                      imageUrl: imageUrlController.text,
                      date: DateTime.now(),
                    );

                    // เพิ่ม transaction data ไปที่ provider
                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.addTransaction(statement);

                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'บันทึก',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
