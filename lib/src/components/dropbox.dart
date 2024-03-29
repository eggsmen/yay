  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class Dropbox extends StatefulWidget {
    final String category;
    final List<String> options;
    final double fontsz;
    final Function(String?) onSelected;

    Dropbox({Key? key, required this.category, required this.options, required this.fontsz, required this.onSelected}) : super(key: key);

    @override
    _DropboxState createState() => _DropboxState();
  }

  class _DropboxState extends State<Dropbox> {
    String? _selectedItem;

    @override
    void initState() {
      super.initState();
      _selectedItem = null; // 초기 값 설정
    }

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Container(
          padding: EdgeInsets.only(left:24,right: 6.0), // 필요에 따라 패딩 조절
          child: DropdownButton<String>(

            isExpanded: true, // 드롭다운을 확장하려면 true로 설정
            value: _selectedItem,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Color(0xff6EA6E9),
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
              widget.onSelected(newValue);
            },
            hint: Center(child: Text(widget.category, style: TextStyle(fontSize: widget.fontsz))),
            items: widget.options
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value, style: TextStyle(fontSize: widget.fontsz))),
              );
            }).toList(),
            dropdownColor: Colors.white,
            focusColor: Colors.transparent,
            // 포커스 색상을 투명하게 설정
          ),
        ),
      );


    }
    Color getForegroundColor(Set<MaterialState> states){
      const interactiveStates = <MaterialState>{
        MaterialState.hovered,
        MaterialState.pressed,
      };
      if(states.any(interactiveStates.contains)) {
        return Color(0xff6EA6E9);
      }
      return Colors.black;
    }}
