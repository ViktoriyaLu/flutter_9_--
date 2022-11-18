import 'package:fitst_app/userPreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Хранение данных',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String password = '';

  @override
  void initState() {
    super.initState();

    name = UserPreferences().getUsername() ?? '';
    password = UserPreferences().getPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 5, 202, 237),
            Color.fromARGB(255, 240, 52, 237),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'HELLO!!!',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Sign in to your account',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name *',
                ),
                onChanged: (name) => setState(() => this.name = name),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: TextFormField(
                initialValue: password,
                decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  labelText: 'Password*',
                ),
                onChanged: (password) =>
                    setState(() => this.password = password),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await UserPreferences().deleteUsername();
                    setState(() {
                      name = '';
                    });
                    await UserPreferences().deletePassword();
                    setState(() {
                      password = '';
                    });
                  },
                  child: const Text(
                    'Forgot your Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await UserPreferences().setUsername(name);
                    await UserPreferences().setPassword(password);
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
