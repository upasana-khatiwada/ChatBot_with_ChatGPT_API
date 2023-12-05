import 'package:animate_do/animate_do.dart';
import 'package:chatgpt_bot/feature_box.dart';
import 'package:chatgpt_bot/openai_service.dart';
import 'package:chatgpt_bot/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController =
      TextEditingController(); //for TextField

  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  //Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  void showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this Application?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.pop(context);
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        showBackDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          title: BounceInDown(child: const Text('My assistant')),
          leading: const Icon(Icons.menu),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //virtual assistant picture
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      height: 123,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/virtualAssistant.png"))),
                    )
                  ],
                ),
              ),
              //chat bubble
              FadeInRight(
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.borderColor,
                      ),
                      //to make the border pointy on the left side while making circular in other side
                      borderRadius: BorderRadius.circular(20).copyWith(
                        topLeft: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        generatedContent == null
                            ? 'Good Morning, what task can I do for you?'
                            : generatedContent!,
                        style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Pallete.mainFontColor,
                          fontSize: generatedContent == null ? 25 : 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              SlideInLeft(
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 22),
                    child: const Text(
                      'Here are a few features ',
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //features list
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureBox(
                        color: Pallete.firstSuggestionBoxColor,
                        headerText: 'ChatGPT',
                        descriptionText:
                            'A smarter way to stay organized and informed with ChatGPT',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay),
                      child: const FeatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: 'Dall-E',
                        descriptionText:
                            'Get inspired and stay creative with your personal assistant powered by Dall-E',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + 2 * delay),
                      child: const FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor,
                        headerText: 'Smart Voice Assistant',
                        descriptionText:
                            'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                      ),
                    ),
                    //Text Field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Pallete.firstSuggestionBoxColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                  hintText: "Message",
                                  border: InputBorder.none),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                if (await speechToText.hasPermission &&
                                    speechToText.isNotListening) {
                                  await startListening();
                                } else if (speechToText.isListening) {
                                  final speech =
                                      await openAIService.chatGPTAPI(lastWords);
                                  generatedContent = speech;
                                  setState(() {});
                                  await systemSpeak(speech);
                                  await stopListening();
                                } else {
                                  initSpeechToText();
                                }
                              },
                              icon: const Icon(Icons.mic)),
                          IconButton(
                              onPressed: () async {
                                if (_textEditingController.text.isNotEmpty) {
                                  final speech = await openAIService
                                      .chatGPTAPI(_textEditingController.text);
                                  await systemSpeak(speech);
                                  generatedContent = speech;
                                  setState(() {});

                                  _textEditingController.clear();
                                  // FocusScope.of(context)
                                  //     .unfocus(); //dismiss keyboard on submission //clear text field
                                }
                              },
                              icon: const Icon(Icons.send)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // floatingActionButton: ZoomIn(
        //   delay: Duration(milliseconds: start + 3 * delay),
        //   child: FloatingActionButton(
        //     onPressed: () async {
        //       if (await speechToText.hasPermission &&
        //           speechToText.isNotListening) {
        //         await startListening();
        //       } else if (speechToText.isListening) {
        //         final speech = await openAIService.chatGPTAPI(lastWords);
        //         generatedContent = speech;
        //         setState(() {});
        //         await systemSpeak(speech);
        //         await stopListening();
        //       } else {
        //         initSpeechToText();
        //       }
        //     },
        //     backgroundColor: Pallete.firstSuggestionBoxColor,
        //     child: Icon(
        //       speechToText.isListening ? Icons.stop : Icons.mic,
        //     ),
        //   ),

        // ),
      ),
    );
  }
}
