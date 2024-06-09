// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unused_element

import 'package:flutter/material.dart';
import 'package:test_students/data.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    title: 'test students',
    theme: ThemeData(
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder())),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final resualt = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => _AddStudents(),
            ));
            setState(() {});
          },
          label: Row(
            children: [Icon(Icons.add), Text('add Students')],
          )),
      appBar: AppBar(title: Text('test students api')),
      body: FutureBuilder<List<StudentData>>(
        future: getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return _Student(data: snapshot.data![(index)]);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _Student extends StatelessWidget {
  final StudentData data;

  const _Student({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 85,
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
          ]),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            child: Text(
              data.firstName.characters.first,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.firstName + '' + data.lastNmae),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.shade200),
                  child: Text(
                    data.course,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: Colors.grey.shade400,
              ),
              Text(
                data.score.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddStudents extends StatelessWidget {
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _coursecontroller = TextEditingController();
  final TextEditingController _scorecontroller = TextEditingController();

  _AddStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test students : add Students'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            try {
              final newStudentData = await saveStudent(
                  _firstnamecontroller.text,
                  _lastnamecontroller.text,
                  _coursecontroller.text,
                  int.parse(_scorecontroller.text));
              Navigator.pop(context, newStudentData);
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          label: Row(
            children: [Icon(Icons.save), Text('save')],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstnamecontroller,
              decoration: InputDecoration(label: Text('First Name  ')),
            ),
            SizedBox(
              height: 9,
            ),
            TextField(
              controller: _lastnamecontroller,
              decoration: InputDecoration(label: Text('Last Name  ')),
            ),
            SizedBox(
              height: 9,
            ),
            TextField(
              controller: _coursecontroller,
              decoration: InputDecoration(label: Text('Course  ')),
            ),
            SizedBox(
              height: 9,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _scorecontroller,
              decoration: InputDecoration(label: Text('Score  ')),
            ),
          ],
        ),
      ),
    );
  }
}
