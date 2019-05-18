import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard/widget/app_drawer.dart';
import 'package:whiteboard/widget/calendar_month.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  DateTime date;
  num page;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    page = (now.year * 12) + now.month;
    pageController = PageController(initialPage: page);
    pageController.addListener(() {
      final rounded = pageController.page.round();
      if (rounded != page) {
        print(rounded);
        setState(() {
          page = rounded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    date = _dateFromPage(page);
    return Scaffold(
      appBar: AppBar(
        title: Text(_monthFormatter.format(DateTime(date.year, date.month))),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          children: [
            DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                    .map((s) => Text(s))
                    .toList(),
              ),
            ),
            Flexible(
                child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, index) {
                      final d = _dateFromPage(index);
                      return CalendarMonth(year: d.year, month: d.month);
                    }))
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        padding: EdgeInsets.all(4),
      ),
    );
  }
}

DateFormat _monthFormatter = DateFormat.MMMM();

DateTime _dateFromPage(num page) => DateTime(page ~/ 12, page % 12);
