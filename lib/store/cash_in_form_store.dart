import 'package:mobx/mobx.dart';

part 'cash_in_form_store.g.dart';

class CashInFormStore = _CashInFormStore with _$CashInFormStore;

abstract class _CashInFormStore with Store {
  @observable
  bool walletInsufficient = false;
  @observable
  bool phoneFocus = false;
  @observable
  bool amountFoucs = false;

  @action
  showPhoneFocus() {
    phoneFocus = true;
  }

  @action
  hiddenPhoneFocus() {
    phoneFocus = false;
  }

  @action
  showAmountFoucs() {
    amountFoucs = true;
  }

  @action
  hiddenAmountFoucs() {
    amountFoucs = false;
  }

  @action
  showWalletInsufficientNotice() {
    walletInsufficient = true;
  }

  @action
  hiddenWalletInsufficientNotice() {
    walletInsufficient = false;
  }
}
