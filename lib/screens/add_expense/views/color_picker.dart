import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
  });

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx2) {
            Color categoryColor = Colors.white;
            return Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ColorPicker(
                        pickerColor: Colors.blue,
                        onColorChanged: (value) {
                          setState(() {
                            categoryColor = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: Colors.green[900],
                          ),
                          onPressed: () {
                            Navigator.pop(ctx2);
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.palette,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
        hintText: 'Color',
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
