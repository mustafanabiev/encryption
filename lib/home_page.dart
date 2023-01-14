import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as keys;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultBase16 = '';
  String resultBase64 = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void encrypted(String plainText) async {
      final key = keys.Key.fromLength(32);
      final iv = IV.fromLength(8);
      final encrypter = Encrypter(Salsa20(key));

      final encrypted = encrypter.encrypt(plainText, iv: iv);

      setState(() {
        resultBase16 = encrypted.base16;
        resultBase64 = encrypted.base64;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Шифирлоо'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Текст киргизуу',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => encrypted(controller.text),
                child: const Text('Шифирлоо'),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Шифирлоодон кийинки жыйынтык:'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1) base16: $resultBase16'),
                      Text('2) base64: $resultBase64'),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
