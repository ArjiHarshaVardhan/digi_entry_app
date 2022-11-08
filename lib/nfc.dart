import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:Digital_Entry/nfc_working.dart';

String name = '';
String roll = '';
bool status = false;
String wanted = '';

final CollectionReference _project =
    FirebaseFirestore.instance.collection('project');

class NfcDisplay extends StatefulWidget {
  const NfcDisplay({Key? key}) : super(key: key);

  @override
  State<NfcDisplay> createState() => _NfcDisplayState();
}

class _NfcDisplayState extends State<NfcDisplay> {
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
          (wanted.length != 8) ? Text('Could not read NFC Tag') : Text(''),
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
