import 'package:new_firebase_expence_app/models/plannedTransaction.dart';
import 'package:new_firebase_expence_app/services/databaseWrapper.dart';

class PlannedTransactionsService {
  static Future<void> checkPlannedTransactions(String uid) async {
    List<PlannedTransaction> plannedTxs =
        await DatabaseWrapper(uid).getPlannedTransactions();
    DateTime now = DateTime.now();
    for (PlannedTransaction plannedTx in plannedTxs) {
      PlannedTransaction iteratingRecTx = plannedTx;
      while (iteratingRecTx != null && iteratingRecTx.nextDate.isBefore(now)) {
        DatabaseWrapper(uid).addTransactions([iteratingRecTx.toTransaction()]);
        DatabaseWrapper(uid)
            .incrementPlannedTransactionsNextDate([iteratingRecTx]);
        iteratingRecTx = await DatabaseWrapper(uid)
            .getPlannedTransaction(iteratingRecTx.rid);
      }
    }
  }
}
