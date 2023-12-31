import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final bool horizontal;

  const AddButton(
      {super.key,
      required this.onTap,
      required this.width,
      this.horizontal = false,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: horizontal
                ? const Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                      ),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                      ),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
