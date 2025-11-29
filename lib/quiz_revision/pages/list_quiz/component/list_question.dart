import 'package:flutter/material.dart';
import 'package:planeje/utils/message_user.dart';
import '../../../../widgets/checkbox_custom.dart';
import '../../../entities/question.dart';
import '../controller/list_question_controller.dart';

// ignore: must_be_immutable
class ListQuestion extends StatefulWidget {
  const ListQuestion({super.key, required this.listQuestion});

  final List<Question> listQuestion;

  @override
  State<ListQuestion> createState() => _ListQuestionState();
}

class _ListQuestionState extends State<ListQuestion> {
  ListQuestionController listQuestionController = ListQuestionController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          itemCount: widget.listQuestion.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 05, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: CheckBoxCustom(
                      isChecked: listQuestionController.getCheck(widget.listQuestion, index),
                      onClick: (value) {
                        listQuestionController.updateAnswer(index, value, widget.listQuestion);
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Text(
                      '${widget.listQuestion[index].description}',
                      style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 05, top: 10, bottom: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (listQuestionController.index == -1) {
                    MessageUser.success(context, 'Necessário escolher um registro!!!');
                    return;
                  }
                  listQuestionController.showAnswer = true;

                  await listQuestionController.registerRevisionQuiz(widget.listQuestion, listQuestionController.index);

                  setState(() {});
                },
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 25,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 05),
                  child: const Text(
                    "Verificar resposta",
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(137, 10, 5, 5), fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Visibility(
                visible: listQuestionController.isAnswer(widget.listQuestion, true),
                replacement: Visibility(
                  visible: listQuestionController.isAnswer(widget.listQuestion, false),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.check, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
