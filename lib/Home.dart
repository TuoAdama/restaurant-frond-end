import 'package:flutter/material.dart';
import 'package:restaurant/layouts/CommandePage.dart';
import 'package:restaurant/layouts/cookie_page.dart';
import 'package:restaurant/models/personnel.dart';
import 'layouts/bottom_bar.dart';
import 'models/commande.dart';
import 'models/plat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController? _tabController;
  List<Commande> commandes = [];

  List plats = <Plat>[
    Plat(id: 1, category: "cat 1", imagePath: 'assets/img_1.png', name: "Plat 1", price: "1500"),
    Plat(id: 2, category: "cat 2", imagePath: 'assets/img_2.png', name: "Plat 2", price: "400"),
    Plat(id: 3, category: "cat 1", imagePath: 'assets/img_3.png', name: "Plat 3", price: "2500"),
    Plat(id: 4, category: "cat 2", imagePath: 'assets/img_4.png', name: "Plat 4", price: "4500"),
  ];

  late CookiePage cookie1;
  late CookiePage cookie2;
  late CookiePage cookie3;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    cookie1 = CookiePage(plats: plats);
    cookie2 = CookiePage(plats: plats);
    cookie3 = CookiePage(plats: plats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68),),
          onPressed: (){},
        ),
        title: Text(
          'Menus',
          style: TextStyle(
            fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.fastfood, color: Color(0xFF545D68),),
            onPressed: () async{

              commandes = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommandePage(commandes: cookie1.commandes, personnel: Personnel(id: 1, nom: "Tuo", prenom: "Adama", dateNaissance: "dateNaissance", idPoste: 3),),));
              cookie1.setCommandes = commandes;

              commandes.forEach((element) {
                  print("Plat: ${element.plat.name}, quantite: ${element.quantite}");
              });
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: [
          SizedBox(height: 15.0,),
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 40.0,
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0,),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xFFC88D67),
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 45.0),
            unselectedLabelColor: Color(0xFFCDCDCD),
            tabs: [
              Tab(
                child: Text('Boisson',
                style: TextStyle(
                    fontSize: 21.0,
                    fontFamily: 'Varela'
                ),
                ),
              ),
              Tab(
                child: Text('Placali',
                  style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Varela'
                  ),
                ),
              ),
              Tab(
                child: Text('Alloco',
                  style: TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Varela'
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: TabBarView(
              controller: _tabController,
              children: [cookie1, cookie1, cookie3],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
