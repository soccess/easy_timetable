import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';

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
    return Semantics(
      label: semanticLabel,
      value: '${value.toInt()}$suffix',
      onIncrease: value < max ? () => onChanged(value + 1) : null,
      onDecrease: value > min ? () => onChanged(value - 1) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: value > min ? () => onChanged(value - 1) : null,
            child: const ExcludeSemantics(child: Icon(CupertinoIcons.minus_circle)),
          ),
          SizedBox(
            width: 40,
            child: Center(
              child: ExcludeSemantics(
                child: Text('${value.toInt()}$suffix'),
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: value < max ? () => onChanged(value + 1) : null,
            child: const ExcludeSemantics(child: Icon(CupertinoIcons.add_circled)),
          ),
        ],
      ),
    );
  }
}
