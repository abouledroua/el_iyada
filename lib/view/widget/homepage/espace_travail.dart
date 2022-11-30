import 'package:flutter/material.dart';
import '../../../core/constant/sizes.dart';
import 'espace_travail_widget.dart';
import 'menu_principal.dart';

class EspaceTravail extends StatelessWidget {
  const EspaceTravail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: EspaceTravailWidget()),
      Container(
          constraints: BoxConstraints(maxWidth: AppSizes.widthScreen / 6),
          child: MenuPrincipal())
    ]);
  }
}
