import 'package:mony_manager_new/core/models/category.dart';
import 'package:mony_manager_new/core/services/category_icon_service.dart';
import 'package:mony_manager_new/core/viewmodels/base_model.dart';
import 'package:mony_manager_new/locator.dart';

class NewTransactionModel extends BaseModel {
  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  int selectedCategory = 2; // 1=>income,2=>expense

  void changeSelectedItem(int newItemIndex) {
    selectedCategory = newItemIndex;

    notifyListeners();
  }

  List<Category> loadCategoriesIcons() {
    if (selectedCategory == 1) {
      // load income
      List<Category> s = _categoryIconService.incomeList.toList();
      return s;
    } else {
      // load expense
      List<Category> s = _categoryIconService.expenseList.toList();
      return s;
    }
  }
}
