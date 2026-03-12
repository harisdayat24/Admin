// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:minia_web_project/main.dart';
import 'package:minia_web_project/routes/app_routes.dart';
import 'package:minia_web_project/view/Apps/contactList/profile_view.dart';
import 'package:minia_web_project/view/Authentication/pages/lock_screen.dart';
import 'package:minia_web_project/view/Authentication/pages/reset_pass.dart';
import 'package:minia_web_project/view/Authentication/pages/sign_up.dart';
import 'package:minia_web_project/view/Authentication/pages/two_step_verify.dart';
// import 'package:minia_web_project/view/Forms/Editors_and_uploads/editor.dart';
import 'package:minia_web_project/view/Forms/Editors_and_uploads/uploads.dart';
import 'package:minia_web_project/view/Forms/advanced_plugins/advanced_plugin.dart';
import 'package:minia_web_project/view/Forms/advanced_plugins/choice.dart';
import 'package:minia_web_project/view/Forms/basic_elements_container/basic_elements.dart';
import 'package:minia_web_project/view/Forms/form_validation/form_validation.dart';
import 'package:minia_web_project/view/Forms/mask/form_mask.dart';
import 'package:minia_web_project/view/Forms/wizard/wizard.dart';
import 'package:minia_web_project/view/Forms/wizard/wizard_with_progressbar.dart';
import 'package:minia_web_project/view/Pages/errors/error404.dart';
import 'package:minia_web_project/view/Pages/errors/error500.dart';
import 'package:minia_web_project/view/Pages/faq.dart';
import 'package:minia_web_project/view/Pages/Price/pricing.dart';
import 'package:minia_web_project/view/Pages/time_line.dart';
import 'package:minia_web_project/view/Tables/BootStraps/bootstrap_basic_view.dart';
import 'package:minia_web_project/view/Tables/DataTable/default_datatable.dart';
import 'package:minia_web_project/view/dashboard.dart';
import 'package:minia_web_project/view/Pages/coming_soon.dart';
import 'package:minia_web_project/view/Pages/maintenance.dart';
import '../view/Authentication/pages/confirm_mail.dart';
import '../view/Authentication/pages/email_verify.dart';
import '../view/Authentication/pages/log_out.dart';
import '../view/Authentication/pages/login.dart';
import '../view/Drawer/drawer.dart';
import '../view/Pages/starter_page.dart';
import '../view/Tables/editable_tables.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.sideBarPage;

  static final routes = [
    GetPage(
      name: Paths.kerjaApp,
      page: () => const KerjaApp(),
    ),
    GetPage(
      name: Paths.sideBarPage,
      page: () => const SideBarPage(),
    ),
    GetPage(
      name: Paths.login,
      page: () => const Login(),
    ),
    GetPage(
      name: Paths.dashboard,
      page: () => const Dashboard(),
    ),
    GetPage(
      name: Paths.resetPassword,
      page: () => const ResetPassword(),
    ),
    GetPage(
      name: Paths.lockscreen,
      page: () => const LockScreen(),
    ),
    GetPage(
      name: Paths.logout,
      page: () => const Logout(),
    ),
    GetPage(
      name: Paths.confirmMail,
      page: () => const ConfirmMail(),
    ),
    GetPage(
      name: Paths.verify,
      page: () => const EmailVerify(),
    ),
    GetPage(
      name: Paths.twostep,
      page: () => const TwoStepVerify(),
    ),
    GetPage(
      name: Paths.signup,
      page: () => const Signup(),
    ),
    GetPage(
      name: Paths.starterpage,
      page: () => const StarterPage(),
    ),
    GetPage(
      name: Paths.maintenance,
      page: () => const Maintenance(),
    ),
    GetPage(
      name: Paths.coming,
      page: () => ComingSoon(),
    ),
    GetPage(
      name: Paths.timeline,
      page: () => const TimelinePage(),
    ),
    GetPage(
      name: Paths.error404,
      page: () => const Error404(),
    ),
    GetPage(
      name: Paths.error500,
      page: () => const Error500(),
    ),
    GetPage(
      name: Paths.faq,
      page: () => const FAQ(),
    ),
    GetPage(
      name: Paths.pricing,
      page: () => const Pricing(),
    ),
    GetPage(
      name: Paths.basicelements,
      page: () => const BasicElements(),
    ),
    GetPage(
      name: Paths.formValidation,
      page: () => const FormValidation(),
    ),
    GetPage(
      name: Paths.advancedpluging,
      page: () => const AdvancedPlug(),
    ),
    GetPage(
      name: Paths.choice,
      page: () => const Choice(),
    ),
    // GetPage(
    //   name: Paths.editors,
    //   page: () => const Editors(),
    // ),
    GetPage(
      name: Paths.upload,
      page: () => const Uploads(),
    ),
    GetPage(
      name: Paths.wizard,
      page: () => const FormWizard(),
    ),
    GetPage(
      name: Paths.wprogressbar,
      page: () => const WProgressbar(),
    ),
    GetPage(
      name: Paths.formMask,
      page: () => const FormMask(),
    ),
    GetPage(
      name: Paths.bootstrapBasic,
      page: () => const BootstrapBasic(),
    ),
    GetPage(
      name: Paths.editTable,
      page: () => const EditableTable(),
    ),
    GetPage(
      name: Paths.profileView,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Paths.datatablemain,
      page: () => const DataTableMain(),
    ),
  ];
}
