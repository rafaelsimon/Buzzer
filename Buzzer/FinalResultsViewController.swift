//
//  FinalResultsViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-06-13.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit
import CoreData

class FinalResultsViewController: UIViewController {

    
    @IBOutlet var playerName: [UILabel]!
    
    var game: Game?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func saveHighScore(player: Player) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let highScore = NSEntityDescription.insertNewObjectForEntityForName("HighScore", inManagedObjectContext: appDelegate.managedObjectContext) as! HighScore
        
        highScore.playerName = player.name
        highScore.playerScore = player.score
        
        appDelegate.saveContext()
    }
    
    
    func configureUI() {
        var players = [Player]()
        if let player1 = game?.player1 {
            players.append(player1)
        }
        if let player2 = game?.player2 {
            players.append(player2)
        }
        if let player3 = game?.player3 {
            players.append(player3)
        }
        players.sortInPlace({ playerA, playerB in
            playerA.score > playerB.score
        })
        
        for i in 0..<3 {
            playerName[i].text = "\(players[i].name)    \(players[i].score)"
        }
        saveHighScore(players[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgainAction(sender: AnyObject) {
    }

    @IBAction func returnToMenuAction(sender: AnyObject) {
        performSegueWithIdentifier("unwindToMenuVC", sender: nil)
    }
    
    @IBAction func shareScoreAction(sender: AnyObject) {
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
