import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/model/fake_data.dart';
import '../constant/my_colors.dart';
import '../component/my_componenet.dart';
import '../constant/my_strings.dart';


class MyCats extends StatefulWidget {
  const MyCats({Key? key}) : super(key: key);

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double bodyMargin = MediaQuery.of(context).size.width / 10;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              SvgPicture.asset(
                'assets/images/techblog.svg',
                height: 100,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                MyString.successfulRegister,
                style: textTheme.headline4,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'نام و نام خانوادگی',
                    hintStyle: textTheme.headline5),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                MyString.chooseCats,
                style: textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 85,
                  child: GridView.builder(
                    itemCount: tagList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!selectedTags.contains(tagList[index])) {
                                selectedTags.add(tagList[index]);
                              } else {
                                print('dar list mojod ast');
                              }
                            });
                          },
                          child: MainTags(textThem: textTheme, index: index));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Image.asset(
                'assets/images/arow.png',
                scale: 2,
              ),


              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 85,
                  child: GridView.builder(
                    itemCount: selectedTags.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.2),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: SolidColors.surface,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedTags[index].title,
                                style: textTheme.headline4,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedTags.removeAt(index);
                                    });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    size: 20,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
