import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartcalling/mypage/pageResumeEdit.dart';

import 'main.dart';

class AreaSelectionScreen extends StatefulWidget {
  final Map<String, List<String>> selected;
  AreaSelectionScreen({required this.selected});
  @override
  _AreaSelectionScreenState createState() => _AreaSelectionScreenState();
}

class _AreaSelectionScreenState extends State<AreaSelectionScreen> {
  int _selectedProvinceIndex = 0;
  Map<String, List<String>> _selectedCities = {};
  List<Map<String, dynamic>> _provinces = [{'ctp_kor_nm': '전국', 'ctprvn_cd': '00'}];
  List<Map<String, dynamic>> _cities = [{'sig_kor_nm': '전체'}];

  final MAXSELECT = 5;

  final String apiKey = '42990626-829D-3536-9A7C-4D5E3CDB939D';
  Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _selectedCities = Map.from(widget.selected);
    _fetchProvinces();
  }

  void _fetchProvinces() async {
    final url = 'https://api.vworld.kr/req/data?key=$apiKey&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&geomfilter=BOX(13663271.680031825,3894007.9689600193,14817776.555251127,4688953.0631258525)&data=LT_C_ADSIDO_INFO';
    final response = await _dio.get(url);
    final data = response.data as Map<String, dynamic>;
    _provinces += data['response']['result']['featureCollection']['features'].map<Map<String, dynamic>>((item) => item['properties'] as Map<String, dynamic>).toList();
    setState(() {});
  }

  void _fetchCities(String code) async {
    _cities = [{'sig_kor_nm': '전체'}];
    if (code != '00') {
      final url = 'https://api.vworld.kr/req/data?key=$apiKey&service=data&version=2.0&request=getfeature&format=json&size=1000&page=1&geometry=false&attribute=true&crs=EPSG:3857&attrFilter=sig_cd:like:$code&data=LT_C_ADSIGG_INFO';
      final response = await _dio.get(url);
      final data = response.data as Map<String, dynamic>;
      _cities += data['response']['result']['featureCollection']['features'].map<Map<String, dynamic>>((item) => item['properties'] as Map<String, dynamic>).toList();
    }
    setState(() {});
  }

  bool _isSelectedCity(String city) {
    final selectedProvince = _selectedCities[_provinces[_selectedProvinceIndex]['ctp_kor_nm']];
    return selectedProvince != null && selectedProvince.contains(city);
  }

  int _countSelectedCities() {
    int count = 0;
    _selectedCities.values.forEach((cities) {
      count += cities.length;
    });
    return count;
  }

  String selectedAreas() {
    if (_selectedCities.isEmpty) {
      return '';
    } else {
      return _selectedCities.entries.map((entry) {
        String province = entry.key;
        List<String> cities = entry.value;
        return '$province ${cities.join(', ')}';
      }).join(', ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: customGreenAccent,
          icon: Icon(Icons.arrow_back),
        ),
        title: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Text('선택지역 (${_countSelectedCities()}/$MAXSELECT)', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: customGreenAccent),
            onPressed: () {
              Navigator.pop(context, _selectedCities);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          buildSelectedAreaClips(_selectedCities),
          Divider(thickness: 1,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _provinces.length,
                    itemBuilder: (context, index) {
                      final province = _provinces[index];
                      return ListTile(
                        title: Text(province['ctp_kor_nm'], style: TextStyle(fontSize: 20),),
                        onTap: () {
                          setState(() {
                            _selectedProvinceIndex = index;
                            _fetchCities(province['ctprvn_cd']);
                          });
                        },
                      );
                    },
                  ),
                ),
                VerticalDivider(thickness: 1,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _cities.length,
                    itemBuilder: (context, index) {
                      final city = _cities[index]['sig_kor_nm'];
                      final isSelected = _isSelectedCity(city);
                      return ListTile(
                        title: Text(city, style: TextStyle(fontSize: 20),),
                        trailing: isSelected ? Icon(Icons.check, color: customGreenAccent) : null,
                        onTap: () {
                          if (_countSelectedCities() < MAXSELECT || isSelected) {
                            setState(() {
                              String provinceName = _provinces[_selectedProvinceIndex]['ctp_kor_nm'];
                              if (_selectedCities[provinceName] == null) {
                                _selectedCities[provinceName] = [];
                              }
                              if (!isSelected) {
                                _selectedCities[provinceName]!.add(city);
                                // When '전체' is selected, remove all other selected cities in this province.
                                if (city == '전체') {
                                  _selectedCities[provinceName] = ['전체'];
                                }
                              } else {
                                _selectedCities[provinceName]!.remove(city);
                              }
                              // When a city is selected and '전체' is already selected, remove '전체'.
                              if (city != '전체' && _selectedCities[provinceName]!.contains('전체')) {
                                _selectedCities[provinceName]!.remove('전체');
                              }
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}