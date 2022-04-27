import 'package:flutter/material.dart';

class IconDesgin extends StatelessWidget {
  const IconDesgin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              widthFactor: 100,
              child: Container(
                width: 20,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(
                    255,
                    32,
                    211,
                    234,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              widthFactor: 100,
              child: Container(
                width: 20,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(
                    255,
                    250,
                    45,
                    108,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              widthFactor: 100,
              child: Container(
                width: 50,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            )
          ],
        ));
  }
}