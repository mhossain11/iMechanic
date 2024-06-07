import 'package:flutter/material.dart';
import 'package:imechanic/features/presentationLayer/pages/createpost/createpost.dart';

import '../../widget/buttons.dart';
import '../searchallpost/searchallpost.dart';
import '../viewownpost/viewownpost.dart';
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Md Jakir Hossain',overflow: TextOverflow.ellipsis,),
        centerTitle: true,
        backgroundColor: Colors.red[100],
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 15,
            backgroundImage:AssetImage('assets/images/others/screen3.png'),
          ),
        ),
        actions: [
          PopupMenuButton(
          itemBuilder: (context){
            return [
              PopupMenuItem(
                  onTap: (){},
                  value: '1',
                  child: const Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8,),
                      Text('Settings',)
                    ],
                  )),
               PopupMenuItem(
                onTap: (){},
                  value: '1',
                  child: const Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8,),
                      Text('Logout')
                    ],
                  )),
            ];
          })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButtons(
              fixedSize: const Size(300,50),
              side: const BorderSide(color: Color(0xffc1262c)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              onPressed: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> const YesMechanic()));
              },
              child:const Text('Notifications',style: TextStyle(color: Colors.black),)
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: Color(0xffc1262c)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreatePost()));
            }
            , child: const Text('New post',style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 10,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: Color(0xffc1262c)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  ViewOwnPost()));
            }
            , child: const Text('View own posts',style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 10,),
          ElevatedButtons(
            fixedSize: const Size(300,50),
            side: const BorderSide(color: Color(0xffc1262c)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  SearchAllPost()));
            }
            , child:const Text('Search all posts',style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
