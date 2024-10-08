import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // ตัวแปรสำหรับข้อมูลส่วนตัว
  final String name = "ธนภัทร ประทุม";
  final String studentId = "รหัสนิสิต: 65311910";
  final String faculty = "คณะ: วิทยาศาสตร์";
  final String branch = "สาขา: วิทยาการคอมพิวเตอร์";
  final String year = "ชั้นปีที่: 3";
  final String email = "อีเมล: ommykung2033@gmail.com";
  final String phoneNumber = "เบอร์โทรศัพท์: 065-020-8419";
  final String profileImageUrl =
      "https://cdn-icons-png.flaticon.com/512/17246/17246491.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แนะนำตัว"),
      ),
      body: Center(
        // ใช้ Center widget เพื่อจัดให้อยู่กลาง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // รูปโปรไฟล์
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(height: 20),
              // ข้อมูลส่วนตัว
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(studentId, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(faculty, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(branch, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(year, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(email, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Text(phoneNumber, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
