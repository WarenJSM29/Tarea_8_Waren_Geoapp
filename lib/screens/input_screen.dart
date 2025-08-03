import 'package:flutter/material.dart';
import 'map_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingresar Datos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) => value!.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: "Apellido"),
                validator: (value) => value!.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(labelText: "Latitud"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Requerido" : null,
              ),
              TextFormField(
                controller: _lngController,
                decoration: const InputDecoration(labelText: "Longitud"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Requerido" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapScreen(
                          name: _nameController.text,
                          surname: _surnameController.text,
                          latitude: double.parse(_latController.text),
                          longitude: double.parse(_lngController.text),
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Siguiente"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
