//
//  userViewModel.swift
//  iQuiz
//
//  Created by Justin Lim on 5/11/21.
//

import Foundation
class apiCall {
    func getQuizes(completion:@escaping ([Quiz]) -> ()) {
            guard let url = URL(string: "http://tednewardsandbox.site44.com/questions.json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let users = try! JSONDecoder().decode([Quiz].self, from: data!)
                print(users)
                
                DispatchQueue.main.async {
                    completion(users)
                }
            }
            .resume()
    }
}
