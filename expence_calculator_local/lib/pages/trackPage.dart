import 'dart:ui';

import 'package:expence_calculator_local/utilities/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:expence_calculator_local/database/expense_provider.dart';
import 'package:expence_calculator_local/expenses_store.dart';
import 'package:expence_calculator_local/models/expense.dart';
import 'package:expence_calculator_local/pages/graphPage.dart';
import 'package:expence_calculator_local/utilities/regex.dart';
import 'package:expence_calculator_local/widgets/expenseTile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expence_calculator_local/models/tag.dart';

class TrackPage extends HookWidget {
  Map<int, double> opacity = new Map();
  RichTextController _controller;

  var focusNode = new FocusNode();
  GlobalKey<AnimatedListState> listKey = GlobalKey();
  final store = MobxStore.st;

  DateTime selectedDate;
  double calendarHeight;
  CalendarController _calendarController;
  List<Expense> selectedDateExpenses;

  Expense thumbnailExpense;
  bool showThumbnail = false, isKeyboardActive = false;

  ValueNotifier<bool> setState;

  void initState() {
    _controller = RichTextController({
      Regex.tagRegex: TextStyle(
        color: Colors.orange[700],
      ),
      Regex.priceRegex: TextStyle(
        color: Colors.deepPurple[700],
      ),
      Regex.dateRegex: TextStyle(
        color: Colors.green[700],
      ),
    });
    store.editing = <Expense>{};
    selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    if (store.selectedDate == null) store.updateSelectedDate(selectedDate);

    _calendarController = CalendarController();
    calendarHeight = 0;

    KeyboardVisibility.onChange.listen((bool visible) {
      isKeyboardActive = visible;

      //keybard opening when calendar is enable
      if (isKeyboardActive && calendarHeight > 0) {
        calendarHeight = 0;
        setState.value = !setState.value;
      }
      //delete
      if (!isKeyboardActive && store.editing.isNotEmpty) {
        store.editing = {};
        _controller.text = '';
        setState.value = !setState.value;
      }

      if (!isKeyboardActive && showThumbnail) {
        showThumbnail = false;
        store.thumbnailExpense = null;
        _controller.text = '';
        FocusScope.of(focusNode.context).unfocus();
        setState.value = !setState.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState = useState(false);
    useEffect(() {
      initState();
      return () {};
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xfff9f9f9),
          child: Observer(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                calendarShowSection(),
                calendar(),
                store.selectedDateExpenses.isNotEmpty
                    ? Text(
                        'Hint: Swipe Right To Edit, Left To Delete And Click A Tag For More Info',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      )
                    : Container(),
                expensesListWidget(),
                totalPriceWidget(),
                thumbnailWidget(),
                addPriceWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }

  //---------------CALENDAR---------------
  // #region

  Widget calendar() {
    return Container(
      height: calendarHeight,
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return TableCalendar(
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              initialSelectedDay: store.selectedDate,
              calendarStyle: CalendarStyle(),
              availableGestures: AvailableGestures.horizontalSwipe,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              rowHeight: 35,
              onDaySelected: null,
              /*
              (day, events) {
                // focusNode.unfocus();;
                selectedDate = new DateTime(day.year, day.month, day.day);
                store.updateSelectedDate(selectedDate);
                store.updateGraphSelectedDate(selectedDate);
                calendarHeight = 0;
                setState.value = !setState.value;
              }
               */
            );
          },
        ),
      ),
    );
  }

  Widget calendarShowSection() {
    return Observer(builder: (_) {
      store.selectedDate;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue[700],
            ),
            onPressed: calendarHeight != 0
                ? null
                : () {
                    var newDate = store.selectedDate.subtract(
                      Duration(
                        days: 1,
                      ),
                    );
                    store.updateSelectedDate(newDate);
                    store.updateGraphSelectedDate(newDate);
                  },
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  // color: Colors.grey[400],
                  border: Border.all(
                    color: Colors.blue[700],
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 60,
                child: GestureDetector(
                  onTap: calendarButtonPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Observer(builder: (_) {
                          var date = store.selectedDate;
                          return Container(
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.only(top: 4),
                            child: Text(
                              store.dateStyle == 'dd/mm'
                                  ? '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}'
                                  : '${date.month.toString().padLeft(2, '0')} / ${date.day.toString().padLeft(2, '0')} / ${date.year}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5,
                              ),
                            ),
                          );
                        }),
                      ),
                      IconButton(
                        icon: Icon(
                          calendarHeight == 0
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: Colors.blue[700],
                        ),
                        onPressed: () async => calendarButtonPressed(),
                      )
                    ],
                  ),
                )),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.blue[700],
            ),
            onPressed: calendarHeight != 0
                ? null
                : () {
                    var newDate = store.selectedDate.add(
                      Duration(
                        days: 1,
                      ),
                    );
                    store.updateSelectedDate(newDate);
                    store.updateGraphSelectedDate(newDate);
                  },
          ),
        ],
      );
    });
  }

  // #endregion

  //---------------EXPENSES LIST WIDGET---------------
  // #region

  Widget expensesListWidget() {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: listViewExpenses(),
    ));
  }

  Widget listViewExpenses() {
    return Observer(
      builder: (_) {
        store.selectedDate;
        store.expenses;

        List<Expense> selectedDateExpenses = store.selectedDateExpenses;

        return new AnimatedList(
          key: listKey,
          initialItemCount:
              100, // needs to be higher because we change the item count
          itemBuilder: (bc, i, anim) {
            if (selectedDateExpenses.length <= i) return null;

            Expense expense = selectedDateExpenses[i];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Slidable(
                actionPane: SlidableStrechActionPane(),
                direction: Axis.horizontal,
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () => editButtonPressed(expense.id),
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => deleteButtonPressed(expense.id),
                  ),
                ],
                child: FadeTransition(
                  opacity: anim,
                  child: ExpenseTile(
                    expense: expense,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget thumbnailWidget() {
    return Opacity(
      opacity: 0.5,
      child: Observer(builder: (_) {
        store.thumbnailExpense;
        store.editing;
        Expense expenseToShow = store.thumbnailExpense;
        if (showThumbnail && store.thumbnailExpense == null)
          expenseToShow = Expense(
            tags: [Tag.otherTag],
            name: 'other',
            prices: [0.0],
          );

        if (showThumbnail || store.editing.isNotEmpty) {
          return ExpenseTile(
            expense: store.thumbnailExpense,
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget totalPriceWidget() {
    return Observer(builder: (_) {
      store.selectedDate;
      store.limitMap;
      store.editing;

      var totalPrice = store.getSelectedDateTotalPrice();

      //text styles
      bool limitextended;
      bool isUseLimit =
          store.limitMap[ViewType.Day] != null && store.isUseLimit;

      if (isUseLimit)
        limitextended = totalPrice > store.limitMap[ViewType.Day];
      else
        limitextended = false;
      Color color = limitextended ? Colors.red[700] : Colors.blue[700];
      FontWeight fontWeight = limitextended ? FontWeight.w700 : FontWeight.w500;
      double fontSize = limitextended ? 21 : 19;

      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          height: !showThumbnail ? 60 : 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                isUseLimit
                    ? 'Total / Limit : $totalPrice / ${store.limitMap[ViewType.Day]}'
                    : 'Total Expense : $totalPrice ',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  letterSpacing: 1.2,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // #endregion
  //---------------ADD PRICE TEXT FIELD---------------

  Widget addPriceWidget() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (text) async {
                store.setThumbnailExpense(
                  await Regex.doRegex(
                    text,
                    store.selectedDate,
                    false,
                  ),
                );
              },
              onTap: () {
                if (store.editing.isNotEmpty) return;

                if (calendarHeight == null) {
                  calendarHeight = 0;
                  setState.value = !setState.value;
                }

                if (!showThumbnail) {
                  showThumbnail = true;

                  setState.value = !setState.value;
                }
              },
              focusNode: focusNode,
              textInputAction: TextInputAction.send,
              controller: _controller,
              maxLines: null,
              minLines: null,
              onSubmitted: (value) => textFieldSubmitted(_controller),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.6,
              ),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  hintText: 'Enter a expense',
                  helperText:
                      ' . prefix to add tag (.travel .food) or shorten it (.t .f)'),
            ),
          ),
          editCancelButton(),
        ],
      ),
    );
  }

  Widget editCancelButton() {
    return Observer(builder: (_) {
      const double kSize = 40;
      return Container(
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 7),
        width: store.editing.isNotEmpty ? null : 0,
        child: IconButton(
          onPressed: editCancelPressed,
          constraints: BoxConstraints(
            maxHeight: kSize,
            maxWidth: kSize,
          ),
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          highlightColor: Colors.red,
        ),
      );
    });
  }
  //
  //--------------LOGIC--------------

  // #region Logic

  textFieldSubmitted(TextEditingController _controller) async {
    Expense regexExpense = await Regex.doRegex(
      _controller.text,
      store.selectedDate,
      true,
    );
    print('regexExpense:\t $regexExpense');
    showThumbnail = false;
    store.thumbnailExpense = null;

    _controller.text = '';

    if (store.editing.isNotEmpty) {
      //EDITING PART

      Expense expenseToAdd = regexExpense;
      expenseToAdd.id = store.editing.first.id;

      store.updateExpense(expenseToAdd, setDatabase: true);
      store.editing = {};
    } else {
      //ADDING PART

      store.addExpense(regexExpense, setDatabase: true);

      if (isSelectedDate(regexExpense))
        listKey.currentState.insertItem(store.selectedDateExpenses.length - 1);
    }
    showThumbnail = false;

    setState.value = !setState.value;
  }

  deleteButtonPressed(int id) {
    Expense expense =
        store.selectedDateExpenses.firstWhere((element) => element.id == id);

    ExpenseProvider.db.delete(expense).then((value) {
      print('deleted');
    });

    AnimatedListRemovedItemBuilder builder = (context, anim) {
      return FadeTransition(
        opacity: anim,
        child: ExpenseTile(
          expense: expense,
        ),
      );
    };

    listKey.currentState.removeItem(
      store.selectedDateExpenses.indexOf(expense),
      builder,
      duration: Duration(milliseconds: 500),
    );
    store.deleteExpense(expense);
    setState.value = !setState.value;
  }

  editButtonPressed(int id) {
    Expense expense = store.selectedDateExpenses.firstWhere(
      (element) => element.id == id,
    );

    store.editing = {expense};
    focusNode.requestFocus();

    //to set state of total expense widget
    store.selectedDate = DateTime.parse(store.selectedDate.toIso8601String());

    _controller.text = expense.text;

    _controller.buildTextSpan(
      style: TextStyle(
        color: Colors.red,
      ),
    );

    showThumbnail = true;

    store.thumbnailExpense = expense;
  }

  Future calendarButtonPressed() async {
    if (isKeyboardActive) {
      focusNode.unfocus();
      await Future.doWhile(() async {
        await Future.delayed(Duration(milliseconds: 200));
        return isKeyboardActive;
      });
    }

    if (calendarHeight != null)
      calendarHeight = null;
    else
      calendarHeight = 0;
    setState.value = !setState.value;
  }

  bool isSelectedDate(Expense exp) {
    return exp.date.year == store.selectedDate.year &&
        exp.date.month == store.selectedDate.month &&
        exp.date.day == store.selectedDate.day;
  }

  editCancelPressed() {
    store.editing = {};
    focusNode.unfocus();
    _controller.text = '';
  }
// #endregion

}
