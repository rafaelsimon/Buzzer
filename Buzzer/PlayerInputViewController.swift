//
//  PlayerInputViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-05-09.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

class PlayerInputViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var playerImages: [UIImageView]!
    @IBOutlet weak var player1Text: UITextField!
    @IBOutlet weak var player2Text: UITextField!
    @IBOutlet weak var player3Text: UITextField!
    
    var selectedImageView: UIImageView?
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
    }
    
    func addTapGestureRecognizer() {
        for eachImageView: UIImageView in playerImages {
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                action: Selector("playerImageTapped:"))
            gestureRecognizer.delegate = self
            eachImageView.addGestureRecognizer(gestureRecognizer)
        }
    
    }
    
    func playerImageTapped(sender: UITapGestureRecognizer) {
        selectedImageView = sender.view as? UIImageView
        showImagePicker()
    }
    
    func showImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.allowsEditing = false
        }
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Cancelled")
        selectedImageView = nil
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        guard selectedImageView != nil else { return }
        selectedImageView?.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK:- IBActions
    
    @IBAction func playAction(sender: AnyObject) {
        performSegueWithIdentifier("ShowQuestionPickerSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowQuestionPickerSegue" {
            if let destinationViewController = segue.destinationViewController as? QuestionPickerViewController {
                
                // TODO: Add verification of names in text fields.
                
                let player1 = Player()
                player1.name = player1Text.text ?? "Player 1"

                let player2 = Player()
                if let enteredName = player2Text.text where enteredName.characters.count > 0 {
                    player2.name = enteredName
                }
                else {
                    player2.name = "Player 2"
                }
                
                let player3 = Player()
                if let enteredName = player3Text.text where enteredName.characters.count > 0 {
                    player3.name = enteredName
                }
                else {
                    player3.name = "Player 3"
                }
                
//                player1.image = player1ImageView.image
//                player2.image = player2ImageView.image
//                player3.image = player3ImageView.image
//                
                let game = Game()
                game.player1 = player1
                game.player2 = player2
                game.player3 = player3
                
                game.loadCategoriesForNewGame(NumberOfCategories, responseHandler: { (error) -> () in
                    
                    if error == nil {
                        // TODO: Load UI
                    } else {
                        print("Error trying to load categories: \(error)")
                    }
                    
                })
                game.currentPlayer = player1
                
                destinationViewController.game = game
            }
        }
    }
    
}
