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
}

struct ContentView: View {
    let contents = [Row(id: "Mathematics", desc: "Do you think you are good at math? Give this quiz a shot!", image: "math"),
    Row(id: "Marvel Super Heroes", desc: "How well do you know Marvel's super heroes?", image: "marvel"),
    Row(id: "Science", desc: "All types of science questions will be asked!", image: "science")]
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contents) { content in
                    HStack {
                        Image(content.image).resizable().scaledToFit()
                        VStack {
                            Text(content.id).padding().font(Font.headline.weight(.bold))
                            Text(content.desc).padding()
                        }
                    }
                }
            }.navigationTitle("iQuiz")
            .toolbar {
                Button("Settings") {
                    showingAlert = true
                    print(showingAlert)
                }
            }.alert(isPresented: $showingAlert, content: {Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("OK")))})
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
