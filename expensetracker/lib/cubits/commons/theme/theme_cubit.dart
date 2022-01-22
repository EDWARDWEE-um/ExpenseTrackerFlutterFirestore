import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/enum_extensions/enums_extensions.dart';
import 'package:expensetracker/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetracker/constants/dimen_constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(
    ThemeType? themeType,
  ) : super(
          ThemeState.initial(
            themeType: themeType,
          ),
        );

  factory ThemeCubit.initial() {
    //the case of is register only happen when you mock the cubit in test case
    if (sl.isRegistered<ThemeCubit>()) {
      return sl.get<ThemeCubit>();
    }

    const _initialTheme = ThemeType.defaultTheme;

    return ThemeCubit(_initialTheme);
  }

  void changeTheme() {
    var themeType = ThemeType.defaultTheme;

    if (state.themeType == ThemeType.defaultTheme) {
      themeType = ThemeType.darkTheme;
    } else if (state.themeType == ThemeType.darkTheme) {
      themeType = ThemeType.defaultTheme;
    }

    emit(ThemeState.initial(
      themeType: themeType,
    ));
  }
}
