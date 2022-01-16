import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 300.0, // TODO: Borrar cuando exista contenido
        decoration: _CardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _CardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(10, 10),
          ),
        ],
      );
}
