import 'package:flutter/material.dart';

class DivierWithWidget extends StatelessWidget
{
  const DivierWithWidget({super.key});

  @override
  Widget build(BuildContext context)
  {
    return const Column(
      children:[
        SizedBox(height: 40.0),
        Divider(),
        SizedBox(height: 40.0),

      ],
    );
  }
}
