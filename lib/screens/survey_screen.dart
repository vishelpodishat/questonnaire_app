import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:questonnaire_app/core/emojis.dart';
import 'package:questonnaire_app/data/models/survey_data_model.dart';
import 'package:questonnaire_app/data/repositories/get_tasks_repo.dart';

class SurveyScreen extends StatefulWidget {
  final String surveyId;
  const SurveyScreen({super.key, required this.surveyId});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late Future<SurveyDataModel> surveyDataModel;
  int currentPageIndex = 0;
  final Random _random = Random();
  late List<bool> _checkBoxStates;
  bool allQuestionsCompleted = false;

  @override
  void initState() {
    super.initState();
    surveyDataModel = GetTasksRepo().getTaskById(widget.surveyId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    surveyDataModel.then((data) {
      setState(() {
        _checkBoxStates = List<bool>.filled(
            data.data.pages[currentPageIndex].options.length, false);
      });
    });
  }

  void nextPage() {
    setState(() {
      if (currentPageIndex < 4) {
        currentPageIndex++;
        surveyDataModel.then((data) {
          setState(() {
            _checkBoxStates = List<bool>.filled(
                data.data.pages[currentPageIndex].options.length, false);
          });
        });
      } else {
        allQuestionsCompleted = true;
      }
    });
  }

  void previousPage() {
    setState(() {
      if (currentPageIndex > 0) {
        currentPageIndex--;
        surveyDataModel.then((data) {
          setState(() {
            _checkBoxStates = List<bool>.filled(
                data.data.pages[currentPageIndex].options.length, false);
          });
        });
      }
      if (currentPageIndex < 4) {
        allQuestionsCompleted = false;
      }
    });
  }

  double calculateProgress(int totalPages) {
    return (currentPageIndex + 1) / totalPages;
  }

  String getRandomEmoji() {
    return emojis[_random.nextInt(emojis.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9FB),
      appBar: AppBar(
        title: const Text(
          'Опросник',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: Color(0xff27272E),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/icons/trailing_icon.svg"),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xff8E8E93).withOpacity(0.08),
            height: 1.0,
          ),
        ),
      ),
      body: FutureBuilder<SurveyDataModel>(
        future: surveyDataModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Survey not found'));
          } else {
            final surveyData = snapshot.data!;
            final pages = surveyData.data.pages;

            if (pages.isEmpty) {
              return const Center(child: Text('No pages available'));
            }

            final currentPage = pages[currentPageIndex];

            if (_checkBoxStates == null ||
                _checkBoxStates.length != currentPage.options.length) {
              _checkBoxStates =
                  List<bool>.filled(currentPage.options.length, false);
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 8,
                    width: 195,
                    decoration: BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: const Color(0xff8e8e9333).withOpacity(0.20),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: calculateProgress(pages.length),
                      child: Container(
                        color: const Color(0xff29B1DD),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: allQuestionsCompleted
                        ? const Center(
                            child: Text(
                              'Спасибо за ваши ответы!',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color(0xff17B582),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentPage.question,
                                style: const TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  color: Color(0xff27272E),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (currentPage.type == "multiple-choice")
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: currentPage.options.length,
                                  itemBuilder: (context, index) {
                                    final option = currentPage.options[index];
                                    return Container(
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          option,
                                          style: const TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Color(0xff27272E),
                                          ),
                                        ),
                                        leading: Text(
                                          getRandomEmoji(),
                                          style: const TextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                ),
                              if (currentPage.type == "checkbox")
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: currentPage.options.length,
                                  itemBuilder: (context, index) {
                                    final option = currentPage.options[index];
                                    return SizedBox(
                                      height: 52,
                                      child: CheckboxListTile(
                                        title: Text(
                                          option,
                                          style: const TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Color(0xff27272E),
                                          ),
                                        ),
                                        value: _checkBoxStates[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _checkBoxStates[index] =
                                                !_checkBoxStates[index];
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                ),
                              if (currentPage.type == 'banner')
                                Center(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 350,
                                      maxHeight: 250,
                                    ),
                                    child: Image.network(
                                      currentPage.image,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return const Center(
                                            child:
                                                Text('Failed to load image'));
                                      },
                                    ),
                                  ),
                                ),
                              const Spacer(),
                              if (!allQuestionsCompleted)
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: previousPage,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(83, 52),
                                        backgroundColor:
                                            const Color(0xffDDEEF6),
                                        foregroundColor:
                                            const Color(0xff29B1DD),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        elevation: 0,
                                      ),
                                      label: SvgPicture.asset(
                                          "assets/icons/arrow_left.svg"),
                                    ),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                      onPressed: nextPage,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(270, 52),
                                        foregroundColor:
                                            const Color(0xffF4F7F8),
                                        backgroundColor:
                                            const Color(0xff29B1DD),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'Дальше',
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
