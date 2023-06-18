import 'package:flutter/material.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(radius: 60.0),
                const SizedBox(height: 15),
                const Text('John Doe',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8.0),
                _rating(3),
                const SizedBox(height: 15),
                const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                const SizedBox(height: 15),
                const Text('Interests',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                const SizedBox(height: 10),
                Wrap(
                  runSpacing: 5.0,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildChip("interest1", const Color(0xFFff6666)),
                    const SizedBox(width: 10),
                    _buildChip("interest2", const Color(0xFFff6666)),
                  ],
                ),
                const SizedBox(height: 15),
                const Text('Address',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                  
              ],
            ),
          ),
        ));
  }
}

Widget _buildChip(String label, Color color) {
  return Chip(
    labelPadding: const EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(8.0),
  );
}

Widget _rating(int rating) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          Icon(i < rating ? Icons.star : Icons.star_border,
              color: Colors.amber, size: 30)
      ]);
}
