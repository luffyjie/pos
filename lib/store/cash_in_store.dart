import 'package:mobx/mobx.dart';
import 'package:pos/models/channe_model.dart';

part 'cash_in_store.g.dart';

class CashInStore = _CashInStore with _$CashInStore;

abstract class _CashInStore with Store {
  @observable
  List<ChannelModel> data = [];

  @action
  void changeData(List<ChannelModel> value) => data = value;
}
