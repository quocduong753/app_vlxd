class LoaiVT {
  final String ma;
  final String tenLoai;

  LoaiVT({required this.ma, required this.tenLoai});

  factory LoaiVT.fromJson(Map<String, dynamic> json) {
    return LoaiVT(
      ma: json['ma'],
      tenLoai: json['tenLoai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ma': ma,
      'tenLoai': tenLoai,
    };
  }
}