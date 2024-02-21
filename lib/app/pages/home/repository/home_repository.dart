import 'package:colorword_new/app/models/word_model.dart';
import 'package:colorword_new/app/pages/home/service/home_service.dart';
import 'package:colorword_new/app/pages/home/service/home_service_interface.dart';

/// Repository katmanı kullanılacak verilerin hangi kaynaktan alınacağını yönettiğimiz bölümdür.
/// Örneğin, debug veya test sırasında verilerimizi mock servisimizden alırken release modda gerçek servis üzerinden almamız gerekebilir
/// Bu tarz durumlarda veya release mod sırasında verilerimizi cache servisinden, yerel veri tabanından veya gerçek servisimiz üzerinden almamız gerektiğinde
/// bu işlemleri buradan yönetiriz.
///
///Viewmodel repository'i, repostoriy ise service'i çağıracak.

class HomeRepository implements IHomeService {
  final HomeService _homeService = HomeService();

  @override
  Future<bool> deleteWord(Word? word) async {
    return await _homeService.deleteWord(word);
  }

  @override
  Future<List<Word?>?> readWords() async {
    return await _homeService.readWords();
  }
}
