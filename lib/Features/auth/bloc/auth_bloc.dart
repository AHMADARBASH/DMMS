import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:flutter/foundation.dart';
import '../../../Core/cache/cached_data.dart';
import '../../../Core/exceptions/exceptions.dart';
import '../../../Core/service_locator/service_locator.dart';
import '../data/models/authenticated_user.dart';
import '../data/repositories/auth_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepo = serviceLocator.get<AuthRepo>();

  void errorHandler(Exception e, Emitter<AuthState> emit) {
    if (e is SocketException) {
      emit(Error(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is EmptyException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is ServerException) {
      emit(Error(errorResponse: e.errorResponse));
    } else if (e is NoInternetException) {
      emit(Error(errorResponse: e.errorResponse));
    } else {
      emit(Error(
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  AuthBloc() : super(Initial()) {
    on<Login>((event, emit) async {
      emit(const Loading());
      try {
        var user = await _authRepo.login(event.credentials);
        emit(Authenticated(user: user));
      } on Exception catch (e) {
        errorHandler(e, emit);
      } catch (e) {
        emit(Error(
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                details: e.toString())));
      }
    });
    on<CheckLoginStatus>(
      (event, emit) {
        var isAuth = CachedData.containsKey(CacheStrings.token);
        if (isAuth) {
          var user = AuthenticatedUser.fromJson(
              json.decode(CachedData.getData(key: CacheStrings.user)!));
          emit(Authenticated(user: user));
        } else {
          emit(const LoggedOut());
        }
      },
    );
    on<CreateBranchAdmin>(
      (event, emit) async {
        try {
          emit(Loading());
          await _authRepo.createBranchAdmin(event.userData);
          emit(UserCreated());
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(Error(
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
    on<CreateNormalUser>(
      (event, emit) async {
        try {
          emit(Loading());
          await _authRepo.createNormalUser(event.userData);
          emit(UserCreated());
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(Error(
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
    on<Logout>(
      (event, emit) async {
        emit(Loading());
        await CachedData.deleteAllData();
        emit(LoggedOut());
      },
    );
    on<UpdateUserData>(
      (event, emit) async {
        emit(Authenticated(user: event.userData));
      },
    );
  }
}
