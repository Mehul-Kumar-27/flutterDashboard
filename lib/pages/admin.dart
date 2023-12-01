// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/components/headerWidget.dart';
import 'package:admin/components/nameHeaderWidget.dart';
import 'package:admin/components/sideSectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin/bloc/admin_bloc.dart';
import 'package:admin/bloc/admin_events.dart';
import 'package:admin/bloc/admin_states.dart';
import 'package:admin/constants.dart';
import 'package:admin/models.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    BlocProvider.of<FetchUsersBloc>(context).add(GetUserEvents());
    super.initState();
  }

  List<User> listToShow = [];
  List<User> searchList = [];
  List<User> deleteList = [];

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;
    double currentRatio = MediaQuery.of(context).size.aspectRatio;
    double currentFont = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(
                  currentHeight: currentHeight,
                  currentWidth: currentWidth,
                  currentRatio: currentRatio),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SideSectionWidget(
                      currentRatio: currentRatio,
                      currentWidth: currentWidth,
                      currentHeight: currentHeight),
                  Padding(
                    padding: EdgeInsets.only(
                        left: currentRatio * 10, right: currentRatio * 10),
                    child: Container(
                        width: currentWidth * 0.75,
                        height: currentHeight,
                        color: backgroundColor,
                        child: BlocConsumer<FetchUsersBloc, FetchUsersState>(
                          listener: (context, state) {
                            if (state is FetchUserSuccess) {
                              listToShow = state.usersList;
                            }
                          },
                          builder: (context, state) {
                            if (state is FetchUserLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Container(
                                  width: currentWidth * 75,
                                  height: currentHeight * 0.17,
                                  color: secondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Dashboard",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: currentFont * 20),
                                            ),
                                            IconButton(
                                                hoverColor: backgroundColor,
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: currentRatio * 10),
                                  child: Container(
                                    width: currentWidth * 75,
                                    height: currentHeight * 0.6,
                                    color: secondaryColor,
                                    child: Column(
                                      children: [
                                        NameEmailHeaderWidget(
                                            currentHeight: currentHeight,
                                            currentWidth: currentWidth),
                                        Expanded(
                                            child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            return UserCard(
                                              user: listToShow[index],
                                              isSelected: deleteList
                                                  .contains(listToShow[index]),
                                              onCheckboxChanged: (value) {
                                                setState(() {
                                                  if (value == true) {
                                                    deleteList
                                                        .add(listToShow[index]);
                                                  } else {
                                                    deleteList.remove(
                                                        listToShow[index]);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                          itemCount: 30,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: currentWidth * 75,
                                  height: currentHeight * 0.15,
                                  color: secondaryColor,
                                )
                              ],
                            );
                          },
                        )),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class UserCard extends StatefulWidget {
  final User user;
  final bool isSelected;
  final ValueChanged<bool?> onCheckboxChanged;

  const UserCard({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double currentFont = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.17,
              child: Row(
                children: [
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: widget.onCheckboxChanged,
                  ),
                  SizedBox(
                    width: width * 0.007,
                  ),
                  isEditing
                      ? SizedBox(
                          width: width * 0.1,
                          child: TextField(
                            controller: _nameController,
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.white70,
                                fontSize: currentFont * 16),
                          ),
                        )
                      : Text(
                          widget.user.name!,
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70,
                              fontSize: currentFont * 16),
                        ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isEditing
                      ? SizedBox(
                          width: width * 0.1,
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.white70,
                                fontSize: currentFont * 15),
                          ),
                        )
                      : Text(
                          widget.user.email!,
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70,
                              fontSize: currentFont * 15),
                        ),
                  SizedBox(
                    width: width * 0.007,
                  )
                ],
              ),
            ),
            Text(
              widget.user.role!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: currentFont * 15,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              width: width * 0.065,
              height: height * 0.04,
              child: Row(
                children: [
                  IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {
                      setState(() {
                        if (isEditing) {
                          // Save changes
                          widget.user.name = _nameController.text;
                          widget.user.email = _emailController.text;
                          isEditing = false;
                        } else {
                          // Start editing
                          _nameController.text = widget.user.name!;
                          _emailController.text = widget.user.email!;
                          isEditing = true;
                        }
                      });
                    },
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text(
                                "Are you sure you want to delete ${widget.user.name}?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Remove user from the listToShow
                                  //listToShow.remove(widget.user);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
