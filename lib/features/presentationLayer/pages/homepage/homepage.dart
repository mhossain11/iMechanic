import 'package:flutter/material.dart';
import '../../widget/buttons.dart';
import '../loginpage/loginpage.dart';
import '../registerpage/registerpage.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){},
                  color: Colors.white,
                  child: const Text('About Us',style: TextStyle(color: Colors.grey),)),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CustomButton(
                  height: 50,
                  onPressed: (){},
                  color: Colors.white,
                  child: const Text('Contact Us',style: TextStyle(color: Colors.grey),)),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
          width: 300,
          child: Image.asset('assets/animations/surefix2.png',
            fit: BoxFit.fitWidth,),),


          const SizedBox(height: 40,), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            CustomButton(
              height: 50,
              width: 340,
              elevation: 4,
              color: const Color(0xffc1262c),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RegisterPage()));
              }, child: const Text('Register',style: TextStyle(color: Colors.white),),

            ),
          ],),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButtons(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
                  },

                    // maximumSize: const Size(340, 50),
                    minimumSize: const Size(340, 50),
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black,
                    side: const BorderSide(color: Colors.red,width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                  child: const Text('Log In',style: TextStyle(color: Color(0xffc1262c)),))
            ],
          ),
          const SizedBox(height: 10,),


        ],
      ),
    );
  }
}
