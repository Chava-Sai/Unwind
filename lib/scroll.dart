import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  double _imageOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.05;
    final panelHeightOpen = MediaQuery.of(context).size.height * 1.0;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image/back.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(_imageOpacity),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
        ),
      ],
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
                      onTap: () {Navigator.pushNamed(context, 'chat');},
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 20, right: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
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
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage('Assets/image/chatbot-1.png'),
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
                                      image: AssetImage('Assets/image/chatbot-2.png'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.white.withOpacity(0.9),
                                        BlendMode.dstATop,
                                      ),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 28),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                childCount: 4,
              ),
            )
            ,


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
