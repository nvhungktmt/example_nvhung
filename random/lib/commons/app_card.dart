import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final GestureTapCallback? onTap;
  const AppCard({Key? key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 4,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: child,
            ),
          ),
        ));
  }
}
