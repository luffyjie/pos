// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_in_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CashInFormStore on _CashInFormStore, Store {
  final _$walletInsufficientAtom =
      Atom(name: '_CashInFormStore.walletInsufficient');

  @override
  bool get walletInsufficient {
    _$walletInsufficientAtom.reportRead();
    return super.walletInsufficient;
  }

  @override
  set walletInsufficient(bool value) {
    _$walletInsufficientAtom.reportWrite(value, super.walletInsufficient, () {
      super.walletInsufficient = value;
    });
  }

  final _$phoneFocusAtom = Atom(name: '_CashInFormStore.phoneFocus');

  @override
  bool get phoneFocus {
    _$phoneFocusAtom.reportRead();
    return super.phoneFocus;
  }

  @override
  set phoneFocus(bool value) {
    _$phoneFocusAtom.reportWrite(value, super.phoneFocus, () {
      super.phoneFocus = value;
    });
  }

  final _$amountFoucsAtom = Atom(name: '_CashInFormStore.amountFoucs');

  @override
  bool get amountFoucs {
    _$amountFoucsAtom.reportRead();
    return super.amountFoucs;
  }

  @override
  set amountFoucs(bool value) {
    _$amountFoucsAtom.reportWrite(value, super.amountFoucs, () {
      super.amountFoucs = value;
    });
  }

  final _$_CashInFormStoreActionController =
      ActionController(name: '_CashInFormStore');

  @override
  dynamic showPhoneFocus() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.showPhoneFocus');
    try {
      return super.showPhoneFocus();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic hiddenPhoneFocus() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.hiddenPhoneFocus');
    try {
      return super.hiddenPhoneFocus();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showAmountFoucs() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.showAmountFoucs');
    try {
      return super.showAmountFoucs();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic hiddenAmountFoucs() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.hiddenAmountFoucs');
    try {
      return super.hiddenAmountFoucs();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showWalletInsufficientNotice() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.showWalletInsufficientNotice');
    try {
      return super.showWalletInsufficientNotice();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic hiddenWalletInsufficientNotice() {
    final _$actionInfo = _$_CashInFormStoreActionController.startAction(
        name: '_CashInFormStore.hiddenWalletInsufficientNotice');
    try {
      return super.hiddenWalletInsufficientNotice();
    } finally {
      _$_CashInFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
walletInsufficient: ${walletInsufficient},
phoneFocus: ${phoneFocus},
amountFoucs: ${amountFoucs}
    ''';
  }
}
