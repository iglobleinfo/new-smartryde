import 'package:smart_ryde/app/core/values/app_global_values.dart';
import 'package:smart_ryde/app/data/internet_check/dependency.dart';
import 'package:smart_ryde/app/routes/app_pages.dart';
import '../../export.dart';
import 'app/core/translations/translation_service.dart';

var log = Logger();
GetStorage storage = GetStorage();
CustomLoader customLoader = CustomLoader();
TextTheme textTheme = Theme.of(Get.context!).textTheme;
Directory? tempDir;
Language appLanguage = Language.en;

class GlobalVariable {
  static final GlobalKey<ScaffoldMessengerState> navState =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}

Future<void> main() async {
  initApp();
  WidgetsFlutterBinding.ensureInitialized();
  APIRepository();
  DependencyInjection.init();
  await GetStorage.init();
  tempDir = await getTemporaryDirectory();
  appLanguage = await PreferenceManger().getSavedLanguage();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
}

initApp() async {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stack) {
    debugPrint("error Received $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (context, widget) => GetMaterialApp(
          navigatorKey:
              navigationService.navigatorKey, // Link the navigator key
          theme: ThemeConfig.lightTheme,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          scaffoldMessengerKey: GlobalVariable.navState,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: LoggerX.write,
          locale: TranslationService.getLocaleFromLanguage(appLanguage),
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          builder: EasyLoading.init(),
          defaultTransition: Transition.cupertino,
        ),
      ),
    );
  }
}
