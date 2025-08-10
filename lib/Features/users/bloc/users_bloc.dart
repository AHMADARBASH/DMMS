import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/exceptions/exceptions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:dmms/Core/service_locator/service_locator.dart';
import 'package:dmms/Features/users/data/models/user.dart';
import 'package:dmms/Features/users/data/repositories/users_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:easy_localization/easy_localization.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _repo = serviceLocator.get<UsersRepository>();
  List<User> _allItems = [];
  void errorHandler(Exception e, Emitter<UsersState> emit) {
    if (e is SocketException) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is EmptyException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is ServerException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else if (e is NoInternetException) {
      emit(state.copyWith(isLoading: false, errorResponse: e.errorResponse));
    } else {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  UsersBloc() : super(UsersState()) {
    on<Search>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));
        if (event.query.isEmpty) {
          emit(state.copyWith(
              isLoading: false, users: _allItems, errorResponse: null));
        } else {
          List<User> filtered = _allItems
              .where((u) =>
                  u.firstName
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  u.lastName
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  u.nationalId
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  u.userName.toLowerCase().contains(event.query.toLowerCase()))
              .toList();
          emit(state.copyWith(
              isLoading: false, users: filtered, errorResponse: null));
        }
      } on Exception catch (e) {
        errorHandler(e, emit);
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                details: e.toString())));
      }
    }, transformer: restartable());

    on<ResetFlags>((event, emit) {
      emit(state.copyWith(
        errorResponse: null,
        passwordReseted: false,
        userUpdated: false,
        userActivated: false,
        userDeActivated: false,
      ));
    });
    on<GetAllUsers>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true, errorResponse: null));
          final users = await _repo.getAllUsers();
          _allItems = users;
          emit(state.copyWith(
              isLoading: false, users: users, errorResponse: null));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
    on<UpdateUserInfo>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true, errorResponse: null));
          await _repo.updateUserInfo(data: event.data);
          final users = await _repo.getAllUsers();
          _allItems = users;
          emit(state.copyWith(
            isLoading: false,
            userUpdated: true,
            errorResponse: null,
            users: users,
          ));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
    on<DeActivateUser>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true, errorResponse: null));
          await _repo.deActivateUser(userId: event.userId);
          var updatedUsers = state.users.map((user) {
            return user.id == event.userId
                ? user.copyWith(isActive: false)
                : user;
          }).toList();
          _allItems = updatedUsers;
          emit(state.copyWith(
              isLoading: false,
              userDeActivated: true,
              errorResponse: null,
              users: updatedUsers));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
    on<ActivateUser>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true, errorResponse: null));
          await _repo.activateUser(userId: event.userId);
          var updatedUsers = state.users.map((user) {
            return user.id == event.userId
                ? user.copyWith(isActive: true)
                : user;
          }).toList();
          _allItems = updatedUsers;
          emit(state.copyWith(
              isLoading: false,
              userActivated: true,
              errorResponse: null,
              users: updatedUsers));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );

    on<ResetUserPassword>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true, errorResponse: null));
          await _repo.resetUserPassword(data: event.data);
          emit(state.copyWith(
            isLoading: false,
            passwordReseted: true,
            errorResponse: null,
          ));
        } on Exception catch (e) {
          errorHandler(e, emit);
        } catch (e) {
          emit(state.copyWith(
              isLoading: false,
              errorResponse: ErrorResponse(
                  errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                  details: e.toString())));
        }
      },
    );
  }
}
