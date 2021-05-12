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
    @State var score: Score
    var quizLength: Int
    var currIndex: Int
    @State private var selection: String? = nil
    @State var text: String = ""
    var body: some View {
        if currIndex == quizLength - 1 {
            NavigationLink(destination: FinishView(quiz: quiz, score: score, text: text), tag: "submit", selection: $selection) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
            VStack {
                Spacer()
                Text("Question:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].text).padding()
                Spacer()
                Text("Answer:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1]).padding()
                Spacer()
                if answer == quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1] {
                    Text("You are correct!").font(Font.headline.bold())
                } else {
                    Text("You are incorrect!").font(Font.headline.bold())
                }
                Spacer()
                Button(action: {
                    selection = "submit"
                    if answer == quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1] {
                        score.addScore()
                        if Double(score.correct) / Double(quiz.questions.count) >= 1.0 {
                            text = "Perfect!"
                        } else if Double(score.correct) / Double(quiz.questions.count) >= 0.5 {
                            text = "Pretty Good!"
                        } else {
                            text = "Try Again!"
                        }
                    }
                }) {
                    Text("Next")
                }
            }
        } else {
            NavigationLink(destination: QuestionView(quiz: quiz, score: score, currIndex: currIndex + 1), tag: "submit", selection: $selection) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
            VStack {
                Spacer()
                Text("Question:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].text).padding()
                Spacer()
                Text("Answer:").padding().font(Font.headline.bold())
                Text(quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1]).padding()
                Spacer()
                if answer == quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1] {
                    Text("You are correct!").font(Font.headline.bold())
                } else {
                    Text("You are incorrect!").font(Font.headline.bold())
                }
                Spacer()
                Button(action: {
                    selection = "submit"
                    if answer == quiz.questions[currIndex].answers[Int(quiz.questions[currIndex].answer)! - 1] {
                        score.addScore()
                    }
                }) {
                    Text("Next")
                }
            }
        }
    }
}

