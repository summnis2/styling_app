class Style {
  List<String> returnStyle(int temp) {
    //4도 이하
    if (temp <= 4) {
      return ['코트', '니트', '기모바지'];
      //5-8도
    } else if (temp <= 8 && temp >= 5) {
      return ['코드', '니트', '기모바지', '레깅스'];
      //9~11도
    } else if (temp <= 11 && temp >= 9) {
      return ['코트', '야상', '자켓', '니트', '데님'];
      //12~16도
    } else if (temp <= 16 && temp >= 12) {
      return ['자켓', '가디건', '야상', '후드티', '데님'];
      //17~19도
    } else if (temp <= 19 && temp >= 17) {
      return ['가디건', '맨투맨', '데님'];
      //20-22도
    } else if (temp <= 22 && temp >= 20) {
      return ['블라우스', '셔츠', '조끼', '데님', '롱팬츠'];
      //23~27도
    } else if (temp <= 27 && temp >= 23) {
      return ['반팔티', '숏팬츠'];
      //28도 이상
    } else {
      return ['반팔티', '민소매', '숏팬츠'];
    }
  }
}
