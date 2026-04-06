import 'package:flutter/cupertino.dart';

class CupertinoStepper extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String suffix;
  final String semanticLabel;

  const CupertinoStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.suffix = '',
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: '$semanticLabel 감소',
          button: true,
          excludeSemantics: true,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: value > min ? () => onChanged(value - 1) : null,
            child: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Semantics(
              label: semanticLabel,
              value: '${value.toInt()}$suffix',
              child: ExcludeSemantics(
                child: Text('${value.toInt()}$suffix'),
              ),
            ),
          ),
        ),
        Semantics(
          label: '$semanticLabel 증가',
          button: true,
          excludeSemantics: true,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: value < max ? () => onChanged(value + 1) : null,
            child: const Icon(CupertinoIcons.add_circled),
          ),
        ),
      ],
    );
  }
}
