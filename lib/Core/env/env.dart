import 'package:envied/envied.dart';
part 'env.g.dart'; // generated file

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'BASE_URL')
  static String baseUrl = _Env.baseUrl;
}
