import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class NewsWidgets extends StatelessWidget {
  const NewsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 60,
        width: double.infinity,
        color: Colors.amberAccent,
      ),
    );
  }
}
