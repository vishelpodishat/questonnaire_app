import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    surveyDataModel = GetTasksRepo().getTasksById(widget.surveyId);
  }

  void nextPage() {
    setState(() {
      currentPageIndex++;
    });
  }

  void previousPage() {
    setState(() {
      currentPageIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Опросник',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: Color(0xff27272E),
          ),
        ),
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Survey not found'));
          } else {
            final surveyData = snapshot.data;
            final currentPage = surveyData?.data?.pages?[currentPageIndex];

            return currentPage == null
                ? Center(child: Text('No pages available'))
                : Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPage.question ?? "",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Color(0xff27272E),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        if (currentPage.type == "multiple-choice")
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentPage.options?.length ?? 0,
                            itemBuilder: (context, index) {
                              final option = currentPage.options![index];
                              return ListTile(
                                title: Text(option),
                                onTap: () {},
                              );
                            },
                          ),
                        if (currentPage.type == "checkbox")
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentPage.options?.length ?? 0,
                            itemBuilder: (context, index) {
                              final option = currentPage.options![index];
                              return CheckboxListTile(
                                title: Text(option),
                                value: false,
                                onChanged: (bool? value) {},
                              );
                            },
                          ),
                        if (currentPage.type == 'banner')
                          Center(
                            child: Image.network(currentPage.image ?? ""),
                          ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
