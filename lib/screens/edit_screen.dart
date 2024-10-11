import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final authorsController = TextEditingController();
  final synopsisController = TextEditingController();
  final imageUrlController = TextEditingController();

  String? selectedGenre;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นจากข้อมูลเดิมของ statement
    titleController.text = widget.statement.title;
    authorsController.text = widget.statement.authors;
    synopsisController.text = widget.statement.synopsis;
    imageUrlController.text = widget.statement.imageUrl;
    selectedGenre = widget.statement.genres;
    selectedStatus = widget.statement.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลมันฮวา'),
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
              DropdownButtonFormField2<String>(
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
                    var statement = Transactions(
                      keyID: widget.statement.keyID,
                      title: titleController.text,
                      authors: authorsController.text,
                      genres: selectedGenre!,
                      status: selectedStatus!,
                      synopsis: synopsisController.text,
                      imageUrl: imageUrlController.text,
                    );

                    // อัปเดตข้อมูลผ่าน provider
                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.updateTransaction(statement);

                    // ส่งข้อมูลกลับไปที่หน้าก่อนหน้า
                    Navigator.pop(context, statement);
                  }
                },
                child: const Text(
                  'แก้ไขข้อมูล',
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
