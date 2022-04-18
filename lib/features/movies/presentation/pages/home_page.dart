import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        _scrollOffset = _controller.offset;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Container(
                color: Colors.black.withOpacity((_scrollOffset / 350).clamp(0, 1)),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Movie App'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.camera_outdoor),
                          Expanded(child: SizedBox()),
                          IconButton(onPressed: () {}, icon: Icon(Icons.search))
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('Tv Series'), Text('Tv Series')],
                      )
                    ],
                  ),
                )),
          ),
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(
                child: Stack(alignment: Alignment.center, children: [
              Container(
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('http://www.impawards.com/2022/posters/uncharted_ver2.jpg'), fit: BoxFit.cover))),
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                child: SizedBox(
                    width: 250,
                    child: Text(
                      'uncharted',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Positioned(
                bottom: 40,
                child: Container(
                    width: 100,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.redAccent),
                    child: Text('Now Playing')),
              )
            ])),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('top rated'),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: 2,
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            margin: EdgeInsets.all(8),
                            child: Image.network('https://lumiere-a.akamaihd.net/v1/images/p_aladdin2019_17638_d53b09e6.jpeg'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
