import 'package:flutter/material.dart';

class Person {
  String urlImage;
  Person({required this.urlImage});
}

List<Person> people = [
  Person(
      urlImage:
          "https://images.pexels.com/photos/39866/entrepreneur-startup-start-up-man-39866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  Person(
      urlImage:
          "https://images.pexels.com/photos/837358/pexels-photo-837358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  Person(
      urlImage:
          "https://images.pexels.com/photos/762080/pexels-photo-762080.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
];

List<Color> colors = [
  Colors.redAccent,
  Colors.purpleAccent,
  Colors.blueAccent
];

//==========================================================//
//:::::::::::::::::::::::HOME PAGE:::::::::::::::::::::::::://
//==========================================================//

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBody( int index) {
    return _PageItem(
      index: index,
      key: Key(index
          .toString()), //A new key is set to assume it is a new widdget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: SizedBox(), label: '0'),
          BottomNavigationBarItem(icon: SizedBox(), label: '1'),
          BottomNavigationBarItem(icon: SizedBox(), label: '2'),
        ],
        onTap: (index) {
          print("Page : $index");
          _onChange(index);
        },
      ),
      appBar: AppBar(
        title: const Text("Preserve widget status"),
        centerTitle: true,
      ),
      // body: _buildBody(),
      body:IndexedStack(
        index: _currentIndex,
        children: [
          _buildBody(0),
          _buildBody(1),
          _buildBody(2),
        ],
      ),
    );
  }
}

//===========================================================//
//:::::::::::::::::::::::_PageItem:::::::::::::::::::::::::://
//==========================================================//

class _PageItem extends StatefulWidget {
  _PageItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<_PageItem> createState() => _PageItemState();
}

class _PageItemState extends State<_PageItem> {
  List<Person> persons = [];

  void loadPeople() async {
    await Future.delayed(const Duration(milliseconds: 800));
    persons = List.from(people);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors[widget.index],
      child: Center(
        child: Column(
          children: [
            Text(
              widget.index.toString(),
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
            persons.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(20),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(persons[index].urlImage),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}