import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Example holidays.
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class OurShifts extends StatefulWidget  {
  OurShifts({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OurShiftsState createState() => _OurShiftsState();
}

class _OurShiftsState extends State<OurShifts> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  AnimationController _animationController;
  List _selectedEvents;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _events = {};

    _selectedEvents = [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    // print('CALLBACK: _onDaySelected');
    print(events);
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('shifts').where("employeeId", isEqualTo: uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Init events when rendered before adding data.
              _events = {};
              // Add employee's shifts data to _events state.
              snapshot.data.docs.forEach((result) {
                DateTime date = result.data()['date'].toDate();
                final formattedDate = DateTime(date.year, date.month, date.day);
                final shift = {'title': "Test Shift Title", 'startTime': result.data()['startTime'], 'endTime': result.data()['endTime']};

                if(_events[formattedDate] != null) {
                  _events[formattedDate].add(shift);
                } else {
                  _events[formattedDate] = [shift];
                }
              });
            }
            return Scaffold(
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      child: _buildTableCalendar(),
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top:20),
                  ),
                  _selectedEvents.length > 0 ?
                    Expanded(child: _buildEventList())
                      :
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text('No shifts added to this date.',
                          style: TextStyle(fontSize: 16))
                  ),
                ],
              ),
            );
          }),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.twoWeeks: 'Two weeks',
        CalendarFormat.week: 'Week',
      },
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: ListTile(
          title: Text(
              event['title'],
              style: TextStyle(color: Colors.black, fontSize: 16)
          ),
          subtitle: Text(
              'Starting: ' + event['startTime'] + '  Ending: ' + event['endTime'],
              style: TextStyle(color: Colors.black54, fontSize: 14)
          ),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}