//
//  HighScoresTableViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-06-08.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit
import CoreData

class HighScoresTableViewController: UITableViewController {
    
    var highScores: [HighScore] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadHighScores()
    }
    
    func loadHighScores() {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {return}
        // TODO : Student Enhancement: Add a sort order by score to the fetched results.
        let fetchRequest = NSFetchRequest(entityName: "HighScore")
        let sort = NSSortDescriptor(key: "playerScore", ascending: false)
        let sort2 = NSSortDescriptor(key: "playerName", ascending: true)
        fetchRequest.sortDescriptors = [sort,sort2]
        fetchRequest.fetchLimit = 5
        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest)
            
            if let results = fetchResults as? [HighScore] {
                highScores = results
                self.tableView.reloadData()
            }
        } catch let error {
            print("Error loading high scores: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HighScoreIdentifier", forIndexPath: indexPath)
        guard let highScoreCell = cell as? HighScoreTableViewCell else { return cell }
        // Configure the cell...
        let score = highScores[indexPath.row]
        highScoreCell.playerNameLabel.text = score.playerName
        highScoreCell.playerScoreLabel.text = score.playerScore?.stringValue
        return highScoreCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
