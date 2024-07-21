import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:questonnaire_app/data/models/tasks_data_model.dart';
import 'package:questonnaire_app/data/repositories/get_tasks_repo.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9FB),
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Задачи',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: const Text(
                  'Записаться на консультацию',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/calendar_plus.svg',
                  width: 24,
                  height: 24,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffDDEEF6),
                  foregroundColor: const Color(0xff29B1DD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xffF4F7F8),
                      backgroundColor: const Color(0xff29B1DD),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Активные',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xff29B1DD),
                      backgroundColor: const Color(0xffF9F9FB),
                      elevation: 0,
                      side: const BorderSide(
                        color: Color(0xff29B1DD),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Завершенные',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Expanded(
              child: FutureBuilder<TasksDataModel>(
                future: GetTasksRepo().getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final task = snapshot.data?.data?[index];
                          return Column(
                            children: [
                              Container(
                                height: 120,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task?.tag ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffD32029),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      task?.title ?? " ",
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Осталось:',
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff8E8E93),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFDF5E4),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 10),
                                            child: Text(
                                              task?.deadline ?? "",
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffF4B740),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xffF4F7F8),
                                            backgroundColor:
                                                const Color(0xff29B1DD),
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 14),
                                          ),
                                          child: const Text(
                                            'Приступить',
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
                              if (index !=
                                  (snapshot.data?.data?.length ?? 0) - 1)
                                const SizedBox(height: 12),
                            ],
                          );
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
