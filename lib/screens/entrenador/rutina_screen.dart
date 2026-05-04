import 'package:flutter/material.dart';

class EntrenadorRutinaScreen extends StatelessWidget {
  const EntrenadorRutinaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: const [
                          Text('Rutina:', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
                          Text('Cliente X', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 8),
              const Text('1 ejercicio(s) asignado(s)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    // Hora aprox. entreno
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          const Text('Hora aprox. entreno:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: const Text('16:00', style: TextStyle(color: Colors.black, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Exercise card
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ejercicio #1', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w500, fontSize: 15)),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: const Color(0xFFF3F2F2), borderRadius: BorderRadius.circular(8)),
                            child: const Text('Jalón en Polea', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Nº series:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('3 x', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Nº repeticiones:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('16 a 20', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Descanso :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('0:45', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Entre series:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('0:45', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Fin ejercicio:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('3:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [Text('Intensidad:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)), SizedBox(height: 4), Text('15 kg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Machine section
                          const Text('Máquina Utilizada', style: TextStyle(color: Color(0xFFFFB84E), fontWeight: FontWeight.w600, fontSize: 20)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: AssetImage('assets/images/machine.jpg'), fit: BoxFit.cover)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Polea Dual', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                                    const SizedBox(height: 8),
                                    const Text('Uso esperado', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: const Color(0xFFF3F2F2), borderRadius: BorderRadius.circular(8)),
                                      child: const Text('A las 16:00 se espera un uso:\nModerado', style: TextStyle(color: Colors.black, fontSize: 18)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Days section
                          Row(
                            children: const [
                              Text('Días:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                              SizedBox(width: 8),
                              Text('| L | Ma | Mi | J | V | S | D |', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Add exercise button
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFFB84E), width: 2)),
                                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Color(0xFFFFB84E), size: 32)),
                                ),
                                const SizedBox(height: 8),
                                const Text('Agregar Ejercicio', style: TextStyle(color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
