import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            SizedBox(height: 21),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                autofocus: true,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'City Name',
                  hintText: 'More than 2 characters',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'City name must be at least 2 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _city = value;
                },
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text('How\'s the weather?'),
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      // save button을 눌렀을 때 autoValidate 가 실행되도록 설정
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      Navigator.pop(context, _city!.trim());
    }
  }
}
