//
//  ResponsesTableViewController.swift
//  BuildingYourOwnAPI
//
//  Created by Mitch Praag on 7/29/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import UIKit

class ResponsesTableViewController: UITableViewController {
    
    
    var surveys = [Survey]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SurveyController.fetchSurveys { (surveys) in
            self.surveys = surveys
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "surveyCell")
        
        let survey = surveys[indexPath.row]
        
        cell?.textLabel?.text = survey.name
        cell?.detailTextLabel?.text = survey.answer
        return cell ?? UITableViewCell()
    }

}
