import 'package:flutter/material.dart';

class CardListContainer extends StatelessWidget {
  final Widget child;
  CardListContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
