import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:test1/db/notepage.dart';
import 'package:test1/login/login.dart';
import 'package:test1/screens/chat_screen.dart';
import 'package:test1/settings.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  double _imageOpacity = 1.0;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.07;
    final panelHeightOpen = MediaQuery.of(context).size.height * 1.0;
    final userName = Provider.of<UserName>(context).name;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/image/botback.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Scaffold(
            key: _globalKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                color: Colors.black,
                onPressed: () {
                  _globalKey.currentState!.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: Settings(),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Hi $userName",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),


            body: SlidingUpPanel(
              onPanelSlide: (double slideOffset) {
                final imageOpacity = 1 - slideOffset / 1.5;
                if (mounted) {
                  setState(() {
                    _imageOpacity = imageOpacity;
                  });
                }
              },
              minHeight: panelHeightClosed,
              maxHeight: panelHeightOpen,
              color: Colors.transparent,
              panelBuilder: (scrollController) => _buildPanel(scrollController),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              parallaxEnabled: true,
              parallaxOffset: .5,
            ),
            drawer: Drawer(
              width: 275,
              elevation: 30,
              backgroundColor: Color(0xF3393838),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(40))),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x3D000000),
                          spreadRadius: 30,
                          blurRadius: 20)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Icon(
                              //   Icons.arrow_back_ios,
                              //   color: Colors.white,
                              //   size: 20,
                              // ),
                              Text(
                                'Menu',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('Assets/image/google.png'),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Srinivas Sai',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.chat,
                              color: Colors.white,
                              size: 22,
                            ),
                            title: Text(
                              'Chat',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onTap: () {
                              Get.to(() => ChatScreen(),
                                  transition: Transition.rightToLeft);
                              // Navigate to Chat screen
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.book,
                              color: Colors.white,
                              size: 22,
                            ),
                            title: Text(
                              'Diary',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onTap: () {
                              Get.to(() => NotesPage(),
                                  transition: Transition.rightToLeft);
                              // Navigate to Diary screen
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 22,
                            ),
                            title: Text(
                              'Community',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onTap: () {
                              // Navigate to Community screen
                            },
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 22,
                        ),
                        title: Text(
                          'Logout',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        onTap: () async {
                          await GoogleSignIn().signOut();
                          FirebaseAuth.instance.signOut();
                          // Perform logout action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // drawer: Drawer(
            //   shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.horizontal(right: Radius.circular(40))),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       UserAccountsDrawerHeader(
            //         accountName: Text('Username'),
            //         accountEmail: Text('example@example.com'),
            //         currentAccountPicture: CircleAvatar(
            //           backgroundImage:
            //               NetworkImage('https://picsum.photos/200/300'),
            //         ),
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.chat),
            //         title: Text('Chat'),
            //         onTap: () {
            //           Navigator.pop(context);
            //           // Navigate to Chat screen
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.book),
            //         title: Text('Diary'),
            //         onTap: () {
            //           Navigator.pop(context);
            //           // Navigate to Diary screen
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.people),
            //         title: Text('Community'),
            //         onTap: () {
            //           Navigator.pop(context);
            //           // Navigate to Community screen
            //         },
            //       ),
            //       Expanded(child: Container()),
            //       Divider(),
            //       ListTile(
            //         leading: Icon(Icons.logout),
            //         title: Text('Logout'),
            //         onTap: () {
            //           Navigator.pop(context);
            //           // Perform logout action
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          )
        ],
      ),
    );
  }

  Widget _buildPanel(ScrollController scrollController) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  buildHeader(),
                  SizedBox(height: 18),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ChatScreen(),
                            transition: Transition.rightToLeft);
                      },
                      child: Hero(
                        tag: 'chat',
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, bottom: 20, right: 10),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'Assets/image/chatbot-1.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'Assets/image/chatbot-2.png'),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Colors.white.withOpacity(0.9),
                                                BlendMode.dstATop,
                                              ),
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 28),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'CHAT',
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(height: 15),
                                // Text(
                                //   'CHAT',
                                //   style: TextStyle(
                                //     fontSize: 32,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  SizedBox(
                    height: 10,
                  );
                  if (index == 1) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => NotesPage(),
                            transition: Transition.rightToLeft);
                      },
                      child: Hero(
                        tag: 'chat',
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, bottom: 20, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              child: Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('Assets/image/diary.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 70, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DIARY',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 20, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      );

  Widget buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: InkWell(
              onTap: () => {},
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      );
}
