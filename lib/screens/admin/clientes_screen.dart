import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../services/admin_service.dart';

class AdminClientesScreen extends StatefulWidget {
  const AdminClientesScreen({Key? key}) : super(key: key);

  @override
  State<AdminClientesScreen> createState() => _AdminClientesScreenState();
}

class _AdminClientesScreenState extends State<AdminClientesScreen> {
  final _service = AdminService();
  late Future<List<UsuarioModel>> _futureClientes;

  @override
  void initState() {
    super.initState();
    _futureClientes = _service.obtenerClientes();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureClientes = _service.obtenerClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Clientes', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<UsuarioModel>>(
                  future: _futureClientes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFFFB84E)));
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white)));
                    }

                    final clientes = snapshot.data ?? [];
                    if (clientes.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(child: Text('No hay clientes registrados', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.separated(
                        itemCount: clientes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => _AdminClienteCard(cliente: clientes[i]),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminClienteCard extends StatelessWidget {
  final UsuarioModel cliente;

  const _AdminClienteCard({required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 22, backgroundColor: Colors.grey[300]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cliente.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    Text(cliente.email, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF8D28))),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: const Color(0xFFFFB84E)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black, height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rol', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(cliente.rol, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estado', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(cliente.isActive ? 'Activo' : 'Inactivo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: cliente.isActive ? Colors.green : Colors.red))
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Registro', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(cliente.createdAt.toIso8601String().split('T').first, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Teléfono: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(cliente.telefono ?? 'No registrado', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
