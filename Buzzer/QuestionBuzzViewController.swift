//
//  QuestionBuzzViewController.swift
//  Buzzer
//
//  Created by Rafael Simon Maia on 2016-05-18.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class QuestionBuzzViewController: UIViewController {

    var game: Game?
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryPriceLabel: UILabel!
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    @IBOutlet weak var player3Button: UIButton!
    
    
    @IBOutlet weak var questionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIElements()
        // Do any additional setup after loading the view.
    }

    func configureUIElements() {
        categoryNameLabel.text = game?.currentQuestion?.category?.title
        categoryPriceLabel.text = game?.currentQuestion?.formattedPrice()
        questionText.text = game?.currentQuestion?.question
        
        player1Button.setTitle(game?.player1?.name, forState: UIControlState.Normal)
        player2Button.setTitle(game?.player2?.name, forState: UIControlState.Normal)
        player3Button.setTitle(game?.player3?.name, forState: UIControlState.Normal)
    }
    
    func showAnswerInputWithPlayer(player: Player) {
        game?.currentPlayer = player
        performSegueWithIdentifier("ShowAnswerInputSegue", sender: nil)
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowAnswerInputSegue" {
            if let destinationViewController = segue.destinationViewController as? AnswerInputViewController {
                destinationViewController.game = game
            }
        }
    }
    
    // #pragma mark - IBActions
    
    @IBAction func player1ButtonPressed(sender: UIButton) {
        if let game = self.game, player = game.player1 {
            showAnswerInputWithPlayer(player)
        }
    }
    
    @IBAction func player2ButtonPressed(sender: UIButton) {
        if let player = self.game?.player2 {
            showAnswerInputWithPlayer(player)
        }
    }
    
    @IBAction func player3ButtonPressed(sender: UIButton) {
        if let player = self.game?.player3 {
            showAnswerInputWithPlayer(player)
        }
    }
    
}
