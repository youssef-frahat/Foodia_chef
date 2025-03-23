import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFFE8C00);

// Custom Back Button Widget
Widget customBackButton(
  BuildContext context, {
  double radius = 10,
  double iconSize = 15,
}) {
  return CircleAvatar(
    radius: radius, // Control the size of the CircleAvatar
    backgroundColor: primaryColor,
    child: IconButton(
      iconSize: iconSize, // Control the size of the icon
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pop(context); // Use the context passed to the widget
      },
    ),
  );
}

TextStyle mainText = TextStyle(
  fontFamily: 'Changa', // Use your desired font family
  fontSize: 14, // Adjust the font size
  fontWeight: FontWeight.bold, // Adjust the font weight
  color: Color(0xFFF8A435), // Adjust the text color
  // Adjust the text decoration
);

TextStyle prices = TextStyle(
  fontFamily: 'Changa', // Use your desired font family
  fontSize: 12, // Adjust the font size
  color: Color(0xFF000000), // Adjust the text color
);
AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: mainText.copyWith(color: Colors.black, fontSize: 20),
    ),
    backgroundColor: const Color(0xFFFFF2CC),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: customBackButton(context),
    ),
    leadingWidth: 50,
  );
}
