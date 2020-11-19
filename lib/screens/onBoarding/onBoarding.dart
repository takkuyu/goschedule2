import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goschedule2/screens/root/root.dart';

class OurOnBoardingScreen extends StatefulWidget {
  @override
  _OurOnBoardingScreenState createState() => _OurOnBoardingScreenState();
}

class _OurOnBoardingScreenState extends State<OurOnBoardingScreen> {

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List <Widget> _buildPageIndicator() {
    List <Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add( i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(duration: Duration(milliseconds:  150),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    height: 8.0,
    width: isActive ? 24.0: 16.0,
    decoration: BoxDecoration(color: isActive ? Colors.white : Color(0xFF7B51D3),
      borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1,0.4,0.7,0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5816D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              Container(height: 550,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image(
                            image: AssetImage(
                              'assets/Shifts.png',
                            ),
                            height: 350.0,
                            width: 350.0,
                          ),
                        ),
                        SizedBox(height: 0.0,),
                        Center(
                          child: Text("SEE UPCOMING SHIFTS!", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                        ),
                        SizedBox(height: 20.0,),
                        Text("Get to know when your next shift is about to start and keep track of your upcoming shifts.", style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image(
                            image: AssetImage(
                              'assets/Contacts.png',
                            ),
                            height: 350.0,
                            width: 350.0,
                          ),
                        ),
                        Center(
                          child: Text("CONTACT YOUR COWORKERS!", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                        ),
                        SizedBox(height: 20.0,),
                        Text("Get access to your coworkers contact information anytime.", style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image(
                            image: AssetImage(
                              'assets/Calendar.png',
                            ),
                            height: 350.0,
                            width: 350.0,
                          ),
                        ),
                        SizedBox(height: 0.0,),
                        Center(
                          child: Text("KEEP TRACK OF YOUR TIME!", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                        ),
                        SizedBox(height: 20.0,),
                        Text("GoSchedule allows you to view and keep track of your time and gives you the tools to update your work availability on the go.", style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        )),
                      ],
                    ),
                  ),

                ],
              ),
              ),
              Row(mainAxisAlignment:  MainAxisAlignment.center, children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1 ? Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed:  () {
                        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget> [
                          Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 30.0,)
                        ],
                      ),
                    )
                    )
                  )
                : Text(""),
              ],
            ),
          ) ,
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1 ? Container(
        height: 60.0, width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text("Get started", style: TextStyle(color: Color(0xFF5B16D0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
               ),
              ),
            ),
          ),
        ),
      )
          : Text('')
    );
  }
}
