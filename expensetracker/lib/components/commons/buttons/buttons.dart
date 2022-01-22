import 'package:expensetracker/constants/dimen_constants.dart';
import 'package:expensetracker/cubits/commons/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensetracker/data/enum_extensions/enums_extensions.dart';

class FloatingButton extends StatelessWidget {
  final double? size;
  final Widget child;
  final GestureTapCallback onPressed;
  final Color? backgroundColor, foregroundColor;
  final String? heroTag;

  const FloatingButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.size,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? defaultFloatingButtonSize,
      height: size ?? defaultFloatingButtonSize,
      child: FloatingActionButton(
        onPressed: onPressed,
        heroTag: heroTag,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        child: child,
      ),
    );
  }
}

class DynamicButton extends StatelessWidget {
  final Widget child;
  final double btnRadius;
  final GestureTapCallback onPressed;
  final bool showPrimary;
  final double? width;
  final EdgeInsets? padding;

  const DynamicButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.btnRadius = midRadius,
    this.showPrimary = true,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: showPrimary
          ? SecondaryButton(
              btnRadius: btnRadius,
              onPressed: onPressed,
              padding: padding,
              child: child,
            )
          : OutlinedPrimaryButton(
              btnRadius: btnRadius,
              onPressed: onPressed,
              padding: padding,
              child: child,
            ),
    );
  }
}

class OutlinedPrimaryButton extends StatelessWidget {
  final Widget child;
  final double btnRadius;
  final GestureTapCallback onPressed;
  final BorderSide? borderSide;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? primaryColor;

  const OutlinedPrimaryButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.btnRadius = circularRadius,
    this.borderSide,
    this.textStyle,
    this.padding,
    this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _colorTheme = themeState.colorTheme;

        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            primary: primaryColor,
            side: borderSide ??
                BorderSide(
                  color: _colorTheme.primaryColor,
                  width: outlineBtnWidth,
                ),
            textStyle: textStyle ?? themeState.themeData.textTheme.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
            padding:
                padding ?? const EdgeInsets.symmetric(horizontal: spaceXLarge),
          ),
          child: child,
        );
      },
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onPressed;
  final double btnRadius;

  const PrimaryButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.btnRadius = circularRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: state.colorTheme.primaryColor,
                primary: state.colorTheme.onPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: spaceXLarge),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(btnRadius),
                ),
              ),
            ),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: child,
          ),
        );
      },
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onPressed;
  final EdgeInsets? padding;
  final double btnRadius;
  final Color? btnBackgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;

  const SecondaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: spaceXLarge),
    this.btnRadius = circularRadius,
    this.btnBackgroundColor,
    this.textColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: btnBackgroundColor ??
                    state.colorTheme.secondaryBackgroundColor,
                primary: textColor ?? state.colorTheme.primaryColor,
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: spaceXLarge),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(btnRadius),
                ),
                textStyle: textStyle,
              ),
            ),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: child,
          ),
        );
      },
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imagePath;
  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final GestureTapCallback? onPressed;

  const ImageButton({
    Key? key,
    required this.imagePath,
    this.onPressed,
    this.height = defaultIconSize,
    this.width,
    this.padding = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onPressed,
        child: Container(
          padding: padding,
          constraints: BoxConstraints(
              minHeight: height,
              minWidth:
                  width ?? height), //this constraint is for testing purpose
          child: Image.asset(
            imagePath,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

class CircularLabelFloatingButton extends StatelessWidget {
  final String label;
  final String? prefixIconPath;
  final GestureTapCallback? onFloatingBtnTap;
  final double floatingBtnSize;
  final Color? backgroundColor, labelColor, btnColor;

  const CircularLabelFloatingButton({
    Key? key,
    required this.label,
    this.prefixIconPath,
    this.onFloatingBtnTap,
    this.floatingBtnSize = floatButtonIconSize,
    this.backgroundColor,
    this.labelColor,
    this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Card(
          color: backgroundColor ?? _colorTheme.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
                spaceXLarge, spaceXMid, spaceXMid, spaceXMid),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (prefixIconPath != null) Image.asset(prefixIconPath!),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: spaceMid),
                          child: Text(
                            label,
                            style: _textTheme.subtitle1
                                ?.scaleFontWeight(3)
                                ?.copyWith(
                                    color: labelColor ??
                                        _colorTheme.onSecondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FloatingButton(
                  onPressed: onFloatingBtnTap ?? () {},
                  size: floatingBtnSize,
                  backgroundColor: btnColor,
                  child: Icon(
                    Icons.ac_unit,
                    color: _colorTheme.secondaryColor,
                    size: smallIconSize,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageCircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String imgPath;
  final Color bgColor;
  final double size;
  final EdgeInsets padding;

  const ImageCircleButton({
    Key? key,
    required this.onTap,
    required this.imgPath,
    required this.bgColor,
    this.padding = EdgeInsets.zero,
    this.size = floatButtonIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        padding: padding,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Image.asset(imgPath),
      ),
    );
  }
}
