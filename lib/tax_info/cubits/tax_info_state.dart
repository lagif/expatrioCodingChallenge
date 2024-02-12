import 'package:coding_challenge/api/model/tax_info.dart';

sealed class TaxInfoState {}

class TaxInfoPending implements TaxInfoState {}

class TaxInfoLoading implements TaxInfoState {}

class TaxInfoInitial implements TaxInfoState {}

class TaxInfoError<T> implements TaxInfoState {
  final T error;

  TaxInfoError(this.error);
}

class TaxInfoSuccess implements TaxInfoState {
  final TaxInfo taxInfo;

  TaxInfoSuccess(this.taxInfo);
}
