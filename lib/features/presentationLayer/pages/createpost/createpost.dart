import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../widget/buttons.dart';
import '../../widget/textformfield.dart';
class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
 final  TextEditingController textController = TextEditingController();
 final  TextEditingController descriptionController = TextEditingController();
 File? documentsImage;
 bool isVisible = false;
 @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Md Jakir Hossain',overflow: TextOverflow.ellipsis,),
        centerTitle: true,
        backgroundColor: Colors.white70,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 15,
            backgroundImage:AssetImage('assets/images/others/ImechanicLogo-01.png'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.app_registration),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Registration number',style: TextStyle(fontWeight:FontWeight.bold),),
              ),
            ],),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
            children: [
            /* Expanded(
              child: ElevatedButtons(
                fixedSize: const Size(300,50),
                side: const BorderSide(color: Colors.black26),
                backgroundColor: Colors.brown,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onPressed: (){
                  setState(() {
                    if(requestController.textController.text.isNotEmpty){
                      isVisible = !isVisible;
                      print('isVisible:$isVisible');
                    } else{
                      print('Not Work');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter your Registration Number!"),
                        ),
                      );
                    }
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreatePost()));
                }
                , child:const Text('Registration',style: TextStyle(color: Colors.white)) ,
              ),),*/
            const SizedBox(width: 5,),
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormFields(
                controller: textController,
                hint: 'Registration number',
                minLines: 1,
                maxLines: 1,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isVisible =false;
                    });
                    textController.clear();
                  },
                  icon:textController.text.isNotEmpty? const Icon(Icons.clear,color: Colors.black12,):const SizedBox(),
        
                ),
                keyboardType: TextInputType.text,
                enabledBorderSide: const BorderSide(color: Colors.grey),
                focusedBorderSide: const BorderSide(color: Colors.blue),
                validators: (String value) {
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10,),
            /*IconButton(
                onPressed: (){
              setState(() {
                if(textController.text.isNotEmpty){
                  isVisible = !isVisible;
                  print('isVisible:$isVisible');
                } else{
                  print('Not Work');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter your Registration Number!"),
                    ),
                  );
                }
              });
            },
                style: IconButton.styleFrom(backgroundColor: Colors.grey[200]),
                icon: const Icon(Icons.search))*/
              Container(
                height: 50.0,
                width: 50.0,
                decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.blue),
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0) //                 <--- border radius here
                  ),


                ),

                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if(textController.text.isNotEmpty){
                        isVisible = !isVisible;
                        print('isVisible:$isVisible');
                      } else{
                        print('Not Work');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter your Registration Number!"),
                          ),
                        );
                      }
                    });}, icon: const Icon(Icons.search),
                ),
              ),
        
        
          ],
        ),
            ),
            const SizedBox(height: 10,),
           Visibility(
            visible: isVisible,
            child: DataTable(
                dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.red[50]),
                headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.brown),
                border: const TableBorder.symmetric(
                  outside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid,),
                  inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                ),

                columnSpacing: 110,
                columns: const [

              DataColumn(label: Text('Make',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
              DataColumn(label: Text('Model',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
              DataColumn(label: Text('Year',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
            ],
                decoration: const BoxDecoration(

                ),
                headingTextStyle: const TextStyle(color: Colors.green),
                rows: const [
              DataRow(cells: [
                DataCell(Text('US')),
                DataCell(Text('BMW')),
                DataCell(Text('2006')),
              ])
            ]),
          ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.description),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('Description',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 10),
              child: TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description of problems',
                  enabledBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.grey), ),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue))
                ),
                keyboardType: TextInputType.text,
               // enabledBorderSide: const BorderSide(color: Colors.grey),
              //  focusedBorderSide: const BorderSide(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 10,),
            const Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.upload_file_sharp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Choose file',style: TextStyle(fontWeight:FontWeight.bold),),
              ),
            ],),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10.0,),
                  width: 370,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.black12)

                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          selectFile();
                        },
                        label: const Text('Import file', style: TextStyle(color: Colors.black)),
                        icon: const Icon(Icons.upload_file_sharp, color: Colors.black,),
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          fixedSize: const Size(200, 50),
                          side: const BorderSide(color: Colors.grey),
                          // backgroundColor: backgroundColor
                        ),
                      ),
                      const SizedBox(height: 10,),
                      documentsImage != null ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('File:${documentsImage!.path.toString().split("/")[documentsImage!.path.toString().split("/").length-1]} Added',overflow: TextOverflow.ellipsis,),
                      )
                          : const SizedBox(),
                      const SizedBox(height: 20,),
                      const Center(child: Text('Please Upload your video and image now.\n .mp4, .jpg',
                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButtons(
              onPressed: () {},
              fixedSize: const Size(370, 50),
              backgroundColor: const Color(0xffc1262c),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.save,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text('Submit', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
        
        
          ],
        ),
      ),
    );
  }
 selectFile() async{
   FilePickerResult? result = await FilePicker.platform.pickFiles();

   if (result != null) {
     setState(() {
       documentsImage = File(result.files.single.path!);
     });
     if (kDebugMode) {
       print(documentsImage?.path.toString());
     }
   } else {
     // User canceled the picker
   }
 }
}
