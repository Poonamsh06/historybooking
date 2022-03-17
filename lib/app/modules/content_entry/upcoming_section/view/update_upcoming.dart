import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/responshive.dart';
import '../../puja_view/controller/puja_add_controller.dart';
import '../controller/add_upcoming_controller.dart';

class UpdateUpcoming extends StatefulWidget {
  final String eventId;
  // final TextEditingController keyword ;
  // final TextEditingController price;
  // final TextEditingController duration;
  final String  updateName;
  final  String updateLocation;
  final  String updatePosition;
  const UpdateUpcoming({Key? key,required this.eventId, required this.updateName,required this.updateLocation, required this.updatePosition,}) : super(key: key);
  @override
  State<UpdateUpcoming> createState() => _UpdateUpcomingState();
}


class _UpdateUpcomingState extends State<UpdateUpcoming> {
  String image =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  AddUpcomingController controller = Get.put(AddUpcomingController());

  @override
  Widget build(BuildContext context) {
    TextEditingController _name =TextEditingController(text:widget.updateName);
    addEventTextField(_name, "Upcoming Name");

    TextEditingController _position =TextEditingController(text: widget.updatePosition);
    addEventTextField(_position, "Upcoming Position ");

    TextEditingController _location =TextEditingController(text:widget.updateLocation);
    addEventTextField(_location, "Upcoming Location ");
    // TextEditingController keyword = widget.keyword;
    // TextEditingController price = widget.price;
    // TextEditingController duration = widget.duration;

    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? const EdgeInsets.all(0)
          : EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.07),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image)),
                    ),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Alert"),
                                content: const Text(
                                    "Are you sure that you want to update this picture?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        FileUploadInputElement input =
                                        FileUploadInputElement()
                                          ..accept = 'image/*';
                                        FirebaseStorage fs =
                                            FirebaseStorage.instance;
                                        input.click();
                                        input.onChange.listen((event) {
                                          final file = input.files!.first;
                                          final reader = FileReader();
                                          reader.readAsDataUrl(file);
                                          reader.onLoadEnd
                                              .listen((event) async {
                                            var snapshot = await fs
                                                .ref(
                                                'PujaPurohitFiles/commonCollections')
                                                .child('${widget.eventId}')
                                                .putBlob(file);
                                            String downloadUrl =
                                            await snapshot.ref
                                                .getDownloadURL();
                                            setState(() {
                                              image = downloadUrl;
                                              //widget.onPressed(downloadUrl);
                                            });
                                          });
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Continue")),
                                ],
                              ));
                        },
                        child: const Text("Edit")),
                  ),
                  // ExpandablePanel(
                  //     header: redButton("Update Name"),
                  //     collapsed: const SizedBox(),
                  //     expanded: Column(children: _nameTextFields)),
                  // ExpandablePanel(
                  //     header: redButton("Update Description"),
                  //     collapsed: const SizedBox(),
                  //     expanded: Column(children: _descriptionTextFields)),
                  // ExpandablePanel(
                  //     header: redButton("Update Benefits"),
                  //     collapsed: const SizedBox(),
                  //     expanded: Column(children: _benefits)),
                  // ExpandablePanel(
                  //   header: addPujaTextField(keyword, "Update Puja Keyword"),
                  //   collapsed: const SizedBox(),
                  //   expanded: const SizedBox(),
                  // ),
                  // ExpandablePanel(
                  //   header: addPujaTextField(duration, "Update Puja Duration"),
                  //   collapsed: const SizedBox(),
                  //   expanded: SizedBox(),
                  // ),
                  // ExpandablePanel(
                  //   header: addPujaTextField(price, "Update Puja price"),
                  //   collapsed: const SizedBox(),
                  //   expanded: SizedBox(),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  GodCheckBox(text:"Update select God tags"),
                  const SizedBox(
                    height: 20,
                  ),
                  BenefitCheckBox(text:"Update benefit"),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: "Warning",
                          content: Text("Are you sure you want to remove ?"),
                          onConfirm: () {
                            //String names = [];
                            //String type;
                            // for (var element in controller.benefit.value) {
                            //   if(element['value']==true){
                            //     promises.add(element['type']);
                            //   }
                            // }
                            // for (var element in controller.god.value) {
                            //   if(element['value']==true){
                            //     gods.add(element['type']);
                            //   }
                            // }
                            // _name((element) {
                            //   names.add(_name);
                            // });
                            // _description.forEach((element) {
                            //   description.add(element.text);
                            // });
                            // _benifits.forEach((element) {
                            //   benefits.add(element.text);
                            // });
                            Future.delayed(Duration(seconds: 4), () async{
                              await FirebaseFirestore.instance
                                  .doc(
                                  '/PujaPurohitFiles/commonCollections/upcoming/#${widget.updatePosition}')
                                  .update({

                                'name':_name,
                                "detail":_location,
                                'image': image,
                                "nick":_name,
                                'end' :'',
                                'duration' :'',
                                'date':'',
                                "begin":".",
                                'color': ".",
                                'keyword' : _location,
                                'link' : _location,
                                'muhrat': '',
                                'num': _position,
                              });
                            });
                          },
                          onCancel: () {
                            Get.back();
                          });
                    },
                    child: redButton("Submit"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container redButton(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red, width: 2.0)),
      child: Text(text),
    );
  }

  Widget addEventTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 1,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: hintText,

            //make hint text
            hintStyle: const  TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

