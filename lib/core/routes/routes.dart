import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/pages/change_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:bookia/features/auth/presentation/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/pages/otp_screen.dart';
import 'package:bookia/features/auth/presentation/pages/register_screen.dart';
import 'package:bookia/features/auth/presentation/pages/resset_success_screen.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/pages/place_order_screen.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/pages/details_screen.dart';
import 'package:bookia/features/main/main_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  //auth
  static final String splash = '/';
  static final String welcome = '/welcome';
  static final String login = '/login';
  static final String register = '/register';
  static final String forgetPassword = '/forgetPassword';
  static final String otp = '/otp';
  static final String changePassword = '/changePassword';
  static final String resetSuccess = '/resetSuccess';
  // main
  static final String main = '/main';
  static final String details = '/details';

  //cart
  static final String placeOrder = '/placeOrder';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: main,
        builder: (context, state) {
          var startIndex = state.extra as int;
          return MainScreen(initialIndex: startIndex);
        },
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: ForgetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: otp,
        builder: (context, state) {
          final cubit = state.extra as AuthCubit;
          return BlocProvider.value(value: cubit, child: OtpScreen());
        },
      ),
      GoRoute(
        path: changePassword,
        builder: (context, state) {
          final cubit = state.extra as AuthCubit;
          return BlocProvider.value(
            value: cubit,
            child: ChangePasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: resetSuccess,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: ResetSuccessScreen(),
        ),
      ),
      GoRoute(
        path: details,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(),
          child: DetailsScreen(product: state.extra as Products),
        ),
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) {
          var total = state.extra;
          return BlocProvider(
            create: (context) => CartCubit()..initData(),
            child: PlaceOrderScreen(total: total),
          );
        },
      ),
    ],
  );
}
