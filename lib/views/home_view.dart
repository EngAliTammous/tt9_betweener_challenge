


import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/add_edit_link_view.dart';
import 'package:tt9_betweener_challenge/views/serach_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_add_link.dart';
import 'package:tt9_betweener_challenge/views/widgets/scan_screen.dart';
import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User?> user;
  late Future<List<Link>> links;
   List _items = [];
TextEditingController search = TextEditingController();




  @override
  void initState() {
    user = getLocalUser();
    links =  getLinks(context);
    updateScreen();

    super.initState();
  }

  Future updateScreen() async {
setState(() {
  links = getLinks(context);
});

  }

  Future<void> _refreshLinks() async {
    await updateScreen();
  }

/*
  void readApi() async {

    setState(() {
      _items = data;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.close,color: Colors.black,), onPressed: (){
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginView.id, // Replace with the route name of your login screen
                (Route<dynamic> route) => false,
          );
        }),
        actions: [
          IconButton(
              onPressed: (){
           Navigator.pushNamed(context, SearchView.id);
          }, icon:const Icon(Icons.search,color: Colors.black,size: 28,)),
          IconButton(onPressed: (){
                   Navigator.pushNamed(context, ScanView.id);
          }, icon:const Icon(Icons.qr_code_rounded,color: Colors.black,size: 28)),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          onRefresh: _refreshLinks,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1,),

              FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Hello ${snapshot.data?.user?.name}!',style :const TextStyle(color: kPrimaryColor , fontSize: 28,fontWeight: FontWeight.bold));
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Spacer(),

              Flexible(
                flex: 10,
                child: Center(
                  child: Image.asset('assets/imgs/qr_code.png'),
                ),
              ),
              const Spacer(),

              FutureBuilder(
                future: links,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                   return const Column(
                     children: [
                       Center(child: CircularProgressIndicator()),
                       SizedBox(height: 16),
                       Text(
                         'تأكد من اتصال الانترنت أو انتظر دقائق وسيتم فتح التطبيق شكرا لك ',
                         style: TextStyle(color: kOnSecondaryColor, fontSize: 14),
                       ),
                     ],
                   );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: CustomAddLinkWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  AddEditLinkView(checkAdd: true),
                              ),
                            ).then((returnedData) {
                              if (returnedData == true) {
                                _refreshLinks();
                              }
                            });
                          },
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 8.5,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (context, index) {
                            if (index == snapshot.data!.length) {
                              return CustomAddLinkWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                       AddEditLinkView(checkAdd: true),
                                    ),
                                  ).then((returnedData) {
                                    if (returnedData == true) {
                                      _refreshLinks();
                                    }
                                  });
                                },
                              );
                            }

                            final linkTitle = snapshot.data![index].title!.toUpperCase();
                            final linkUserName = snapshot.data![index].link;

                            return Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: kHomeContainerColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    linkTitle,
                                    style: const TextStyle(
                                        color: kOnSecondaryColor, fontSize: 20),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    '@${linkUserName ?? 'New Account'}',
                                    style: const TextStyle(
                                        color: kOnSecondaryColor, fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5,),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),

              const Spacer(flex: 4,),
            ],
          ),
        ),

      ),
    );
  }
}
