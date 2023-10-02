import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcalling/main.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final String title;
  final bool check;

  CustomDatePicker({required this.initialDate, required this.title, required this.check});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late bool _yearIsValid;
  late bool _monthIsValid;
  late bool _dayIsValid;

  @override
  void initState() {
    super.initState();
    _yearController = TextEditingController(text: widget.initialDate.year.toString());
    _monthController = TextEditingController(text: widget.initialDate.month.toString());

    int daysInMonth = DateTime(widget.initialDate.year, widget.initialDate.month + 1, 0).day;
    _dayController = TextEditingController(text: widget.initialDate.day.toString());

    _yearIsValid = true;
    _monthIsValid = true;
    _dayIsValid = widget.initialDate.day <= daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        ),
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [Text(widget.title, style: TextStyle(color: customGreenAccent, fontSize: 26, ), textAlign: TextAlign.left,)],),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(context, _yearController, 'Year', 1000, 9999, _yearIsValid),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: _buildTextField(context, _monthController, 'Month', 1, 12, _monthIsValid),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: _buildTextField(context, _dayController, 'Day', 1,
                      DateTime(int.parse(_yearController.text), int.parse(_monthController.text) + 1, 0).day, _dayIsValid),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: MaterialButton(
                  color: customGreenAccent,
                  padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                  child: Text('취소', style: TextStyle(color:Colors.white, fontSize: 22)),
                  onPressed: () => Navigator.pop(context),
                )),
                SizedBox(width: 25),
                Expanded(child: MaterialButton(
                  color: (_yearIsValid && _monthIsValid && _dayIsValid) ? customGreenAccent : Colors.grey,
                  padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                  child: Text('확인', style: TextStyle(color:Colors.white, fontSize: 22)),
                  onPressed: (_yearIsValid && _monthIsValid && _dayIsValid) ? () {
                    DateTime time = DateTime(
                      int.parse(_yearController.text),
                      int.parse(_monthController.text),
                      int.parse(_dayController.text),
                      0,
                      0,
                      0,
                      0
                    );
                    if(widget.check) {
                      DateTime now = DateTime.now();
                      if(time.microsecondsSinceEpoch < now.microsecondsSinceEpoch) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('날짜를 확인해 주세요.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                      else {
                        Navigator.pop(context, time);
                      }
                    }
                    else {
                      Navigator.pop(context, time);
                    }
                  } : (){},
                )),
              ],
            )
          ],
        ),
      );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller, String labelText, int min, int max, bool isValid) {
    return TextField(
      controller: controller,
      style: TextStyle(color:Colors.black, fontSize: 22),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      onChanged: (value) {
        if(value.isEmpty) {
          controller.text = '0';
        }
        setState(() {
          if (value.isEmpty || int.tryParse(value) == null || int.parse(value) < min || int.parse(value) > max) {
            switch (labelText) {
              case 'Year':
                _yearIsValid = false;
                break;
              case 'Month':
                _monthIsValid = false;
                break;
              default:
                _dayIsValid = false;
                break;
            }
          } else {
            switch (labelText) {
              case 'Year':
                _yearIsValid = true;
                break;
              case 'Month':
                _monthIsValid = true;
                break;
              default:
                _dayIsValid = true;
                break;
            }
          }
        });
      },
      decoration: InputDecoration(
        labelText: labelText,
        errorText: isValid ? null : 'Invalid value',
      ),
    );
  }
}
