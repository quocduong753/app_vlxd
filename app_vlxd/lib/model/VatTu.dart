import 'package:app_vlxd/model/LoaiVT.dart';

class VatTu {
  final String ma;
  final String ten;
  final String dvt;
  final double donGia;
  final String image;
  final LoaiVT loaiVT;

  VatTu({
    required this.ma,
    required this.ten,
    required this.dvt,
    required this.donGia,
    required this.image,
    required this.loaiVT,
  });

  factory VatTu.fromJson(Map<String, dynamic> json) {
    return VatTu(
      ma: json['ma'],
      ten: json['ten'],
      dvt: json['dvt'],
      donGia: json['donGia'],
      image: json['image'],
      loaiVT: LoaiVT.fromJson(json['loaivt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ma': ma,
      'ten': ten,
      'dvt': dvt,
      'donGia': donGia,
      'image': image,
      'loaivt': loaiVT.toJson(),
    };
  }
}