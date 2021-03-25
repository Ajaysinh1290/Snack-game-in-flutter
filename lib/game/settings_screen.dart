import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snack_game/utils/color_pallette.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.canvasColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.grey[400],
          ),
        ),
        title: Text(
          'SETTINGS',
          style: GoogleFonts.aBeeZee(color: Colors.white, letterSpacing: 5),
        ),
        elevation: 0,
        backgroundColor: ColorPallette.canvasColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSettings('Snack Color',),
          TitleSettings('Egg Color'),
          TitleSettings('Snack Shape'),
          TitleSettings('Egg Shape'),
          TitleSettings('Speed'),
          TitleSettings('Sound')
        ],
      ),
    );
  }
}

class TitleSettings extends StatelessWidget {
  final text;
  TitleSettings(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.aBeeZee(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.grey[200]),
      ),
    );
  }
}
