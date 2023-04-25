import 'package:flutter/material.dart';
import 'package:chatcore/src/account/account.dart';
import 'package:chatcore/src/account/model/userDB.dart';
import 'package:chatcore/src/common/database/db.dart';
import 'package:chatcore/src/common/network/connect.dart';
import 'main.reflectable.dart'; // Import generated code.
import 'package:nostr/nostr.dart';

initDB() async {
  DB.sharedInstance.schemes.add(UserDB);
  DB.sharedInstance.deleteDBIfNeedMirgration = false;
  await DB.sharedInstance.open("chat1.db", version: 1);
}

Future<void> testAccount() async {
  // UserDB db = await Account.newAccount();
  // print(db.toMap());
  // UserDB db2 = await Account.newAccountWithPassword("password");
  // print(db2.toMap());

  UserDB? db3 = await Account.loginWithPubKeyAndPassword("7bd7161b4ea87d34dbc9a7f36907c6ada238b29ea7fb469df431921604ee7dba", "password");
  print(db3?.toMap());

  int result = await Account.delete(db3!.privkey!);
  print('result = $result');
  // UserDB? db3 = await Account.updateProfile(db?.privkey!!, "nickname", "gender", "area", "bio");
  // print(db3?.toMap());
}
///
/// 335189cda14e1f819bc9d39673fed45b4f07ffc688ee12560ba85a1c3d878eef
/// Fw5_COv@,V(IKf+p
Future<void> testConnect() async {
    await Connect.sharedInstance.connectRelays(["ws://192.168.1.3:6969"]);
    Filter f = Filter(
      kinds: [0],
      authors: ["bb4beecb9cbd06786506204eff2841387c286a058019fc8de8042d2151bada3d"],
    );
    Connect.sharedInstance.addSubscription([f], (event) {
        print(event.content);
    });
  // UserDB db = await Account.newAccount();
  // print(db.toMap());
  // Account.updateProfile(db.privkey!, 'name', 'gender', 'area', 'about', 'picture');
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable(); // Set up reflection support.
  await initDB();
  testConnect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
