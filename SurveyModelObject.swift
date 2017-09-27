//
//  SurveyModelObject.swift
//  BuildingYourOwnAPI
//
//  Created by Mitch Praag on 7/29/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation


class Survey {
    
    var endPoint: URL? {
        return SurveyController.baseUrl?.appendingPathComponent("\(id.uuidString)").appendingPathExtension("json")
    }
    
    let name: String
    let answer: String
    let id: UUID
    
    
    init(name: String, answer: String, id: UUID = UUID()) {
        self.name = name
        self.answer = answer
        self.id = id
    }
    
}

extension Survey {
    private static var kName: String { return "name" }
    private static var kAnswer: String { return "answer" }
    
    convenience init?(dictionary: [String: AnyObject], identifier: String) {
        guard let name = dictionary[Survey.kName] as? String,
            let answer = dictionary[Survey.kAnswer] as? String,
            let id = UUID(uuidString: identifier) else { return nil }
        
        self.init(name: name, answer: answer, id: id)
    }
    
    var jsonValue: [String: Any] {
        return [Survey.kName: name, Survey.kAnswer: answer]
        
    }
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: jsonValue, options: .prettyPrinted)
    }

}
