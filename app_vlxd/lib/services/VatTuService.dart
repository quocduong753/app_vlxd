import 'package:app_vlxd/model/VatTu.dart';
import 'package:app_vlxd/services/ApiService.dart';

class VatTuService extends ApiService {

  // Phương thức lấy tất cả vật tư
  Future<List<VatTu>> fetchVatTu() async {
    return fetchData('vattu', (json) => VatTu.fromJson(json));
  }

  // Phương thức tìm kiếm vật tư theo từ khóa
  Future<List<VatTu>> searchVatTu(String keyword) async {
    return fetchData(
      'vattu/search?keyword=$keyword',
          (json) => VatTu.fromJson(json),
    );
  }
}