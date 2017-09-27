//
//  surveyController.swift
//  BuildingYourOwnAPI
//
//  Created by Mitch Praag on 7/29/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation


class SurveyController {
    static let baseUrl = URL(string: "https://in-class-building-your-api.firebaseio.com/api/v1/")
    static let getterEndPoint = baseUrl?.appendingPathExtension("json")
    
    static func putSurveyIntoAPI(name: String, answer: String) {
        let survey = Survey(name: name, answer: answer)
        guard let url = survey.endPoint else { return }
        NetworkController.performRequest(for: url, httpMethod: .Put, urlParameters: nil, body: survey.jsonData) { (data, error) in
          guard  let data = data else { return }
            let dataString = String(data: data, encoding: .utf8) ?? ""
            
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else if dataString.contains("error") {
                print("error: \(dataString)")
            } else {
                print("saved \(dataString)")
            }
        }
    }
    
    static func fetchSurveys(completion: @escaping (_ surverys: [Survey]) -> Void) {
        guard let url = getterEndPoint else { completion ([])
            return }
        
            
            
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            guard  let data = data else { return }
            let dataString = String(data: data, encoding: .utf8) ?? ""
            
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else if dataString.contains("error") {
                print("error: \(dataString)")
            }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String:AnyObject]] else { return }
            let surveys = jsonDictionary.flatMap { Survey(dictionary: $0.1, identifier: $0.0) }
            completion(surveys)
        }
    }
    //This is a test change 
    
}
