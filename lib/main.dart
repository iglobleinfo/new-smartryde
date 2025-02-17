import 'package:smart_ryde/app/data/internet_check/dependency.dart';
import 'package:smart_ryde/app/routes/app_pages.dart';
import '../../export.dart';
import 'app/core/translations/translation_service.dart';

var log = Logger();
GetStorage storage = GetStorage();
CustomLoader customLoader = CustomLoader();
TextTheme textTheme = Theme.of(Get.context!).textTheme;
var tempDir;

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
  // await Firebase.initializeApp();
  // FirebaseMessaging?.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await PushNotificationsManager().init(); //activate push notification
  await GetStorage.init();
  tempDir = await getTemporaryDirectory();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  // FlutterLogger.getInstance()
  //     .init(reportURL: crashBaseUrl + logCrashesExceptionsEndPoint);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: colorLightGray,
  // ));
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   reportCrash('$error\n$stack');
  //   return true;
  // };

  // FlutterError.onError = (details) async {
  //   if (details.stack != null) {
  //     Zone.current.handleUncaughtError(details.exception, details.stack!);
  //     reportCrash('${details.exception}\n${details.stack}');
  //   } else {
  //     FlutterError.presentError(details);
  //   }
  // };
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
          theme: ThemeConfig.lightTheme,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          scaffoldMessengerKey: GlobalVariable.navState,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: LoggerX.write,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          builder: EasyLoading.init(),
          defaultTransition: Transition.cupertino,
        ),
      ),
    );
  }
}
