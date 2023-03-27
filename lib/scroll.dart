import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height*0.05;
    final panelHeightOpen = MediaQuery.of(context).size.height*0.8;
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: panelHeightClosed,
        maxHeight: panelHeightOpen,
        color: Colors.white.withOpacity(0.9),
        panelBuilder: (scrollController) => _buildPanel(scrollController),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        parallaxEnabled: true,
        parallaxOffset: .5,
      ),
    );
  }

  Widget _buildPanel(ScrollController scrollController) => ListView(
    padding: EdgeInsets.zero,
    children: [
      SizedBox(height: 18,),
      buildAboutText(),
      SizedBox(height: 24,),
    ],
  );

 Widget buildAboutText() => Container(
   decoration: BoxDecoration(
     color: Colors.white.withOpacity(0.7), // set the background color with opacity level
     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
   ),
   padding: EdgeInsets.symmetric(horizontal: 24),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Center(child: Icon(Icons.keyboard_arrow_up)),
       SizedBox(height: 10,),
       Text('ChatGPT is a large language model developed by OpenAI based on the GPT (Generative Pretrained Transformer) architecture. It is designed to generate human-like responses to text input, making it an effective tool for natural language processing (NLP) tasks such as language translation, text summarization, and conversational AI.ChatGPT has been trained on a massive corpus of text data, including books, articles, and web pages, which allows it to generate high-quality, coherent responses to a wide range of input queries. It uses deep learning techniques such as attention mechanisms and transformers to analyze and generate text, making it highly effective at generating natural-sounding, contextually-appropriate responses.ChatGPT is used in a variety of applications, including chatbots, virtual assistants, and customer service systems. It has the potential to revolutionize the way people interact with technology by making it easier and more natural to communicate with computers and other devices.'),
     ],
   ),
 );
}
