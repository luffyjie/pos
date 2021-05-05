// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_in_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CashInStore on _CashInStore, Store {
  final _$dataAtom = Atom(name: '_CashInStore.data');

  @override
  List<ChannelModel> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(List<ChannelModel> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$_CashInStoreActionController = ActionController(name: '_CashInStore');

  @override
  void changeData(List<ChannelModel> value) {
    final _$actionInfo = _$_CashInStoreActionController.startAction(
        name: '_CashInStore.changeData');
    try {
      return super.changeData(value);
    } finally {
      _$_CashInStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data}
    ''';
  }
}
