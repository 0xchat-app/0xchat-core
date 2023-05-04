import 'package:flutter/material.dart';
import 'package:chatcore/src/account/account.dart';
import 'package:chatcore/src/account/model/userDB.dart';
import 'package:chatcore/src/common/database/db.dart';
import 'package:chatcore/src/common/network/connect.dart';
import 'main.reflectable.dart'; // Import generated code.
import 'package:nostr/nostr.dart';
import 'package:chatcore/src/chat/friends.dart';

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

  UserDB? db3 = await Account.loginWithPubKeyAndPassword(
      "7bd7161b4ea87d34dbc9a7f36907c6ada238b29ea7fb469df431921604ee7dba",
      "password");
  print(db3?.toMap());

  // int result = await Account.delete(db3!.privkey!);
  // print('result = $result');
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
    authors: [
      "bb4beecb9cbd06786506204eff2841387c286a058019fc8de8042d2151bada3d"
    ],
  );
  Connect.sharedInstance.addSubscription([f], (event) {
    print(event.content);
  });
  // UserDB db = await Account.newAccount();
  // print(db.toMap());
  // Account.updateProfile(db.privkey!, 'name', 'gender', 'area', 'about', 'picture');
}

// user1 pub:   dc6ef75354eaa089089e4cd5246384c2a3ea554fa04bf2c26c8af798e96e6f3d
// user1 priv:  81cce0c8980eafd8eeab8b46c4a93aee0ef4c92c91f4b7b45a4db940304d7f51
// user2 pub:   3d4ce46b892035f0a89dd7df0d69e2c4d63377f139823c8d53a8ebc25b489168
// user2 priv:  a803fee503edde5f08d713a9b5365b7951aa65b986f3a4bcdbc89e6fb9f9847c
Future<void> testFriends() async {
  var user1 = Keychain("81cce0c8980eafd8eeab8b46c4a93aee0ef4c92c91f4b7b45a4db940304d7f51");
  var user2 = Keychain("a803fee503edde5f08d713a9b5365b7951aa65b986f3a4bcdbc89e6fb9f9847c");

  await Connect.sharedInstance.connectRelays(["ws://192.168.1.3:6969"]);
  Friends.sharedInstance.requestFriend(user2.public, user1.private, "hello, friends request");

  await Future.delayed(const Duration(seconds: 1));

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable(); // Set up reflection support.
  await initDB();
  testFriends();
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
