import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../Core/exceptions/exceptions.dart';
import '../../../Core/models/error_response.dart';
import '../../../Core/resources/app_enums.dart';
import '../../../Core/resources/app_strings.dart';
import '../../../Core/service_locator/service_locator.dart';
import '../data/models/api_notification.dart';
import '../data/repositories/notifications_repository.dart';
import 'package:easy_localization/easy_localization.dart';

part 'notifications_bloc.freezed.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final repo = serviceLocator.get<NotificationsRepository>();
  var selected = NotificationsFilter.all;
  List<APINotification> _notifications = [];
  void errorHandler(Exception e, Emitter<NotificationsState> emit) {
    if (e is SocketException) {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.connectionError.tr(),
              details: AppStrings.noInternetConnection.tr())));
    } else if (e is UnauthorizedException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is EmptyException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is ServerException) {
      emit(state.copyWith(
        errorResponse: e.errorResponse,
        isLoading: false,
      ));
    } else if (e is NoInternetException) {
      emit(state.copyWith(errorResponse: e.errorResponse));
    } else {
      emit(state.copyWith(
          isLoading: false,
          errorResponse: ErrorResponse(
              errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
              details: e.toString())));
    }
  }

  NotificationsBloc() : super(NotificationsState()) {
    on<GetAll>(
      (event, emit) async {
        try {
          selected = NotificationsFilter.all;

          emit(state.copyWith(isLoading: true));
          _notifications = await repo.getAll();
          emit(state.copyWith(notifications: _notifications, isLoading: false));
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
    on<RegisterFCMToken>((event, emit) async {
      try {
        await repo.regiterFCMToken(data: event.data);
      } on Exception catch (e) {
        errorHandler(e, emit);
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.unexpectedErrorOccurred.tr(),
                details: e.toString())));
      }
    });

    on<DeleteFCMToken>(
      (event, emit) async {
        try {
          emit(state.copyWith(isLoading: true));
          await repo.deleteFCMToken(data: event.data);
          emit(state.copyWith(loggedOut: true, isLoading: false));
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
    on<EnableNotifications>(
      (event, emit) async {
        await repo.enableNotifications();
      },
    );

    on<DisableNotifications>(
      (event, emit) async {
        await repo.disableNotifications();
      },
    );

    on<UnReadNotification>(
      (event, emit) async {
        await repo.unReadNotification(notificationId: event.notificationId);
        var newNots = state.notifications.map((n) {
          if (n.id == event.notificationId) {
            return n.copyWith(isRead: false);
          } else {
            return n;
          }
        }).toList();
        emit(state.copyWith(notifications: newNots));
      },
    );

    on<ReadNotification>(
      (event, emit) async {
        await repo.readNotification(notificationId: event.notificationId);
        var newNots = state.notifications.map((n) {
          if (n.id == event.notificationId) {
            return n.copyWith(isRead: true);
          } else {
            return n;
          }
        }).toList();
        emit(state.copyWith(notifications: newNots));
      },
    );

    on<FilterNotifications>((event, emit) async {
      try {
        if (event.filter == NotificationsFilter.all) {
          selected = NotificationsFilter.all;
          emit(state.copyWith(isLoading: true, notifications: []));
          _notifications = await repo.getAll();
          emit(state.copyWith(notifications: _notifications, isLoading: false));
        }
        if (event.filter == NotificationsFilter.unread) {
          selected = NotificationsFilter.unread;
          emit(state.copyWith(isLoading: true));
          final filteredNotifications =
              _notifications.where((e) => !e.isRead).toList();
          emit(state.copyWith(
              notifications: filteredNotifications, isLoading: false));
        }
        if (event.filter == NotificationsFilter.read) {
          selected = NotificationsFilter.read;
          emit(state.copyWith(isLoading: true));
          final filteredNotifications =
              _notifications.where((e) => e.isRead).toList();
          emit(state.copyWith(
              notifications: filteredNotifications, isLoading: false));
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
    });
  }
}
