import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;
  const IconContainer({super.key, required this.size}) : assert(size > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.15),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 25),
          )
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/LOGO-COLD-CHAIN.svg',
          width: size * 0.80,
          height: size * 0.80,
        ),
      ),
    );
  }
}
