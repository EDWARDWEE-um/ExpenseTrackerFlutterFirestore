import 'package:expensetracker/components/animations/bottom_to_top_slide_transition.dart';
import 'package:expensetracker/screens/home_page/home_page.dart';
import 'package:expensetracker/screens/transactions/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final _allRoutes = <String, Function(RouteSettings settings)>{
    HomePage.routeName: (setting) => HomePage(setting.arguments as HomePageArgs),
    CreateEditTransactionPage.routeName:(setting) =>  CreateEditTransactionPage(setting.arguments as CreateEditTransactionPageArgs),
    // CreateEditPostPage.routeName: (setting) => CreateEditPostPage(setting.arguments as CreateEditPostPageArgs?),
    // CreatePifPage.routeName: (_) => CreatePifPage(),
    // CodeVerificationPage.routeName: (setting) => CodeVerificationPage(setting.arguments as CodeVerificationArgs),
    // DashboardPage.routeName: (_) => DashboardPage(),
    // EditProfilePage.routeName: (_) => EditProfilePage(),
    // FollowListPage.routeName: (setting) => FollowListPage(setting.arguments as FollowListPageArgs),
    // ForgotPasswordPage.routeName: (_) => ForgotPasswordPage(),
    // FriendsListPage.routeName: (_) => FriendsListPage(),
    // LandingPage.routeName: (_) => LandingPage(),
    // LikeListingPage.routeName: (setting) => LikeListingPage(setting.arguments as LikeListingPageArgs),
    // LoginPage.routeName: (_) => LoginPage(),
    // NotificationListingPage.routeName: (_) => NotificationListingPage(),
    // MapScreen.routeName: (_) => MapScreen(),
    // MediaViewPage.routeName: (setting) => MediaViewPage(setting.arguments as MediaViewPageArgs),
    // PostDetailPage.routeName: (setting) => PostDetailPage(setting.arguments as PostDetailPageArgs),
    // RegisterBasicInfoPage.routeName: (setting) => RegisterBasicInfoPage(setting.arguments as RegisterPageArgs),
    // RegisterPersonalInfoPage.routeName: (setting) => RegisterPersonalInfoPage(setting.arguments as RegisterPageArgs),
    // ResetPasswordPage.routeName: (setting) => ResetPasswordPage(setting.arguments as ResetPasswordArgs),
    // SelectAccountTypePage.routeName: (setting) => SelectAccountTypePage(setting.arguments as SelectAccountTypePageArgs),
    // SplashScreenPage.routeName: (_) => SplashScreenPage(),
    // UserProfilePage.routeName: (setting) => UserProfilePage(setting.arguments as UserProfilePageArgs),
    // UserSettingPage.routeName: (_) => UserSettingPage(),
    // HashtagPage.routeName: (setting) => HashtagPage(setting.arguments as HashtagPageArgs),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final _builder = _allRoutes[settings.name!];
    final _routeName = settings.name;
    final _providers = <BlocProvider>[];

    final _bottomToTopSlideTransitionRoutes = [CreateEditTransactionPage.routeName];

    if (_bottomToTopSlideTransitionRoutes.contains(_routeName)) {
      return PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => _builder!(settings),
        transitionsBuilder: (context, anim1, anim2, child) => BottomToTopSlideTransition(
          animation: anim1,
          child: _providers.isNotEmpty
              ? MultiBlocProvider(
                  providers: _providers,
                  child: _builder!(settings),
                )
              : _builder!(settings),
        ),
      );
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => _providers.isNotEmpty
          ? MultiBlocProvider(
              providers: _providers,
              child: _builder!(settings),
            )
          : _builder!(settings),
    );
  }
}

// Future<T?> pushNamed<T extends Object?>(
//   String routeName, {
//   Object? arguments,
// }) {
//   return WidgetKeys.navKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
// }

// Future<T?> popAndPushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
//   pop();
//   return pushNamed(routeName, arguments: arguments);
// }

// Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
//   String routeName,
//   RoutePredicate predicate, {
//   Object? arguments,
// }) {
//   return WidgetKeys.navKey.currentState!.pushNamedAndRemoveUntil<T>(
//     routeName,
//     predicate,
//     arguments: arguments,
//   );
// }

// Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
//   String routeName, {
//   TO? result,
//   Object? arguments,
// }) {
//   return WidgetKeys.navKey.currentState!.pushReplacementNamed<T, TO>(
//     routeName,
//     result: result,
//     arguments: arguments,
//   );
// }

// void pop<T extends Object?>([T? data]) {
//   return WidgetKeys.navKey.currentState!.pop<T>(data);
// }

// void popUntil(bool Function(Route<dynamic>) predicate) {
//   return WidgetKeys.navKey.currentState!.popUntil(predicate);
// }

// void popUntilRouteName(String routeName) {
//   return WidgetKeys.navKey.currentState!.popUntil(
//     ModalRoute.withName(routeName),
//   );
// }

// Future<void> launchUrl(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   }
// }

// Future<void> navigateUponDetectedTextTap(String detectedText) async {
//   if (rawUserTagRegex.hasMatch(detectedText)) {
//     final userId = detectedText.split('](@').last.replaceFirst(')', '');

//     await _goToUserProfilePage(userId);
//     return;
//   }

//   if (hashtagRegex.hasMatch(detectedText)) {
//     await _goToHashtagPage(detectedText.toLowerCase());
//     return;
//   }

//   if (urlRegex.hasMatch(detectedText)) {
//     await launchUrl(detectedText);
//     return;
//   }

//   return;
// }

// Future<T?> _goToHashtagPage<T extends Object?>(String hashtag) {
//   return pushNamed<T?>(HashtagPage.routeName, arguments: HashtagPageArgs(hashtag));
// }

// Future<T?> _goToUserProfilePage<T extends Object?>(String userId) {
//   return pushNamed<T?>(
//     UserProfilePage.routeName,
//     arguments: UserProfilePageArgs(
//       userId: userId,
//     ),
//   );
// }

