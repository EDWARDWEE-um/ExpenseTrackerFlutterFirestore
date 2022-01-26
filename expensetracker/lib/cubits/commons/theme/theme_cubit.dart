import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/data/enum_extensions/enums_extensions.dart';
import 'package:expensetracker/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetracker/constants/dimen_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPrefences;
  ThemeCubit({required ThemeState state})
      : sharedPrefences = sl.get<SharedPreferences>(),
        super(state);

  factory ThemeCubit.initial({
    ThemeState? state,
    String? type,
  }) {
    ThemeType _initialTheme = (type == 'ThemeType.defaultTheme')
        ? ThemeType.defaultTheme
        : ThemeType.darkTheme;
    return ThemeCubit(
        state: state ?? ThemeState.initial(themeType: _initialTheme));
  }

  Future<void> changeTheme() async {
    var themeType = ThemeType.defaultTheme;
    if (state.themeType == ThemeType.defaultTheme) {
      themeType = ThemeType.darkTheme;
    } else if (state.themeType == ThemeType.darkTheme) {
      themeType = ThemeType.defaultTheme;
    }
    await sharedPrefences.setString('themeKey', themeType.toString());
    emit(ThemeState.initial(
      themeType: themeType,
    ));
  }
}
