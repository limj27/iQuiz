//
//  QuestionView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/6/21.
//

import SwiftUI

struct QuestionView: View {
    @State var quiz: Quiz
    @State var score: Score
    var currIndex: Int
    @State private var submit: String? = nil
    @State private var answer: String = ""
    var body: some View {
        let question = quiz.questions[currIndex]
        NavigationLink(destination: AnswerView(answer: answer, quiz: quiz, score: score, quizLength: quiz.questions.count, currIndex: currIndex), tag: "submit", selection: $submit) {
            EmptyView()
        }.navigationBarBackButtonHidden(true)
        VStack {
            Spacer()
            Text("Question:").padding().font(Font.headline.bold())
            Spacer()
            Text(question.text).padding()
            Spacer()
            Picker(selection: $answer, label: Text("Choose an Answer!")) {
                ForEach(question.answers, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
            Spacer()
            Button(action: {submit = "submit"}) {
                Text("Submit").font(Font.headline.bold())
            }
        }
    }
}

