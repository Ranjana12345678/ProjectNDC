
import 'package:flutter/material.dart';

class CustomSnackMessage extends StatelessWidget {
  final Color color;
  final IconData messageIcon;
  final String messageTitle;
  final String messageBody;

  const CustomSnackMessage({
    Key? key,
    required this.messageIcon,
    required this.messageTitle,
    required this.messageBody,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Icon(messageIcon , size: 40, color: Colors.white,),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(messageTitle, style: const TextStyle(fontSize: 15, color: Colors.white),),
                  Text(
                    messageBody,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        )

    );
  }
}
