import 'package:flutter/material.dart';

import '../../configs/AppColors.dart';
import '../../widgets/poke_container.dart';
import 'widgets/category_list.dart';
import 'widgets/news_list.dart';
import 'widgets/search_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String _markdownData = """
# KRAIG 101

The K.R.A.I.G 101 workshop, organized specially for the first-year students of IIT Kharagpur took place on the 21st of August and as expected, it was met by curious, eager students and robotics enthusiasts alike. 
For the uninitiated, K.R.A.I.G, The Kharagpur Robotics and Artificial Intelligence Group is comprised of a group of robotics enthusiasts, who together, form the Technical Wing of the Technology Robotix Society. The K.R.A.I.G classes serve to teach students the fundamentals of manual and autonomous robotics. Students with little to no knowledge of robotics are especially welcome, as the classes start from scratch. Such workshops provide the perfect learning environment and a brilliant atmosphere for discussion, with eager learners, curious freshmen as well as students experienced in the world of robotics.
 
The first workshop, K.R.A.I.G 101 was taught by the members of the Technology Robotix Society. The goal of this session was to give students an introduction to the world of robotics and to teach a few fundamental concepts required to make a simple robot.
Fresh from the introductory seminar, the students were curious to learn how to make the robots we see around the world in this age. This workshop was where many first-year students came to take their first step into the world of robotics. We hope that this inital foray will soon develop into an interest and a passion for robotics for all!

The first concept that was covered was Locomotion, and one of the most important mechanisms to accomplish it: the differential drive mechanism. To explain it briefly, it’s the mechanism in which the movement is based on two separately driven wheels on either side of the robot body. It moves by varying the speeds of the two wheels and hence does not require an additional steering mechanism. Concepts were accompanied with diagrams, video demonstrations and of course, student could ask doubts and questions, to ensure crystal-clear understanding.
 
Next, the students learnt about switches and relay circuits. Most of us are familiar with or have a vague idea of what switches are. They’re electrical components that can complete or break an electrical circuit, interrupting the current or diverting it from one conductor to the other. Relays are electrically operated switches. Relays could use electromagnets to mechanically operate the switches, or other operating principles as well.
 
Next up were diodes and H-Bridges! Seemingly confusing topics, but students were encouraged to interact with each other to clear their doubts and gain a better understanding of topics (that a lot of them probably learnt that very day!) But to put it in short, a diode is a two terminal electronic component with asymmetric conductance. It has low resistance to current in one direction, and high resistance to current in the other. H-Bridges are electronic circuits that enable voltage to be applied across a load in either direction.
 
Students then learnt the different ways in which they could build their robots to effectively control and manoeuvre their robots, and they gained a better insight of the actual circuitry that goes behind the exterior of the fascinating robots we see. In fact, many of the students applied this knowledge to make their own robot controller in less than a week!
Last but definitely not the least, the Robosoccer Challenge was formally announced, a tournament open to all first-year students to design and make their own soccer-playing robots! Students were given an opportunity to put all the knowledge they gained at the workshop and their creativity to the test in the Challenge held on 26th August (more about that in an upcoming blog post!) This was met with a great deal of enthusiasm and the students were eager to participate in the first event organized by the Technology Robotix Society in the year.
Following this, 16 new students were inducted into the Technology Robotix Society, in hopes to organize more such interactive events and help develop the robotics culture in Kharagpur even further!
 
But that’s not all! K.R.A.I.G 101 is scheduled to be followed by hands-on sessions to aid practical learning for a more integrated approach to learn the concepts involved in robotics. There are similar K.R.A.I.G workshops yet to come and other exciting challenges for everyone to participate in! Classes will be organized to teach the mechanical aspects, basics of electronics and Computer Vision required to build the fascinating robots we see around us. Here’s to having a lot more fun and making our very own bots in the days to come!
""";

class Home extends StatefulWidget {
  static const cardHeightFraction = 0.7;
  static String tag = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _cardHeight;
  ScrollController _scrollController;
  bool _showTitle;
  bool _showToolbarColor;

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    super.dispose();
  }

  @override
  void initState() {
    _cardHeight = 0;
    _showTitle = false;
    _showToolbarColor = false;
    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final showTitle = _scrollController.offset > _cardHeight - kToolbarHeight;

    final showToolbarColor = _scrollController.offset > kToolbarHeight;

    if (showTitle != _showTitle || showToolbarColor != _showToolbarColor) {
      setState(() {
        _showTitle = showTitle;
        _showToolbarColor = showToolbarColor;
      });
    }
  }

  Widget _buildCard() {
    return PokeContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      children: <Widget>[
        SizedBox(height: 100),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Are you looking for \nAny Robotics Help",
            style: TextStyle(
              fontSize: 30,
              height: 0.9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 40),
        SearchBar(),
        SizedBox(height: 42),
        SizedBox(
          height: 300,
          child: Markdown(
            data: _markdownData,
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              textAlign: WrapAlignment.center,
              unorderedListAlign: WrapAlignment.center,
              orderedListAlign: WrapAlignment.center,
              h1Align: WrapAlignment.center,
              h2Align: WrapAlignment.center,
              // h6Align: WrapAlignment,
            ),
          ),
        ),
        // CategoryList(),
      ],
    );
  }

  Widget _buildNews() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 28, right: 28, top: 0, bottom: 22),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Robotics News",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.indigo,
                ),
              ),
            ],
          ),
        ),
        NewsList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    _cardHeight = screenHeight * Home.cardHeightFraction;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: _cardHeight,
            floating: true,
            pinned: true,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Colors.red,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: _showTitle
                  ? Text(
                      "RBTX",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : null,
              background: _buildCard(),
            ),
          ),
        ],
        body: _buildNews(),
      ),
    );
  }
}
