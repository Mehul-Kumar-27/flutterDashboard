// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:admin/components/bottomSectionWidger.dart';
import 'package:admin/components/userCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin/bloc/admin_bloc.dart';
import 'package:admin/bloc/admin_events.dart';
import 'package:admin/bloc/admin_states.dart';
import 'package:admin/components/headerWidget.dart';
import 'package:admin/components/nameHeaderWidget.dart';
import 'package:admin/components/sideSectionWidget.dart';
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

  List<User> origianlList = [];
  List<User> listToShow = [];
  List<User> searchList = [];
  List<User> deleteList = [];

  int totalPage = 0;
  int currentPage = 1;

  nexPage() {
    if (currentPage < totalPage) {
      setState(() {
        currentPage++;
        listToShow = getPaginatedList();
      });
    }
  }

  prevPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        listToShow = getPaginatedList();
      });
    }
  }

  calculatePage() {
    setState(() {
      totalPage = (origianlList.length / 10).ceil();
    });
  }

  List<User> getPaginatedList() {
    int start = (currentPage - 1) * 10;
    int end = min(currentPage * 10, origianlList.length);
    return origianlList.sublist(start, end);
  }

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
                              //listToShow = state.usersList;
                              origianlList = state.usersList;
                              calculatePage();
                              listToShow = getPaginatedList();
                            }
                            if (state is DeleteSelectedUserSuccessState) {
                              listToShow = state.usersList;
                              origianlList = state.usersList;
                              deleteList = [];
                            }
                            if (state is SearchQueryState) {
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
                                            TextButton.icon(
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              FetchUsersBloc>(
                                                          context)
                                                      .add(
                                                          DeleteSelectedUserEvent(
                                                              listToShow:
                                                                  listToShow,
                                                              listToDelete:
                                                                  deleteList));
                                                },
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                ),
                                                label: const Text(
                                                  "Delete Selected",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ))
                                          ],
                                        ),

                                        // Search Bar

                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: currentRatio * 10),
                                          child: Container(
                                            width: currentWidth * 0.4,
                                            height: currentHeight * 0.05,
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: currentWidth * 0.2,
                                                  height: currentHeight * 0.05,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: currentRatio * 10,
                                                        bottom: currentRatio),
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.start,
                                                      onChanged: (value) {
                                                        BlocProvider.of<
                                                                    FetchUsersBloc>(
                                                                context)
                                                            .add(SearchUserEvent(
                                                                value,
                                                                listToShow));
                                                      },
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              currentFont * 15),
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Search by Query",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize:
                                                                  currentFont *
                                                                      15),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: currentWidth * 0.1,
                                                  height: currentHeight * 0.05,
                                                  decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextButton.icon(
                                                      onPressed: () {
                                                        setState(() {
                                                          listToShow =
                                                              origianlList;
                                                          deleteList = [];
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.restore),
                                                      label: const Text(
                                                        "Reset",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
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
                                              onDelete: () {
                                                setState(() {
                                                  listToShow.remove(
                                                      listToShow[index]);
                                                });
                                              },
                                            );
                                          },
                                          itemCount: min(10, listToShow.length),
                                        )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: currentRatio * 5,
                                              bottom: currentRatio * 5,
                                              left: currentRatio * 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${deleteList.length} row(s) selected",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: currentFont * 15),
                                              ),

                                              // Pagination
                                              SizedBox(
                                                width: currentWidth * 0.3,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        hoverColor:
                                                            Colors.white30,
                                                        onPressed: prevPage,
                                                        icon: const Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.white,
                                                        )),
                                                    Text(
                                                      "$currentPage of $totalPage",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    IconButton(
                                                        hoverColor:
                                                            Colors.white30,
                                                        onPressed: nexPage,
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                BottomSectionWidget(
                                    currentWidth: currentWidth,
                                    currentHeight: currentHeight)
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
