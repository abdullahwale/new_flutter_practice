import 'package:expence_calculator_local/models/tag.dart';
import 'package:expence_calculator_local/pages/tagDetailPage.dart';
import 'package:flutter/material.dart';

import 'package:expence_calculator_local/models/expense.dart';
import 'package:expence_calculator_local/expenses_store.dart';

class ExpenseTile extends StatefulWidget {
  Expense expense;
  bool isThumbnail;

  ExpenseTile({
    this.expense,
    this.isThumbnail,
  }) {
    expense ??= Expense.empty();
  }
  @override
  _ExpenseTileState createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(6),
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 1.5),
              blurRadius: 1,
            )
          ]),
      child: Row(
        children: <Widget>[
          // Container(
          //   width: 5,
          //   height: 92,
          //   child: Column(
          //     children: widget.expense.tags
          //         .map(
          //           (tag) => Expanded(
          //             child: Container(color: tag.color),
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
          Expanded(
            child: expenseTile(
              widget.expense,
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseTile(Expense expense) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //BUTTON SECTION
          // buttonsHeader(),

          //TEXT SECTION
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(flex: 5, child: expenseNameText(expense)),
                  Expanded(flex: 3, child: tagRow(expense)),
                ],
              ),
            ),
          ),
          priceSection(expense)
        ],
      ),
    );
  }

  Widget expenseNameText(Expense expense) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Align(
            alignment: FractionalOffset.centerLeft,
            child: Text(
              expense?.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget tagRow(Expense expense) {
    if (expense.tags == null || expense.tags.isEmpty) {
      expense.tags = [Tag.otherTag];
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: expense.tags.map((tag) {
            return GestureDetector(
              onTap: () => MobxStore.st.navigatorKey.currentState.push(
                MaterialPageRoute(
                  builder: (_) => TagDetailPage(tag),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                constraints: BoxConstraints(
                  maxWidth: 150,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: tag.color,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: tag.color,
                      width: 1,
                    )),
                child: Text(
                  tag.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: tag.color,
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget priceSection(Expense expense) {
    if (expense.prices == null) {
      expense.prices = [0];
    }
    double totalPrice = expense?.getTotalExpense() ?? 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Builder(
              builder: (bc) {
                if (expense.prices.length <= 1) return Container();
                return Column(
                  children: expense.prices.map((price) {
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 4),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          )
                        ],
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          price.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 70,
              minHeight: 70,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[100],
            ),
            child: Center(
              child: Text(
                totalPrice.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
