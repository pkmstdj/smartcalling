import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'main.dart';

class CustomEducationInfo extends StatefulWidget {
  final Map<String, dynamic> data;
  CustomEducationInfo({required this.data});
  @override
  _CustomEducationInfoState createState() => _CustomEducationInfoState();
}

class _CustomEducationInfoState extends State<CustomEducationInfo> {
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _entryYearController = TextEditingController();
  final TextEditingController _entryMonthController = TextEditingController();
  final TextEditingController _graduationYearController = TextEditingController();
  final TextEditingController _graduationMonthController = TextEditingController();
  String _status = STATUSLIST[0];

  late bool _entryYearIsValid;
  late bool _entryMonthIsValid;
  late bool _graduationYearIsValid;
  late bool _graduationMonthIsValid;

  @override
  void initState() {
    super.initState();
    _entryYearIsValid = true;
    _entryMonthIsValid = true;
    _graduationYearIsValid = true;
    _graduationMonthIsValid = true;

    _schoolController.text = widget.data['school'];
    _majorController.text = widget.data['major'];
    _entryYearController.text = getDate(widget.data['entry']).year.toString();
    _entryMonthController.text = getDate(widget.data['entry']).month.toString();
    _graduationYearController.text = getDate(widget.data['graduation']).year.toString();
    _graduationMonthController.text = getDate(widget.data['graduation']).month.toString();
    _status = widget.data['status'];
  }

  bool _isValidInput() {
    return _schoolController.text.isNotEmpty &&
        _majorController.text.isNotEmpty &&
        _entryYearIsValid && _entryMonthIsValid &&
        (getEduStatus(_status) || (_graduationYearIsValid && _graduationMonthIsValid));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
          children: <Widget>[
            _buildTextField(_schoolController, '학교명'),
            _buildTextField(_majorController, '전공'),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [_buildStatusDropdown()]),
            _buildDateInput(_entryYearController, _entryMonthController, '입학', _entryYearIsValid, _entryMonthIsValid),
            getEduStatus(_status)
                ? Container()
                : _buildDateInput(_graduationYearController, _graduationMonthController, '졸업', _graduationYearIsValid, _graduationMonthIsValid),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: customGreenAccent,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Text('취소', style: TextStyle(fontSize: 22)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MaterialButton(
                    color: _isValidInput() ? customGreenAccent : Colors.grey,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Text('확인', style: TextStyle(fontSize: 22)),
                    onPressed: _isValidInput()
                        ? () {
                      Map<String, dynamic> data = {
                        'school': _schoolController.text,
                        'major': _majorController.text,
                        'status': _status,
                        'entry': DateFormat('yyyy-MM-dd').format(DateTime(int.parse(_entryYearController.text), int.parse(_entryMonthController.text))),
                        'graduation': getEduStatus(_status)
                            ? '9999-12-01'
                            : DateFormat('yyyy-MM-dd').format(DateTime(int.parse(_graduationYearController.text), int.parse(_graduationMonthController.text))),
                        // 'entryDate': {
                        //   'year': _entryYearController.text,
                        //   'month': _entryMonthController.text,
                        // },
                        // 'graduationDate': _status == "재학" || _status == "휴학"
                        //     ? {'year': '9999', 'month': '12'}
                        //     : {'year': _graduationYearController.text, 'month': _graduationMonthController.text},
                      };
                      Navigator.pop(context, data);
                    }
                        : (){},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
      ;
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 22),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _status,
      items: STATUSLIST.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _status = newValue!;
          if(!getEduStatus(_status)) {
            final time = DateTime.now();
            if(_graduationYearController.text == '9999') {
              _graduationYearController.text = DateFormat('yyyy').format(time);
              _graduationMonthController.text = DateFormat('M').format(time);
            }
          }
        });
      },
    );
  }

  Widget _buildDateInput(TextEditingController yearController, TextEditingController monthController, String labelText, bool yearIsValid, bool monthIsValid) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 22),
            controller: yearController,
            decoration: InputDecoration(
              labelText: labelText + ' 년도',
              errorText: yearIsValid ? null : '1000 ~ 9999',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              int? year = int.tryParse(value);
              if(yearController == _entryYearController) {
                setState(() {
                  _entryYearIsValid = year != null && year >= 1000 && year <= 9999;
                });
              } else {
                setState(() {
                  _graduationYearIsValid = year != null && year >= 1000 && year <= 9999;
                });
              }
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 22),
            controller: monthController,
            decoration: InputDecoration(
              labelText: labelText + ' 월',
              errorText: monthIsValid ? null : '1 ~ 12',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              int? month = int.tryParse(value);
              if(monthController == _entryMonthController) {
                setState(() {
                  _entryMonthIsValid = month != null && month >= 1 && month <= 12;
                });
              } else {
                setState(() {
                  _graduationMonthIsValid = month != null && month >= 1 && month <= 12;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
