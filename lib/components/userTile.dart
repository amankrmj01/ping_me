import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final void Function()? onTap;

  const UserTile(
      {super.key,
      required this.name,
      this.onTap,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber.withOpacity(0.2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(message), Text(time)],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
