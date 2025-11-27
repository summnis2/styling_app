import 'package:flutter/material.dart';

List<String> categories = ['상의', '하의', '아우터', '원피스', '신발', '가방', '패션소품'];

Map<String, List<String>> subcategories = {
  "상의": ["니트", "셔츠", "블라우스", "조끼", "후드", "맨투맨", "반팔티", "민소매"],
  "하의": ["슬랙스", "롱팬츠", "숏팬츠", "데님", "기모바지"],
  "아우터": ["패딩", "코트", "집업/점퍼", "자켓", "플리스", "가디건", "야상"],
  "원피스": ["롱원피스", "미니원피스", "투피스"],
  "신발": ["스니커즈", "워커/부츠", "플랫/로퍼", "힐", "샌들", "슬리퍼/쪼리"],
  "가방": ["크로스백", "토트백", "클러치", "에코백", "백팩", "파우치"],
  "패션소품": ["모자", "머플러/스카프", "시계", "벨트"]
};

List<String> styles = [
  '캐주얼',
  '스트릿',
  '스포티',
  '격식',
  '아웃도어',
  '빈티지',
  '시크',
];

String _selectedValue1 = categories.first;
String? _selectedValue2;
String? _selectedValue3;

class ClothesDropdown extends StatefulWidget {
  //const ClothesDropdown({super.key});
  final void Function(String?) onItemSelected1; // 새로운 라인 추가
  final void Function(String?) onItemSelected2;
  final void Function(String?) onItemSelected3;
  const ClothesDropdown(
      {required this.onItemSelected1,
      required this.onItemSelected2,
      required this.onItemSelected3}); // 수정된 라인

  @override
  State<ClothesDropdown> createState() => _ClothesDropdownState();
}

class _ClothesDropdownState extends State<ClothesDropdown> {
  @override
  Widget build(BuildContext context) {
    //화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          child: Row(children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.04, top: screenHeight * 0.005),
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              width: screenWidth * 0.92,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              child: DropdownButton<String>(
                value: _selectedValue1,
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue1 = newValue!;
                    // 첫 번째 드롭다운이 변경되면 두 번째 드롭다운의 값을 첫 번째 드롭다운에 맞게 업데이트
                    _selectedValue2 = subcategories[_selectedValue1]![0];
                    widget.onItemSelected1(_selectedValue1); // 변경된 라인
                  });
                },
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              ),
            ),
          ]),
        ),
        //옷 종류 ==========================
        Container(
          padding: EdgeInsets.only(left: 18.0),
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Text(
                "종류",
                style: TextStyle(
                    color: Colors.black, fontSize: 22, fontFamily: 'Jua'),
              ),
              Expanded(
                  child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 18.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              )),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: screenWidth * 0.04, top: screenHeight * 0.005),
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                width: screenWidth * 0.92,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                child: Container(
                  child: DropdownButton<String>(
                    value: _selectedValue2,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedValue2 = newValue!;
                        widget.onItemSelected2(_selectedValue2); // 변경된 라인
                      });
                    },
                    items: subcategories[_selectedValue1]!
                        .map((subcategory) => DropdownMenuItem(
                              value: subcategory,
                              child: Text(subcategory),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 18.0),
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Text(
                "스타일",
                style: TextStyle(
                    color: Colors.black, fontSize: 22, fontFamily: 'Jua'),
              ),
              Expanded(
                  child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 18.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              )),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.005),
          padding: EdgeInsets.only(left: screenWidth * 0.03),
          width: screenWidth * 0.92,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: Container(
              child: DropdownButton(
            value: _selectedValue3,
            items: styles
                .map((e) => DropdownMenuItem(
                      value: e, // 선택 시 onChanged 를 통해 반환할 value
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              // items 의 DropdownMenuItem 의 value 반환
              setState(() {
                _selectedValue3 = value!;
                widget.onItemSelected3(_selectedValue3);
              });
            },
          )),
        ),
      ],
    );
  }
}
