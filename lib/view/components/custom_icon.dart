import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomIcon extends StatelessWidget {
  final String? iconCode;
  final double? size;

  const CustomIcon({super.key, required this.iconCode, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(
        int.parse(iconCode ?? MdiIcons.currencyRupee.codePoint.toString()),
        fontFamily: 'Material Design Icons',
        fontPackage: 'material_design_icons_flutter',
      ),
      size: size,
    );
  }
}
