import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scam_wise_/assets/scam_alert_model.dart';
import 'package:scam_wise_/widgets/ScamAlertCard.dart';

class Home_Page extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggletheme;

  const Home_Page({
    super.key,
    required this.isDarkMode,
    required this.toggletheme,
  });

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<Map<String, dynamic>> scamSections = [];
  bool isLoading = true;
  bool isUrdu = false;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadScamData();
  }

  Future<void> loadScamData() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/assets/data.json',
      );
      final data = json.decode(response);
      setState(() {
        scamSections = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      print('⚠️ Error loading scam data: $e');
      setState(() {
        scamSections = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? Colors.black
          : const Color.fromARGB(255, 24, 102, 116),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('ScamWise', style: TextStyle(color: textColor)),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(backgroundColor: Colors.grey),
          ),
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.toggletheme,
            activeColor: const Color.fromARGB(255, 24, 102, 116),
            inactiveThumbColor: Colors.black,
          ),
        ],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ), // 🔧 Removes extra roundness
        child: Container(
          color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                color: widget.isDarkMode
                    ? Colors.grey[850]
                    : const Color.fromARGB(255, 24, 102, 116),
                child: const Text(
                  'ScamWise Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: const Icon(Icons.report),
                title: const Text('Report a Scam'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/report');
                },
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(13),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : scamSections.isEmpty
            ? const Center(child: Text("📭 No scam data found"))
            : ListView.builder(
                itemCount: scamSections.length,
                itemBuilder: (context, index) {
                  final section = scamSections[index];
                  final String title = section['section'];
                  final String translatedTitle = isUrdu
                      ? (title == 'Today'
                            ? 'آج'
                            : title == 'Yesterday'
                            ? 'کل'
                            : title)
                      : title;

                  final List alerts = section['alerts'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translatedTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),
                      ...alerts.asMap().entries.map<Widget>((entry) {
                        final alertIndex = entry.key;
                        final alert = entry.value;
                        final scam = ScamAlertModel.fromJson(alert);

                        return TweenAnimationBuilder(
                          duration: Duration(
                            milliseconds: 300 + alertIndex * 100,
                          ),
                          tween: Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ),
                          builder: (context, offset, child) {
                            return Transform.translate(
                              offset: Offset(0, offset.dy * 40),
                              child: Opacity(opacity: 1, child: child),
                            );
                          },
                          child: Scamalertcard(
                            region: isUrdu ? scam.regionUr : scam.regionEn,
                            scam: isUrdu ? scam.scamUr : scam.scamEn,
                            aware: isUrdu ? scam.awareUr : scam.awareEn,
                          ),
                        );
                      }),

                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              isUrdu = !isUrdu; // toggle language
            } else {
              currentIndex = index;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: ''),
        ],
      ),
    );
  }
}
