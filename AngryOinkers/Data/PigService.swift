//
//  PigService.swift
//  AngryOinkers
//
//  Created by dev on 9/29/20.
//

import Foundation

enum PigCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
}

class PigService {
    
    private let urlString = "https://police-data-gatherer.herokuapp.com/cops/0/30"
    
    func getPigs(completion: @escaping ([Pig]?, Error?) -> ()) {
        guard let url = URL(string: self.urlString) else {
            DispatchQueue.main.async {
                completion(nil, PigCallingError.problemGeneratingURL)
            }
            return
        }
        
        let request = URLRequest(url: url)
        //execute callback within dataTask
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, PigCallingError.problemGettingDataFromAPI)
                }
                return
            }
            do {
                let pigResult = try JSONDecoder().decode(PigResult.self, from: data)
                DispatchQueue.main.async {
                    completion(pigResult.cops, nil)
                }
            } catch (let error) {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, PigCallingError.problemDecodingData)
                }
            }
        }
        task.resume()
        
    }
}
