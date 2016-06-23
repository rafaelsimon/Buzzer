//
//  AnswerVerificationViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-06-01.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class AnswerVerificationViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    
    
    var game: Game?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIElements()
        // Do any additional setup after loading the view.
    }
    
    func configureUIElements() {
        
        categoryLabel.text = game?.currentQuestion?.category?.title
        priceLabel.text = game?.currentQuestion?.formattedPrice()
        questionTextView.text = game?.currentQuestion?.answer
        answerTextView.text = game?.currentQuestion?.playerAnswer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endGameAction(sender: AnyObject) {
        performSegueWithIdentifier("FinalResultsSegue", sender: nil)
    }
    @IBAction func correctAction(sender: AnyObject) {
        game?.currentPlayerGotItRight()
        
        let alert = UIAlertController(title: "Yahoo!", message: "You got it right!", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { alert in
            print("asasdasdasdas")
        }))
        correctButton.enabled = false
        wrongButton.enabled = false
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func wrongAction(sender: AnyObject) {
        game?.currentPlayerGotItWrong()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "FinalResultsSegue" {
            if let destinationViewController = segue.destinationViewController as? FinalResultsViewController {
                destinationViewController.game = game
            }
        }
    }

}
