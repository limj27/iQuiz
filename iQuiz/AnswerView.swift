//
//  AnswerView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/6/21.
//

import SwiftUI

struct AnswerView: View {
    var answer: String
    @State var quiz: Quiz
    var quizLength: Int
    var currIndex: Int
    @State private var selection: String? = nil
    var body: some View {
        if currIndex == quizLength - 1 {
            NavigationLink(destination: FinishView(quiz: quiz), tag: "submit", selection: $selection) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
            VStack {
                Spacer()
                Text("Question:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].question).padding()
                Spacer()
                Text("Answer:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].correctAnswer).padding()
                Spacer()
                if answer == quiz.questions[currIndex].correctAnswer {
                    Text("You are correct!").font(Font.headline.bold())
                } else {
                    Text("You are incorrect!").font(Font.headline.bold())
                }
                Spacer()
                Button(action: {
                    selection = "submit"
                    if answer == quiz.questions[currIndex].correctAnswer {
                        quiz.addScore()
                    }
                }) {
                    Text("Next")
                }
            }
        } else {
            NavigationLink(destination: QuestionView(quiz: quiz, currIndex: currIndex + 1), tag: "submit", selection: $selection) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
            VStack {
                Spacer()
                Text("Question:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].question).padding()
                Spacer()
                Text("Answer:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].correctAnswer).padding()
                Spacer()
                if answer == quiz.questions[currIndex].correctAnswer {
                    Text("You are correct!").font(Font.headline.bold())
                } else {
                    Text("You are incorrect!").font(Font.headline.bold())
                }
                Spacer()
                Button(action: {
                    selection = "submit"
                    if answer == quiz.questions[currIndex].correctAnswer {
                        quiz.addScore()
                    }
                }) {
                    Text("Next")
                }
            }
        }
    }
}

