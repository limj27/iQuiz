//
//  ContentView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/4/21.
//

import SwiftUI

struct Row: Identifiable {
    var id: String
    let desc: String
    let image: String
    let quiz: Quiz
}

struct Question: Identifiable {
    var id: Int
    let question: String
    let answers: [String]
    let correctAnswer: String
}

struct Quiz: Identifiable {
    var id: String
    let questions: [Question]
    var correct: Int = 0
    
    mutating func addScore() {
        correct += 1
    }
}

struct ContentView: View {
    let contents = [Row(id: "Mathematics", desc: "Do you think you are good at math? Give this quiz a shot!", image: "math", quiz: Quiz(id: "Math", questions: [Question(id: 1, question: "3 + 4", answers: ["2", "3", "4", "7"], correctAnswer: "7"), Question(id: 2, question: "27 * 10", answers: ["20", "27", "270", "2700"], correctAnswer: "270"), Question(id: 3, question: "16 / 4", answers: ["3", "4", "2", "7"], correctAnswer: "4")])),
                    Row(id: "Marvel Super Heroes", desc: "How well do you know Marvel's super heroes?", image: "marvel", quiz: Quiz(id: "Marvel", questions: [Question(id: 1, question: "Who played Iron Man?", answers: ["Robert Downey Jr", "Chris Hemsworth", "Tom Hiddlestone", "Tom Holland"], correctAnswer: "Robert Downey Jr"), Question(id: 2, question: "Who is the brother of Scarlet Witch?", answers: ["Iron Man", "Thor", "QuickSilver", "Loki"], correctAnswer: "QuickSilver")])),
                    Row(id: "Science", desc: "All types of science questions will be asked!", image: "science", quiz: Quiz(id: "Science", questions: [Question(id: 1, question: "What is Mass times Acceleration?", answers: ["Newtons", "Force", "Speed", "Velocity"], correctAnswer: "Force"), Question(id: 2, question: "What is the chemical compound of water?", answers: ["h2o", "h3o", "h2o2", "ho"], correctAnswer: "h2o"), Question(id: 3, question: "What is the periodic table name for iron?", answers: ["fe", "au", "li", "ir"], correctAnswer: "fe")]))]
    @State private var showingAlert = false
    var isFirst: Bool = true
    var body: some View {
        if isFirst {
            NavigationView {
                List {
                    ForEach(contents) { content in
                        NavigationLink(destination: QuestionView(quiz: content.quiz, currIndex: 0)) {
                            HStack {
                                Image(content.image).resizable().scaledToFit()
                                VStack {
                                    Text(content.id).padding().font(Font.headline.weight(.bold))
                                    Text(content.desc).padding()
                                }
                            }
                        }.isDetailLink(false)
                    }
                }.navigationTitle("iQuiz")
                .toolbar {
                    Button("Settings") {
                        showingAlert = true
                    }
                }.alert(isPresented: $showingAlert, content: {Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("OK")))})
            }.navigationViewStyle(StackNavigationViewStyle())
        } else {
            List {
                ForEach(contents) { content in
                    NavigationLink(destination: QuestionView(quiz: content.quiz, currIndex: 0)) {
                        HStack {
                            Image(content.image).resizable().scaledToFit()
                            VStack {
                                Text(content.id).padding().font(Font.headline.weight(.bold))
                                Text(content.desc).padding()
                            }
                        }
                    }.navigationBarBackButtonHidden(true)
                }
            }.navigationTitle("iQuiz")
            .toolbar {
                Button("Settings") {
                    showingAlert = true
                }
            }.alert(isPresented: $showingAlert, content: {Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("OK")))})
        }
    }
}



