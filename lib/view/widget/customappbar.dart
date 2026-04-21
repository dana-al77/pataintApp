import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class CustomAppBar extends StatelessWidget {
  final String titleappbar;
  final void Function()? onpressedSearch;
  final void Function(String)? onChanged;
  final TextEditingController mycontroller;

  final String searchType;
  final void Function(String) onSearchTypeChanged;

  const CustomAppBar({
    Key? key,
    required this.titleappbar,
    this.onpressedSearch,
    required this.onChanged,
    required this.mycontroller,
    required this.searchType,
    required this.onSearchTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: mycontroller,
              onChanged: onChanged,
              style: TextStyle(color: AppColor.black),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onpressedSearch,
                ),
                hintText: titleappbar,
                hintStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(width: 10),

          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: searchType,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'name',
                    child: Text('الاسم', textAlign: TextAlign.center),
                  ),
                  DropdownMenuItem(
                    value: 'category',
                    child: Text('الفئة', textAlign: TextAlign.center),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    onSearchTypeChanged(val);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
