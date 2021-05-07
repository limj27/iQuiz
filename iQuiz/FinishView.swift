//
//  FinishView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/6/21.
//

import SwiftUI

struct FinishView: View {
    @State var quiz: Quiz
    @State private var selection: String? = nil
    var body: some View {
        NavigationLink(destination: ContentView(isFirst: false), tag: "go", selection: $selection) {
            EmptyView()
        }.navigationBarBackButtonHidden(true)
        VStack {
            Spacer()
            if Double(quiz.correct) / Double(quiz.questions.count) >= 1.0 {
                Text("Perfect!").font(Font.headline.bold())
            } else if Double(quiz.correct) / Double(quiz.questions.count) >= 0.5 {
                Text("Pretty Good!").font(Font.headline.bold())
            } else {
                Text("Oof Try Again!").font(Font.headline.bold())
            }
            Spacer()
            Text(String(quiz.correct) + " correct, out of " + String(quiz.questions.count)).font(Font.headline.bold())
            Spacer()
            Button(action: {selection = "go"}) {
                Text("Return").font(Font.headline.bold())
            }
        }
    }
}
