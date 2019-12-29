import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'QR Code Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanBarcode ="";

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.

      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#42f5ef", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  TextEditingController _url = new TextEditingController();
  _openURL() async{
    print('open click');
    var url = _url.text;
    if( await canLaunch(url)){
      launch(url);
    }
    else
      print('URL CAN NOT BE LAUNCH');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            QrImage(
              data: "QR Code",
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor:  Colors.white,
              foregroundColor: Colors.lightBlue,
              embeddedImage: AssetImage('assets/images/logo.png'),
                embeddedImageStyle : QrEmbeddedImageStyle(
                  size: Size.square(30),
                  color: Color.fromARGB(100, 10, 10, 10)
                )
            ),
            Text(_scanBarcode),
            new TextField(
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              controller: _url,),
            new RaisedButton(
              onPressed: _openURL, child: new Text('OPEN URL'),)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcodeNormal,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
