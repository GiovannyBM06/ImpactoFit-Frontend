import 'package:flutter/material.dart';

class MiRutinaScreen extends StatelessWidget {
  const MiRutinaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        'title': 'Trote en Caminadora',
        'series': '3x',
        'reps': '10 a 15 min',
        'time': '0:45',
        'speed': '8 Km/h',
        'estimate': '2 - 4 min',
        'image': 'assets/images/treadmill.png'
      },
      {
        'title': 'Remo en Polea',
        'series': '3x',
        'reps': '8 a 12',
        'time': '0:40',
        'weight': '35.0 kg',
        'estimate': '>30 seg',
        'image': 'assets/images/row.png'
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Expanded(child: Center(child: Text('Mi Rutina', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)))),
                ],
              ),
              const SizedBox(height: 8),
              const Align(alignment: Alignment.centerLeft, child: Text('0 de 10 completados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: exercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (context, i) {
                    final ex = exercises[i];
                    return ExerciseCard(
                      title: ex['title'] as String,
                      series: ex['series'] as String,
                      reps: ex['reps'] as String,
                      time: ex['time'] as String,
                      bottomLeft: ex['speed'] as String? ?? ex['weight'] as String? ?? '',
                      estimate: ex['estimate'] as String,
                      image: ex['image'] as String,
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

class ExerciseCard extends StatelessWidget {
  final String title;
  final String series;
  final String reps;
  final String time;
  final String bottomLeft;
  final String estimate;
  final String image;

  const ExerciseCard({required this.title, required this.series, required this.reps, required this.time, required this.bottomLeft, required this.estimate, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('series', style: TextStyle(color: const Color(0xFFFFB84E), fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(series, style: const TextStyle(fontWeight: FontWeight.w600))]),
                    const SizedBox(width: 24),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('repeticiones', style: TextStyle(color: const Color(0xFFFFB84E), fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(reps, style: const TextStyle(fontWeight: FontWeight.w600))]),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(5)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Descanso', style: TextStyle(fontWeight: FontWeight.w600)), Text(time)]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)), child: const Icon(Icons.pause, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(bottomLeft, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Column(children: [Text('Tiempo espera aprox.', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(estimate, style: const TextStyle(fontWeight: FontWeight.w600))])
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
