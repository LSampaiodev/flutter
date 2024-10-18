import 'package:flutter/material.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({super.key});

  @override
  AddLanguageScreenState createState() => AddLanguageScreenState();
}

class AddLanguageScreenState extends State<AddLanguageScreen> {
  final TextEditingController _languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _languageController,
              decoration: const InputDecoration(
                labelText: 'Language Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Exibir a linguagem inserida ou fazer outra ação
                final languageName = _languageController.text;
                if (languageName.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Language: $languageName added')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
