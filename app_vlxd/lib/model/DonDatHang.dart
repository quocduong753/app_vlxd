import 'package:app_vlxd/model/VatTuDetail.dart';

class DonDatHang {
  final String ma;
  final DateTime ngayDat;
  final String diaChiGiaoHang;
  final int tongTien;
  final bool trangThai;
  final List<VatTuDetail> muaList;

  DonDatHang({
    required this.ma,
    required this.ngayDat,
    required this.diaChiGiaoHang,
    required this.tongTien,
    required this.trangThai,
    required this.muaList,
  });

  factory DonDatHang.fromJson(Map<String, dynamic> json) {
    return DonDatHang(
      ma: json['ma'],
      ngayDat: DateTime.parse(json['ngayDat']),
      diaChiGiaoHang: json['diaChiGiaoHang'],
      tongTien: json['tongTien'],
      trangThai: json['trangThai'],
      muaList: (json['muaList'] as List)
          .map((item) => VatTuDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ngayDat': ngayDat.toIso8601String(),
      'diaChiGiaoHang': diaChiGiaoHang,
      'tongTien': tongTien,
      'muaList': muaList.map((item) => item.toJson()).toList(),
    };
  }
}
