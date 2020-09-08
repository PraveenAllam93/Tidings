
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_project/screen/posts/posts.dart';

class Bot extends StatefulWidget {
  @override
  _BotState createState() => _BotState();
  
}

class _BotState extends State<Bot> {


  void response(query) async {
    
    AuthGoogle authgoogle = await AuthGoogle(fileJson: "assets/tidingschatbot-woughn-ef4239cde865.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authgoogle,language: Language.english);
    if(query.isNotEmpty && query != null){
      
        AIResponse aiResponse = await dialogflow.detectIntent(query);
        setState(() {
          messages.insert(0,{"data":0,
          "message":aiResponse.getListMessage()[0]["text"]["text"][0]});
        });

        if(aiResponse.getListMessage()[0]["text"]["text"][0] == "You are being redirected to posts."){
          setState(() {
            Fluttertoast.showToast(
                msg: "You are being redirected to posts!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0
            );
            Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Posts()));
        });
      }    
    }
  }


  final messageInsert = TextEditingController();
  List<Map> messages = List();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text('Tidings Bot!'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children : <Widget>[
            Flexible(child: ListView.builder(
              
              
              reverse:  true,
              padding: EdgeInsets.all(10.0),
              itemCount: messages.length,
              
              itemBuilder: (context,index) => messages[index]["data"] == 0 
              ? Container(
                child:ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                  leading: Icon(Icons.adb),
                  title:Align(
                child: new Text("Bot",style: TextStyle(fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey,
                              ),),
                alignment: Alignment(-1.2, 0),
              ),
              subtitle:Align(
                child: new Text(messages[index]["message"].toString(),style: TextStyle(fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                              ),),
                alignment: Alignment(-1.2, 0),
              ),
                )
              ):
 
                  
                
              Container(
                child:ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                  trailing: Icon(Icons.person),
                  title : Text("Me",textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  fontSize: 14,
                    color: Colors.grey,
                    ),),

                
                subtitle : Text(messages[index]["message"].toString(),textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                    ),)))

            ),),
            Divider(height: 3.0,),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              margin :const EdgeInsets.symmetric(horizontal : 8.0),
              child: Row(children: <Widget>[
                Flexible(child: TextField(
                  controller: messageInsert,


                  decoration: InputDecoration.collapsed(
                    hintText: "Type your Message",


                  ),

                )),
                Container(
                  margin :const EdgeInsets.symmetric(horizontal : 4.0),
                  child: IconButton(icon: Icon(Icons.send), onPressed: (){
                    if(messageInsert.text.isEmpty){
                      print("Can't send Empty Message.");
                    }
                    else{
                      
                      setState(() {
                        messages.insert(0, {"data":1,
                        "message":messageInsert.text});
                      });
                      response(messageInsert.text);
                      messageInsert.clear();
                    }
                  }),
              

                )
              ],),
            )

          ]
        )
        )
      
     
            
    );
  }
  
}