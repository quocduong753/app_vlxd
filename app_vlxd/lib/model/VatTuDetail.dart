
import 'package:app_vlxd/model/VatTu.dart';

class VatTuDetail{
  VatTu vatTu;
  double soLuong;
  int gia;


  VatTuDetail({
    required this.vatTu,
    required this.soLuong,
    required this.gia
  });

  VatTuDetail.fromVatTu(this.vatTu, this.soLuong)
      : gia = (vatTu.donGia * soLuong).toInt();

  Map<String, dynamic> toJson() {
    return {
      "maVatTu": vatTu.ma,
      "sl": soLuong,
      "gia": gia,
    };
  }
  
  factory VatTuDetail.fromJson(Map<String, dynamic> json){
    return VatTuDetail(
        vatTu: VatTu.fromJson(json['vatTu']),
        soLuong: json['sl'],
        gia: json['gia']);
  }
}