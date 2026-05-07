import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class BienvenidaScreen extends StatelessWidget {
	const BienvenidaScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: [
					// Background image (add your asset at assets/images/gym_bg.jpg)
					Positioned.fill(
						child: Image.asset(
							'assets/images/gym_bg.jpg',
							fit: BoxFit.cover,
						),
					),
					// Dark overlay to match prototype
					Positioned.fill(
							child: Container(color: Colors.black.withValues(alpha: 0.35)),
					),
					// Content
					SafeArea(
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 24.0),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const SizedBox(height: 80),
									// Title
									Text(
										'Impacto',
										style: TextStyle(
											color: const Color(0xFFFFB84E),
											fontSize: 72,
											fontWeight: FontWeight.w900,
											shadows: [
												Shadow(
													offset: Offset(0, 4),
													blurRadius: 4,
														color: Colors.black.withValues(alpha: 0.25),
												)
											],
										),
									),
									Text(
										'Fit',
										style: TextStyle(
											color: Colors.white,
											fontSize: 72,
											fontWeight: FontWeight.w900,
										),
									),
									const Spacer(),
									// Button
									Center(
										child: SizedBox(
											width: 300,
											height: 64,
											child: ElevatedButton(
												style: ElevatedButton.styleFrom(
													backgroundColor: const Color(0xFFFFB84E),
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(200),
													),
												),
												onPressed: () {
													Navigator.of(context).push(MaterialPageRoute(
															builder: (_) => const LoginScreen()));
												},
												child: Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: const [
														Text(
															'Iniciar Sesión',
															style: TextStyle(
																color: Colors.black,
																fontWeight: FontWeight.w700,
																fontSize: 20,
															),
														),
														SizedBox(width: 12),
														Icon(Icons.chevron_right, color: Colors.black),
													],
												),
											),
										),
									),
									const SizedBox(height: 48),
								],
							),
						),
					),
				],
			),
		);
	}
}
