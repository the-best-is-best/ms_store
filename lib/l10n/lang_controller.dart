import 'package:get/get.dart';
import 'languages/ar_lang.dart';
import 'languages/en_lang.dart';

class LangController implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': EnLang.init(),
        'ar': ArLang.init(),
      };
}
