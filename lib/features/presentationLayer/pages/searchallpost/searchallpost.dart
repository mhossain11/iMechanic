import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/userdataModel.dart';
import '../../../data/repositiory/viewownpostrepositiory.dart';
import '../../bloc/viewownpostcubit/view_own_post_cubit.dart';
import '../../widget/textformfield.dart';
import '../requestdetails/requestdetails.dart';

class SearchAllPost extends StatefulWidget {
  const SearchAllPost({super.key});

  @override
  State<SearchAllPost> createState() => _SearchAllPostState();
}

class _SearchAllPostState extends State<SearchAllPost> {
  final TextEditingController searchController = TextEditingController();
  late ViewOwnPostCubit viewOwnPostCubit;
  List<Requests>userdata=[];
  List<Requests>data=[];
  late String _name ='';

  @override
  void initState() {
    super.initState();
    viewOwnPostCubit = ViewOwnPostCubit(ViewOwnPostRepository());
    viewOwnPostCubit.fetchData();
    data=userdata;
  }

  String search ='';


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormFields(
                onChanged: (value){
                  setState(() {
                    search =value.toString();
                    data= userdata.where((user)=> user.name!.contains(search) ||
                        user.description!.contains(search)
                    ).toList();

                  });
                },
                minLines: 1,
                maxLines: 1,
                hint: 'Search',
                keyboardType: TextInputType.text,
                controller: searchController,
                //filled: true,
                suffixIcon: IconButton(
                    onPressed: (){setState(() {
                      searchController.clear();
                      search="";
                      data = userdata;
                    });}, icon: searchController.text.isEmpty? const SizedBox()  :const Icon(Icons.close,color: Colors.black12)),
                validators: (value){
                  return null;
                }),
          ),
          const SizedBox(height: 20,),
          Expanded(

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: BlocBuilder< ViewOwnPostCubit, ViewOwnPostCubitState>(
                  bloc: viewOwnPostCubit,
                  builder: (context, state) {
                    if(state is ViewOwnPostLoadedCubitState){

                      userdata.addAll(state.userdataModel.data!.requests!);

                      return SizedBox(
                        width: 360,
                        child: DataTable(
                            dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[200]),
                            headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.red[100]),
                            border: const TableBorder.symmetric(
                              outside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid,),
                              inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                            ),
                            columnSpacing: 50,
                            columns: const [

                              DataColumn(label: Text('Title',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                              DataColumn(label: Text('Types',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))),
                              DataColumn(label: Text('Replies',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))),
                            ],
                            decoration: const BoxDecoration(),
                            headingTextStyle: const TextStyle(color: Colors.green),
                            onSelectAll: (value){
                              if(value == true){
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RequestDetails()));
                              }else{

                              }
                            },
                            rows:  List.generate(data.length, (index){
                              _name = data[index].description.toString();
                              return DataRow(
                                  cells: [
                                    //DataCell(ElevatedButton(onPressed: () {  }, child: null,)),
                                    DataCell(Text( _name.length > 10 ? '${_name.substring(0, 10)}...' : _name,overflow: TextOverflow.ellipsis)),
                                    DataCell(Text(data[index].message.toString())),
                                    DataCell(Text(data[index].issueResponsesCount.toString())),
                                  ]);

                            }

                            ).toList()

                        ),
                      );
                    }else if(state is ViewOwnPostErrorCubitState){
                      //   print(state.errorMessage);
                      return  Container(child: Text(state.errorMessage),);
                    }else if(state is ViewOwnPostLoadingCubitState){
                      return const Center(child: CircularProgressIndicator(color: Colors.green,));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
