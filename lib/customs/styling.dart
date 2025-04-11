import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFE8C00);

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

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final IconData iconData;
  final String? Function(String?)? validator; // Add validator parameter
  final TextInputType? keyboardType; // Add keyboard type parameter

  const CustomTextField({
    super.key,
    required this.hint,
    required this.iconData,
    required this.controller,
    this.isPassword = false,
    this.validator, // Optional validator
    this.keyboardType, // Optional keyboard type
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator, // Use the provided validator
      keyboardType: widget.keyboardType, // Use the provided keyboard type
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: mainText.copyWith(color: Colors.blueGrey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.orange, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.orange, width: 5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red, width: 5),
        ),
        prefixIcon: Icon(widget.iconData),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        errorStyle: mainText.copyWith(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
}

ElevatedButton elevatedButton({
  required String text,
  double width = 320,
  double height = 51,
  double fontSize = 14,
  Color color = primaryColor,
  Color textColor = Colors.white,
  required void Function() onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      minimumSize: Size(width, height),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: mainText.copyWith(color: textColor, fontSize: fontSize),
    ),
  );
}
