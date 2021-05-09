import 'package:get_it/get_it.dart';
import 'package:mony_manager_new/core/services/notification_service.dart';
import 'package:mony_manager_new/core/services/sharedprefs_service.dart';
import 'package:mony_manager_new/core/viewmodels/details_model.dart';
import 'package:mony_manager_new/core/viewmodels/edit_model.dart';
import 'package:mony_manager_new/core/viewmodels/insert_transaction_model.dart';
import 'package:mony_manager_new/core/viewmodels/new_transcation_model.dart';
import 'package:mony_manager_new/core/viewmodels/piechart_model.dart';
import 'package:mony_manager_new/core/viewmodels/reminder_model.dart';

import 'core/services/category_icon_service.dart';
import 'core/services/moordatabase_service.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //!SERVICES
  locator.registerLazySingleton(() => CategoryIconService());
  locator.registerLazySingleton(() => MoorDatabaseService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => SharedPrefrencesService());
  //!VIEWMODELS
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => DetailsModel());
  locator.registerFactory(() => EditModel());
  locator.registerFactory(() => NewTransactionModel());
  locator.registerFactory(() => InsertTransactionModel());
  locator.registerFactory(() => PieChartModel());
  locator.registerFactory(() => ReminderModel());
}
