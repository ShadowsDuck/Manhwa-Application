import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/form_screen.dart';
import 'package:account/widgets/items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  final List<String> genres = [
    "ทั้งหมด",
    "ต่อสู้",
    "แฟนตาซี",
    "โรแมนติก",
    "อื่นๆ"
  ];

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ommykung2033@gmail.com',
      query: encodeQueryParameters(
          {'subject': 'แจ้งปัญหา', 'body': 'แจ้งปัญหาเรื่อง ...'}),
    );

    await launchUrl(emailLaunchUri);
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
        .join('&');
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(_handleTabSelection);
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // เปิดเมนูตัวเลือก
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'ตัวเลือกเพิ่มเติม ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ListTile(
                                      leading: const Icon(Icons.info),
                                      title: const Text('เกี่ยวกับแอป'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _showAboutDialog();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.settings),
                                      title: const Text('ตั้งค่า'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _showSettingsDialog();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.help),
                                      title: const Text('แจ้งปัญหา'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _sendEmail(); // เรียกฟังก์ชันส่งอีเมล
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.sort,
                        color: Colors.black.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.black.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "ToonZone",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ค้นหามันฮวาที่คุณสนใจ',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                tabs: genres.map((genre) => Tab(text: genre)).toList(),
              ),
              const SizedBox(height: 10),
              Center(
                child: ItemsWidget(
                  searchQuery: _searchQuery,
                  selectedGenre: genres[_tabController.index],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormScreen();
          }));
        },
        backgroundColor: const Color.fromARGB(255, 255, 248, 247),
        mini: true,
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // แสดง Dialog สำหรับ "About App"
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เกี่ยวกับแอป'),
          content: const Text('นี่คือแอปสำหรับการจัดการมันฮวาที่คุณสนใจ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // แสดง Dialog สำหรับ "Settings"
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ตั้งค่า'),
          content: const Text('การตั้งค่าจะถูกนำมาใช้เร็วๆ นี้'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
