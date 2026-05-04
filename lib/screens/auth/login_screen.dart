import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
	const LoginScreen({Key? key}) : super(key: key);

	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passController = TextEditingController();
	bool _obscurePassword = true;

	@override
	void dispose() {
		_emailController.dispose();
		_passController.dispose();
		super.dispose();
	}

	/// Ejecutar login con validación
	Future<void> _handleLogin() async {
		if (_emailController.text.isEmpty || _passController.text.isEmpty) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(content: Text('Por favor llena todos los campos')),
			);
			return;
		}

		final authProvider = context.read<AuthProvider>();
		final success = await authProvider.login(
			email: _emailController.text,
			password: _passController.text,
		);

		if (success) {
			// Login exitoso, la navegación se maneja en main.dart
			if (mounted) {
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('¡Bienvenido!')),
				);
			}
		} else {
			// Error en login
			if (mounted) {
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text(authProvider.errorMessage ?? 'Error al iniciar sesión')),
				);
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color(0xFF262525),
			body: Stack(
				children: [
					Positioned.fill(
						child: Image.asset(
							'assets/images/login_bg.jpg',
							fit: BoxFit.cover,
						),
					),
					Positioned.fill(
						child: Container(color: Colors.black.withOpacity(0.72)),
					),
					SafeArea(
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const SizedBox(height: 60),
									const Text(
										'Inicio de sesión',
										style: TextStyle(
											color: Colors.white,
											fontSize: 24,
											fontWeight: FontWeight.w900,
										),
									),
									const SizedBox(height: 8),
									Container(
										width: 198,
										height: 7,
										decoration: BoxDecoration(
											color: const Color(0xFFFFB84E),
											borderRadius: BorderRadius.circular(200),
										),
									),
									const Spacer(),
									// Email input
									Text('Correo electrónico', style: TextStyle(color: Colors.white.withOpacity(0.85), fontWeight: FontWeight.w700, fontSize: 20)),
									const SizedBox(height: 8),
									TextField(
										controller: _emailController,
										style: const TextStyle(color: Colors.white),
										keyboardType: TextInputType.emailAddress,
										decoration: const InputDecoration(
											border: InputBorder.none,
											isDense: true,
											hintText: 'tu@correo.com',
											hintStyle: TextStyle(color: Colors.grey),
										),
									),
									Container(height: 2, color: Colors.black),
									const SizedBox(height: 16),
									// Password input
									Text('Contraseña', style: TextStyle(color: Colors.white.withOpacity(0.85), fontWeight: FontWeight.w700, fontSize: 20)),
									const SizedBox(height: 8),
									TextField(
										controller: _passController,
										obscureText: _obscurePassword,
										style: const TextStyle(color: Colors.white),
										decoration: InputDecoration(
											border: InputBorder.none,
											isDense: true,
											suffixIcon: IconButton(
												icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
												onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
											),
										),
									),
									Container(height: 2, color: Colors.black),
									const SizedBox(height: 16),
									// Forgot password link
									Align(
										alignment: Alignment.centerRight,
										child: GestureDetector(
											onTap: () => Navigator.of(context).pushNamed('/recuperar-password'),
											child: const Text(
												'¿Olvidaste tu contraseña?',
												style: TextStyle(
													color: Color(0xFFFFB84E),
													fontWeight: FontWeight.w700,
													fontSize: 14,
												),
											),
										),
									),
									const SizedBox(height: 32),
									// Login button
									Consumer<AuthProvider>(
										builder: (context, authProvider, _) {
											return Align(
												alignment: Alignment.centerRight,
												child: ElevatedButton(
													style: ElevatedButton.styleFrom(
														backgroundColor: Colors.white,
														shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
														disabledBackgroundColor: Colors.grey,
													),
													onPressed: authProvider.isLoading ? null : _handleLogin,
													child: Padding(
														padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
														child: Row(
															mainAxisSize: MainAxisSize.min,
															children: [
																Text(
																	authProvider.isLoading ? 'Cargando...' : 'Ingresar',
																	style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
																),
																const SizedBox(width: 8),
																const Icon(Icons.chevron_right, color: Colors.black),
															],
														),
													),
												),
											);
										},
									),
									const SizedBox(height: 40),
								],
							),
						),
					),
				],
			),
		);
	}
}
