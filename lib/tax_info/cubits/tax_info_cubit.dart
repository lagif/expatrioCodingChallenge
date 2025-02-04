import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coding_challenge/api/client/exceptions.dart';
import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:coding_challenge/api/services/user_manager.dart';
import 'package:coding_challenge/tax_info/cubits/tax_info_state.dart';
import 'package:coding_challenge/tax_info/repository/tax_info_repository.dart';

///
/// getting user's tax info and setting modified data
/// also, this cubit is located in global Build context
/// and therefore may use global UserManager to save an remove
/// the user's tax data from secure storage
///
class TaxInfoCubit extends Cubit<TaxInfoState> {
  final TaxInfoRepository taxInfoRepository;
  final UserManager userManager;

  TaxInfoCubit({required this.taxInfoRepository, required this.userManager})
      : super(TaxInfoInitial());

  ///
  /// load information first from secure storage,
  /// then, if empty, from the API
  ///
  Future<void> load() async {
    final loggedUser = userManager.getLoggedInUser();

    if (loggedUser == null) {
      emit(TaxInfoError(HttpErrorException(
          errorCode: 401, errorMessage: "Unauthorized error")));
      return;
    }
    emit(TaxInfoLoading());

    try {
      final storedTaxInfo = await userManager.storedTaxInfo();
      if (storedTaxInfo != null) {
        emit(TaxInfoSuccess(storedTaxInfo));
        return;
      }

      final userTaxInfo = await taxInfoRepository.getTaxInfo(
        "${loggedUser.id}",
        loggedUser.accessToken,
      );
      emit(TaxInfoSuccess(userTaxInfo));
    } catch (e) {
      _handleError(e);
    }
  }

  ///
  /// save tax data on the backend and then
  /// in the secure storage
  ///
  Future<void> setTaxInfo(TaxInfo taxInfo) async {
    final loggedUser = userManager.getLoggedInUser();

    if (loggedUser == null) {
      emit(TaxInfoError(HttpErrorException(
          errorCode: 401, errorMessage: "Unauthorized error")));
      return;
    }

    emit(TaxInfoLoading());

    try {
      await userManager.setUserTaxInfo(taxInfo);
      await taxInfoRepository.setTaxInfo(
        "${loggedUser.id}",
        taxInfo,
        loggedUser.accessToken,
      );
      emit(TaxInfoSuccess(taxInfo));
    } catch (e) {
      _handleError(e);
    }
  }

  _isUnauthorizedError(dynamic e) {
    return e is HttpErrorException && e.errorCode == 400 || e.errorCode == 401;
  }

  /// Notice: errors should be unified more carefully
  _handleError(e) {
    emit(TaxInfoError(e));
    if (_isUnauthorizedError(e)) {
      userManager.logOut();
    }
  }
}
