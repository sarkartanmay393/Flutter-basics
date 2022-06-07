import 'package:flutter/material.dart';

class StoryGrid extends StatelessWidget {
  const StoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.5,
              blurRadius: 0.5,
              blurStyle: BlurStyle.normal,
              offset: Offset(0, 0.1),
            ),
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Gurudongmar",
                  style: Theme.of(context).textTheme.bodyText1?.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ),
                Text(
                  "North Sikkim",
                  style: Theme.of(context).textTheme.caption?.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
