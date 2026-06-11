import 'package:flutter/material.dart';

class TopThreeWidget extends StatelessWidget {
  const TopThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildUser(2, 80),
          _buildUser(1, 120), // 👑 الأول أكبر
          _buildUser(3, 70),
        ],
      ),
    );
  }

  Widget _buildUser(int rank, double size) {
    return Column(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.purple.shade100,
          child: Text("$rank", style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 8),
        Text("User $rank"),
      ],
    );
  }
}
