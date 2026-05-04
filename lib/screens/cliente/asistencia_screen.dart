import 'package:flutter/material.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({Key? key}) : super(key: key);

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  final TextEditingController _userController = TextEditingController(text: 'Juan Fernando Lozano');
  final TextEditingController _timeController = TextEditingController(text: '15:30');
  bool personal = false;
  bool grupal = false;
  bool libre = true;

  @override
  void dispose() {
    _userController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Text('Volver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24)),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              const Text('Usuario:', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700, fontSize: 24)),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _userController,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Hora de Ingreso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24)),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _timeController,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Tipo actividad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24)),
+              const SizedBox(height: 12),
+              Row(
+                crossAxisAlignment: CrossAxisAlignment.center,
+                children: [
+                  Checkbox(value: personal, onChanged: (v) => setState(() => personal = v ?? false), activeColor: Colors.white, checkColor: Colors.black),
+                  const SizedBox(width: 8),
+                  const Text('Entrenamiento personal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
+                ],
+              ),
+              Row(
+                children: [
+                  Checkbox(value: grupal, onChanged: (v) => setState(() => grupal = v ?? false), activeColor: Colors.white, checkColor: Colors.black),
+                  const SizedBox(width: 8),
+                  const Text('Clase Grupal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
+                ],
+              ),
+              Row(
+                children: [
+                  Checkbox(value: libre, onChanged: (v) => setState(() { libre = v ?? false; if (libre) { personal = false; grupal = false; } }), activeColor: Colors.white, checkColor: Colors.black),
+                  const SizedBox(width: 8),
+                  const Text('Entrenamiento Libre', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w700)),
+                ],
+              ),
+              const Spacer(),
+              Align(
+                alignment: Alignment.centerRight,
+                child: ElevatedButton(
+                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB84E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
+                  onPressed: () {
+                    // TODO: submit asistencia to API
+                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Asistencia enviada')));
+                    Navigator.of(context).pop();
+                  },
+                  child: Padding(
+                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
+                    child: Row(
+                      mainAxisSize: MainAxisSize.min,
+                      children: const [
+                        Text('Enviar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18)),
+                        SizedBox(width: 8),
+                        Icon(Icons.chevron_right, color: Colors.black),
+                      ],
+                    ),
+                  ),
+                ),
+              ),
+              const SizedBox(height: 18),
+            ],
+          ),
+        ),
+      ),
+    );
+  }
+}
