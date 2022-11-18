import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image:
      DecorationImage(image: AssetImage('assets/login.png'),fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35,top: 150),
              child: Text('Welcome/\nस्वागत आहे',style: TextStyle(color:Colors.white,
              fontSize: 33,),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.5,right:35,left:35),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Mobile No./मोबाईल नं',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.grey.shade100,
                        filled: true
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password/पासवर्ड',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.grey.shade100,
                          filled: true
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sign In/लॉगिन',style: TextStyle(
                            color:Color(0xff4c505b),
                            fontSize: 27,fontWeight: FontWeight.w700
                        ),),
                        CircleAvatar(
                          radius: 30,backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: (){},
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, 'register');
                        }, child: Text('Register/नोंदणी',style: TextStyle(
                          decoration: TextDecoration.underline,
                            fontSize:18,
                          color: Color(0xff4c505b)
                        ),)),
                        TextButton(onPressed: (){}, child: Text('Forget Password\n/पासवर्ड विसरलात',style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize:18,
                            color: Color(0xff4c505b)
                        ),))
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        )
      ),
    );
  }
}
