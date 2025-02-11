class KhachHang{
  String? maKH;
  String tenKH;
  String userName;
  String email;
  String diaChi;
  String gioiTinh;
  String ngaySinh;
  String dienThoai;
  bool? active;
  String? password;

  KhachHang({
    this.maKH,
    required this.tenKH,
    required this.userName,
    required this.email,
    required this.diaChi,
    required this.gioiTinh,
    required this.ngaySinh,
    required this.dienThoai,
    this.active,
    this.password,
  });

  factory KhachHang.fromJson(Map<String, dynamic> json) {
    return KhachHang(
      maKH: json['maKH'],
      tenKH: json['tenKH'],
      userName: json['userName'],
      email: json['email'],
      diaChi: json['diaChi'],
      gioiTinh: json['gioiTinh'],
      ngaySinh: json['ngaySinh'],
      dienThoai: json['dienThoai'],
      active: json['active'],
      password: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tenKH': tenKH,
      'userName': userName,
      'email': email,
      'pass': password,
      'diaChi': diaChi,
      'gioiTinh': gioiTinh,
      'ngaySinh': ngaySinh,
      'dienThoai': dienThoai,
    };
  }

}