//
//  SurveryViewController.swift
//  BuildingYourOwnAPI
//
//  Created by Mitch Praag on 7/29/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import UIKit

class SurveryViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var favoriteFoodText: UITextField!
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameText.text,
        let food = favoriteFoodText.text,
            !name.isEmpty && !food.isEmpty else { return }
        
        
        SurveyController.putSurveyIntoAPI(name: name, answer: food)
        
        nameText.text = ""
        favoriteFoodText.text = ""
    }
}
