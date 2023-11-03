import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({super.key, this.imageSize = 150});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 25,
                offset: Offset(0, 20),
              )
            ],
          ),
          child: ClipOval(
              child: Image.network(
            'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png',
            width: imageSize,
            height: imageSize,
          )),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.pink,
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              onPressed: () {}),
        )
      ],
    );
  }
}
