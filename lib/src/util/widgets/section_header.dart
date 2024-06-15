
import 'package:flutter/material.dart';
import 'package:wemovies/src/util/widgets/gradient_divider.dart';


class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('NOW PLAYING', style: Theme.of(context).textTheme.bodySmall,),
        const SizedBox(
          width: 16,
        ),
        const Expanded(child: GradientDivider()),
      ],
    );
  }
}
