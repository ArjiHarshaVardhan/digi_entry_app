import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/cupertino.dart';

String name = '';
String roll = '';
bool status = false;
String wanted = '';

final CollectionReference _project =
    FirebaseFirestore.instance.collection('project');
var getResult = 'QR Code Result';

class ScanningPage extends StatefulWidget {
  const ScanningPage({Key? key}) : super(key: key);

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Center(
            child: Center(
              child: Text(
                'SCAN QR CODE',
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
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Enrollment Number: ${result!.code}')
                  : Text('Scan a code'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: MaterialButton(
                color: Color(0xFF469BC0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/qrdisplay');
                },
                child: Text(
                  'DONE',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Scada',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        wanted = '${result!.code}';
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QRDisplay extends StatefulWidget {
  const QRDisplay({Key? key}) : super(key: key);

  @override
  State<QRDisplay> createState() => _QRDisplayState();
}

class _QRDisplayState extends State<QRDisplay> {
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
