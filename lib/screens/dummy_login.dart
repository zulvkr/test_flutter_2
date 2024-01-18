import 'package:flutter/material.dart';

class DummyLoginScreen extends StatefulWidget {
  const DummyLoginScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<DummyLoginScreen> createState() => _DummyLoginScreenState();
}

class _DummyLoginScreenState extends State<DummyLoginScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    StatefulWidget myForm = const MyForm();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/decorationOrange.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.only(top: 56, left: 16.0, right: 16.0),
          child: myForm,
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({
    super.key,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Column is also a layout widget. It takes a list of children and
      // arranges them vertically. By default, it sizes itself to fit its
      // children horizontally, and tries to be as tall as its parent.
      //
      // Column has various properties to control how it sizes itself and
      // how it positions its children. Here we use mainAxisAlignment to
      // center the children vertically; the main axis here is the vertical
      // axis because Columns are vertical (the cross axis would be
      // horizontal).
      //
      // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      // action in the IDE, or press "p" in the console), to see the
      // wireframe for each widget.
      children: <Widget>[
        const SizedBox(height: 64.0),
        const Text('Lorem Ipsum',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16.0),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Name',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'E-mail',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
        ),
        const SizedBox(height: 16.0),
        // add remember checkbox on the left with forgot password on the right
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (bool? value) {
                // Handle checkbox state change
              },
            ),
            const Text('Remember me'),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Handle button press
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            // set coloe
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff511C6F),
              foregroundColor: const Color(0xffffffff),
            ),
            onPressed: () => {
              // Handle button press
            },
            child: const Text('Sign Up'),
          ),
        ),
        const SizedBox(height: 100.0),
        // 2 line of text in 2 row

        const Text('Already have an account?',
            style: TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 156, 156, 156))),
        TextButton(
          onPressed: () {
            // Handle button press
          },
          child: const Text(
            'New Password',
            style: TextStyle(
              color: Color(0xff511C6F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
