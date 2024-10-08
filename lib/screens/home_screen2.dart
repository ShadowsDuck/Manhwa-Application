import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/form_screen.dart';
import 'package:account/widgets/items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = ''; // คำค้นหา
  final List<String> genres = [
    "ทั้งหมด",
    "ต่อสู้",
    "แฟนตาซี",
    "โรแมนติก",
    "อื่นๆ"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: genres.length); // เปลี่ยน length เป็น genres.length
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
                      onTap: () {},
                      child: Icon(
                        Icons.sort_rounded,
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
                    )
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
                  tabs: genres.map((genre) => Tab(text: genre)).toList()),
              const SizedBox(height: 10),
              Center(
                child: ItemsWidget(
                  searchQuery: _searchQuery,
                  selectedGenre:
                      genres[_tabController.index], // ส่งประเภทที่เลือกไป
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FormScreen();
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
}
