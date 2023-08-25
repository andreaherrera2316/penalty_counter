import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter(
      {required this.width,
      required this.height,
      required this.teamName,
      required this.penalties,
      required this.teamColor,
      super.key});
  final double width;
  final double height;
  final String teamName;
  final List<bool?> penalties;
  final Color teamColor;

  Icon getIcon(bool? penalty) {
    if (penalty == null) {
      return Icon(Icons.check_box_outline_blank, color: Colors.blueGrey[200]);
    } else if (penalty) {
      return Icon(Icons.check_box_outlined, color: Colors.greenAccent[400]);
    } else {
      return Icon(Icons.indeterminate_check_box_outlined,
          color: Colors.redAccent[400]);
    }
  }

  @override
  Widget build(BuildContext context) {
    const widgetBg = Color(0xffFFFDF6);
    var cornerRadius = const Radius.circular(20);

    var name = Container(
      decoration: BoxDecoration(
          color: teamColor,
          borderRadius:
              BorderRadius.only(topLeft: cornerRadius, topRight: cornerRadius)),
      width: width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            teamName,
            style: const TextStyle(
                fontSize: 24, color: widgetBg, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );

    List<Widget> penaltyBoxes = [];

    for (int i = 0; i < penalties.length; i++) {
      penaltyBoxes.add(Expanded(
          child: Container(
        height: height - 36,
        decoration: BoxDecoration(
            color: i % 2 == 0 ? Colors.blueGrey[50] : Colors.transparent,
            borderRadius: i == 0
                ? BorderRadius.only(bottomLeft: cornerRadius)
                : i == penalties.length - 1
                    ? BorderRadius.only(bottomRight: cornerRadius)
                    : BorderRadius.zero),
        child: getIcon(penalties[i]),
      )));
    }

    var shots = SizedBox(
        width: width,
        child: Row(
          children: penaltyBoxes,
        ));

    return Container(
      decoration: BoxDecoration(
        color: widgetBg,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.blueGrey[50]!),
      ),
      height: height,
      width: width,
      child: Column(
        children: [name, shots],
      ),
    );
  }
}
