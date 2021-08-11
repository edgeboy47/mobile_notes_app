import 'package:auto_route/annotations.dart';
import 'package:mobile_notes_app/auth/ui/login_page.dart';
import 'package:mobile_notes_app/auth/ui/register_page.dart';
import 'package:mobile_notes_app/notes/ui/home_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: LoginPage, path: 'login'),
    MaterialRoute(page: RegisterPage, path: 'register'),
    MaterialRoute(page: HomePage, path: 'home'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
