//
//  AnswerInputViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-05-30.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class AnswerInputViewController: UIViewController {

    var game: Game?
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    //@IBOutlet weak var checkAnwer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIElements()
        // Do any additional setup after loading the view.
    }

    func configureUIElements() {
        
        categoryLabel.text = game?.currentQuestion?.category?.title
        priceLabel.text = game?.currentQuestion?.formattedPrice()
        questionTextView.text = game?.currentQuestion?.question
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkAnswer(sender: AnyObject) {
        game?.currentQuestion?.playerAnswer = answerTextView.text
        performSegueWithIdentifier("AnswerVerificationSegue", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AnswerVerificationSegue" {
            if let destinationViewController = segue.destinationViewController as? AnswerVerificationViewController {
                destinationViewController.game = game
            }
        }
    }

}
