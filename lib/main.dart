import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/nfc.dart';
import 'package:flutter_app/qrtrial.dart';

String name = '';
String roll = '';
bool status = false;
String wanted = '';

final CollectionReference _project =
    FirebaseFirestore.instance.collection('project');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirestoreApp());
}

class FirestoreApp extends StatefulWidget {
  const FirestoreApp({Key? key}) : super(key: key);

  @override
  State<FirestoreApp> createState() => _FirestoreAppState();
}

class _FirestoreAppState extends State<FirestoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/options',
      routes: {
        '/pseudo': (context) => PseudoHome(),
        '/out': (context) => OutStudents(),
        '/display': (context) => Display(),
        '/options': (context) => Options(),
        '/scanning': (context) => ScanningPage(),
        '/nfc': (context) => NfcDisplay(),
        '/qrdisplay': (context) => QRDisplay(),
      },
    );
  }
}

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            title: Center(
              child: Center(
                child: Text(
                  'DIGITAL ENTRY',
                  style: TextStyle(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF469BC0),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            children: [
              Expanded(
                flex: 35,
                child: SizedBox(
                  height: 15,
                ),
              ),
              Expanded(
                flex: 20,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/iit.png'),
              ),
              Expanded(
                flex: 75,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              Expanded(
                flex: 50,
                child: Center(
                  child: MaterialButton(
                    minWidth: 275.0,
                    height: 50.0,
                    color: Color(0xFF469BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/out');
                    },
                    child: Text(
                      'OUT STUDENTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Scada',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: SizedBox(
                  height: 20.0,
                ),
              ),
              Expanded(
                flex: 50,
                child: Center(
                  child: MaterialButton(
                    minWidth: 275.0,
                    height: 50.0,
                    color: Color(0xFF469BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pseudo');
                    },
                    child: Text(
                      'ENROLLMENT NUMBER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Scada',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              Expanded(
                flex: 50,
                child: Center(
                  child: MaterialButton(
                    minWidth: 275.0,
                    height: 50.0,
                    color: Color(0xFF469BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/scanning');
                    },
                    child: Text(
                      'QR CODE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Scada',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              Expanded(
                flex: 50,
                child: Center(
                  child: MaterialButton(
                    minWidth: 275.0,
                    height: 50.0,
                    color: Color(0xFF469BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/nfc');
                    },
                    child: Text(
                      'NFC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Scada',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 80,
                child: SizedBox(
                  height: 80.0,
                ),
              ),
            ],
          ),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            title: Center(
              child: Center(
                child: Text(
                  'APP NAME',
                  style: TextStyle(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF469BC0),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: SizedBox(
                  height: 15,
                ),
              ),
              Expanded(
                flex: 35,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/iit.png'),
              ),
              Expanded(
                flex: 75,
                child: SizedBox(
                  height: 35.0,
                ),
              ),
              Expanded(
                flex: 50,
                child: Center(
                  child: MaterialButton(
                    minWidth: 275.0,
                    height: 50.0,
                    color: Color(0xFF469BC0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/options');
                    },
                    child: Text(
                      'ACTIVATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Scada',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 80,
                child: SizedBox(
                  height: 80.0,
                ),
              ),
            ],
          ),
        ));
  }
}

class PseudoHome extends StatefulWidget {
  const PseudoHome({Key? key}) : super(key: key);
  @override
  State<PseudoHome> createState() => _PseudoHomeState();
}

class _PseudoHomeState extends State<PseudoHome> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Center(
              child: Text(
                'ENROLLMENT NUMBER',
                style: TextStyle(
                  fontFamily: 'Scada',
                  fontSize: 22,
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF469BC0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 50,
            child: SizedBox(
              height: 15,
            ),
          ),
          CircleAvatar(
            radius: 85,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/iit.png'),
          ),
          Expanded(
            flex: 35,
            child: SizedBox(
              height: 35.0,
            ),
          ),
          Container(
            child: TextField(
              controller: _controller,
            ),
            padding: EdgeInsets.all(48),
          ),
          Expanded(
            flex: 20,
            child: SizedBox(
              height: 20,
            ),
          ),
          Expanded(
            flex: 50,
            child: Center(
              child: MaterialButton(
                minWidth: 275.0,
                height: 50.0,
                color: Color(0xFF469BC0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onPressed: () {
                  wanted = _controller.text;
                  print(wanted);
                  _controller.clear();
                  // print(_controller.text);
                  Navigator.pushNamed(context, '/display');
                },
                child: Text(
                  'PROCEED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'Scada',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: SizedBox(
              height: 80.0,
            ),
          ),
        ],
      ),
    );
  }
}

class OutStudents extends StatefulWidget {
  const OutStudents({Key? key}) : super(key: key);

  @override
  State<OutStudents> createState() => _OutStudentsState();
}

class _OutStudentsState extends State<OutStudents> {
  final CollectionReference _project =
      FirebaseFirestore.instance.collection('project');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Center(
              child: Text(
                'OUT STUDENTS',
                style: TextStyle(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF469BC0),
        ),
      ),
      body: StreamBuilder(
        stream: _project.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                if (documentSnapshot['status'] == false) {
                  String temp = documentSnapshot['roll'];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      trailing: Text(documentSnapshot['roll']),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/$temp.png'),
                      ),
                    ),
                  );
                } else {
                  return Card();
                }
              },
            );
          } else {
            return Card();
          }
        },
      ),
    );
  }
}

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);
  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  bool isError = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Center(
              child: Text(
                'TOGGLE',
                style: TextStyle(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF469BC0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 50,
            child: SizedBox(
              height: 35.0,
            ),
          ),
          CircleAvatar(
            radius: 85,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/iit.png'),
          ),
          Expanded(
            flex: 35,
            child: SizedBox(
              height: 35.0,
            ),
          ),
          Container(
            height: 100,
            child: StreamBuilder(
              stream: _project.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      if (documentSnapshot['roll'] == wanted) {
                        isError = false;
                        name = documentSnapshot['name'];
                        status = documentSnapshot['status'];
                        roll = documentSnapshot['roll'];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(documentSnapshot['roll']),
                            trailing: Text(documentSnapshot['status'] == true
                                ? 'going OUT?'
                                : 'going IN?'),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/$roll.png'),
                            ),
                          ),
                        );
                      } else {
                        return Card();
                      }
                    },
                  );
                } else {
                  return Card();
                }
              },
            ),
          ),
          (isError == true)
              ? Text('Enrollment number does not exists')
              : Text(''),
          Expanded(
            flex: 35,
            child: SizedBox(
              height: 55.0,
            ),
          ),
          Expanded(
            flex: 50,
            child: Center(
              child: MaterialButton(
                minWidth: 275.0,
                height: 50.0,
                color: Color(0xFF469BC0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onPressed: () async {
                  await _project.doc(wanted).update({
                    'status': !status,
                  });
                  setState(() {
                    status = !status;
                  });
                },
                child: Text(
                  'TOGGLE STATUS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'Scada',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: SizedBox(
              height: 35.0,
            ),
          ),
          Expanded(
            flex: 50,
            child: Center(
              child: MaterialButton(
                minWidth: 275.0,
                height: 50.0,
                color: Color(0xFF469BC0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await _project.doc(wanted).update({
                    'status': !status,
                  });
                },
                child: Text(
                  'DONE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'Scada',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: SizedBox(
              height: 35.0,
            ),
          ),
        ],
      ),
    );
  }
}
