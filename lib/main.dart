import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:pdf_module/constants.dart';
import 'package:pdf_module/viewPDF.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'View PDF File',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  PDFDocument doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('PDF Module'),
              accountEmail: Text('nextingoindia@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  'N',
                  style: TextStyle(fontSize: 30.0),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.info_outlined),
              title: Text('About'),
            ),
            ListTile(
              leading: Icon(Icons.question_answer_outlined),
              title: Text('FAQ'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("PDF Viewer Module"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 10.0,),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  tooltip: 'Notifications',
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  iconSize: 20.0,
                ),
              ),
              SizedBox(width: 5.0,),
            ],
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network('https://www.pccsuk.com/blog/wp-content/uploads/2016/11/searching.png'),
                    ElevatedButton(
                      onPressed: () {
                        loadFromAsset();
                      },
                      child: Text(
                        "View local PDF ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loadFromURL();
                      },
                      child: Text(
                        "View PDF in Network",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('Network File Address:'),
                    Text(' ${Constants.pdfURL}')
                    
                  ],
                ),
        ),
      ),
    );
  }

  loadFromAsset() async {
    setState(() {
      isLoading = true;
    });
    doc = await PDFDocument.fromAsset('assets/Hello.pdf');
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(doc: doc),
      ),
    );
  }

  loadFromURL() async {
    setState(() {
      isLoading = true;
    });

    doc = await PDFDocument.fromURL(Constants.pdfURL);
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(doc: doc),
      ),
    );
  }
}
