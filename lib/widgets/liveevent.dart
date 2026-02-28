import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LiveEvent extends StatelessWidget {
  const LiveEvent({
    super.key,
    required this.projet,
    required this.titre,
    required this.calendrier,
    required this.start,
    required this.end
  });
  final String titre;
  final String projet;
  final DateTime? start;
  final DateTime? end;
  final String calendrier;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.192,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: const Color.fromARGB(117, 116, 111, 98),
        border: Border(left: BorderSide(color: Colors.red, width: 15)),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10,top:10),
            child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titre,maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25,)),
              Text(projet,overflow: TextOverflow.ellipsis, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255))),
                    if(start!=null && end!= null)
                      Text(style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey),
                        "${start?.hour.toString().padLeft(2, '0')}:${start?.minute.toString().padLeft(2, '0')} - "
                        "${end?.hour.toString().padLeft(2, '0')}:${end?.minute.toString().padLeft(2, '0')}",
                      ),
            ])),
          Positioned(bottom: 5, right: 15, child: Text(calendrier, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255)))),
        ],
      ),
    );
  }
}
