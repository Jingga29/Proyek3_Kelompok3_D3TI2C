import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F8EEB),
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi Admin!",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const Image(
                      image: AssetImage('assets/images/hee.jpeg'),
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Yang baru diakses",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildCard("contoh", Colors.pink),
                      buildCard("contoh 2", Colors.green),
                      buildCard("contoh 3", Colors.blue),
                      buildCard("contoh 4", Colors.red),
                      buildCard("contoh 5", Colors.yellow),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    
                  ],
                ),
                const SizedBox(height: 30),
                itemCount > 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 500, 
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemCount,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 300,
                                height: 90,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    'Item ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No items'),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: Color(0xFF0F8EEB),
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white.withOpacity(.60),
  selectedFontSize: 14,
  unselectedFontSize: 14,
  onTap: (value) {
    // Respond to item press.
  },
  items: [
    BottomNavigationBarItem(
      label: 'home',
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: 'notif',
      icon: Icon(Icons.notifications),
    ),
    BottomNavigationBarItem(
      label: 'profile',
      icon: Icon(Icons.person),
    ),
  ],
),
    );
  }

  Widget buildCard(String text, Color color) {
    return Container(
      width: 300,
      height: 100,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
