//
//  ContentView.swift
//  iQuiz
//
//  Created by Justin Lim on 5/4/21.
//

import SwiftUI

struct Quiz: Identifiable, Codable {
    var id: String { title }
    var title: String
    var desc: String
    var image: String = "basic"
    var questions: [Question]
    private enum CodingKeys: String, CodingKey {
            case title, desc, questions
    }
}

struct Question: Identifiable, Codable {
    var id: String { text }
    let text: String
    let answers: [String]
    let answer: String
}

struct Score {
    var correct: Int = 0
    mutating func addScore() {
        correct += 1
    }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State var quizes = [Quiz]()
    @State var score = Score()
    @State var dataURL = "https://tednewardsandbox.site44.com/questions.json"
    var isFirst: Bool = true
    var body: some View {
        if isFirst {
            NavigationView {
                List {
                    ForEach(quizes) { content in
                        NavigationLink(destination: QuestionView(quiz: content, score: score, currIndex: 0)) {
                            HStack {
                                Image(content.image).resizable().aspectRatio(contentMode: .fit).frame(width: 100)
                                VStack {
                                    Text(content.title).padding().font(Font.headline.weight(.bold))
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
                }.popover(isPresented: $showingAlert) {
                    VStack {
                        Spacer()
                        TextField("Enter a new data source!", text: $dataURL).padding()
                        Spacer()
                        Button("Check Now") {
                            self.loadData()
                            showingAlert = false
                        }
                    }
                }
                .onAppear(perform: loadData)
            }.navigationViewStyle(StackNavigationViewStyle())
        } else {
            List {
                ForEach(quizes) { content in
                    NavigationLink(destination: QuestionView(quiz: content, score: score, currIndex: 0)) {
                        HStack {
                            Image(content.image).resizable().aspectRatio(contentMode: .fit).frame(width: 100)
                            VStack {
                                Text(content.title).padding().font(Font.headline.weight(.bold))
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
            }.popover(isPresented: $showingAlert) {
                VStack {
                    Spacer()
                    TextField("Enter a new data source!", text: $dataURL).padding()
                    Spacer()
                    Button("Check Now") {
                        self.loadData()
                        showingAlert = false
                    }
                }
            }
            .onAppear(perform: loadData)
        }
    }
}

extension ContentView {
    func loadData() {
        guard let url = URL(string: dataURL) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Quiz].self, from: data)
                    DispatchQueue.main.async {
                        self.quizes = decodedResponse
                    }
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                self.quizes = [Quiz(title: "Mathematics", desc: "Do you think you are good at math? Give this quiz a shot!", image: "math", questions: [Question(text: "3 + 4", answers: ["2", "3", "4", "7"], answer: "4"), Question(text: "27 * 10", answers: ["20", "27", "270", "2700"], answer: "3"), Question(text: "16 / 4", answers: ["3", "4", "2", "7"], answer: "2")]),
                               Quiz(title: "Marvel Super Heroes", desc: "How well do you know Marvel's super heroes?", image: "marvel", questions: [Question(text: "Who played Iron Man?", answers: ["Robert Downey Jr", "Chris Hemsworth", "Tom Hiddlestone", "Tom Holland"], answer: "1"), Question(text: "Who is the brother of Scarlet Witch?", answers: ["Iron Man", "Thor", "QuickSilver", "Loki"], answer: "3")]),
                               Quiz(title: "Science", desc: "All types of science questions will be asked!", image: "science", questions: [Question(text: "What is Mass times Acceleration?", answers: ["Newtons", "Force", "Speed", "Velocity"], answer: "2"), Question(text: "What is the chemical compound of water?", answers: ["h2o", "h3o", "h2o2", "ho"], answer: "1"), Question(text: "What is the periodic table name for iron?", answers: ["fe", "au", "li", "ir"], answer: "1")])]
            }
        }.resume()
    }
}





