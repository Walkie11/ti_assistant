import 'package:ti_asistan/service/apiService.dart';

abstract class Iobjectprovider<T> {
  bool isLoading = false;
  List<T> objets = [];
  Apiservice api = Apiservice();
  void charger(List<T> objets);
  void initialiser();
}
