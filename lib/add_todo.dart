import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  List <dynamic> todo = [];
  var formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Todo'),
        ),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(40),
            children: [
              TextFormField(
                controller: title,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Todo Title',
                    hintText: 'e.g Exercise'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter todo title';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                    } else {
                      return null;
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          ))
    );
  }
}
