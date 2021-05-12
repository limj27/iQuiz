//
//  FinishView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/6/21.
//

import SwiftUI

struct FinishView: View {
    @State var quiz: Quiz
    @State var score: Score
    @State private var selection: String? = nil
    @State var text: String
    
    var body: some View {
        NavigationLink(destination: ContentView(isFirst: false), tag: "go", selection: $selection) {
            EmptyView()
        }.navigationBarBackButtonHidden(true)
        VStack {
            Spacer()
            Text(text).font(Font.headline.bold())
            Spacer()
            Text(String(score.correct) + " correct, out of " + String(quiz.questions.count)).font(Font.headline.bold())
            Spacer()
            Button(action: {selection = "go"}) {
                Text("Return").font(Font.headline.bold())
            }
        }
    }
}
