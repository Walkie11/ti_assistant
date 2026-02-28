import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  const Event({
    super.key,
    required this.titre,
    required this.end,
    required this.start,
  });
  final String titre;
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: const Color.fromARGB(54, 116, 111, 98),
        border: Border(
          left: BorderSide(
            color: const Color.fromARGB(123, 244, 67, 54),
            width: 15,
          ),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color.fromARGB(170, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                  "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - "
                  "${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
