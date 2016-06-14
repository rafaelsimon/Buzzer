//
//  QuestionPickerViewController.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-05-09.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import UIKit

let NumberOfCategories = 4
let QuestionsPerCategory = 5

class QuestionPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var questionCollectionView: UICollectionView!
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowQuestionBuzzSegue" {
            if let destinationViewController = segue.destinationViewController as? QuestionBuzzViewController {
                destinationViewController.game = game
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfCategories * QuestionsPerCategory
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("QuestionPickerCell", forIndexPath: indexPath) as? QuestionPickerCell {
            let price = priceFromIndexPath(indexPath)
            cell.priceLabel.text = "$\(price)"
            
            let categoryIndex = categoryFromIndexPath(indexPath)
            if categoryIndex < game?.categories.count {
                let category = game?.categories[categoryIndex]
                cell.answered = category?.answeredQuestions[price] != nil
            }
            
            return cell
        }
        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // This should almost certainly be the correct kind of layout unless it has been changes in the storyboard
        if let layout = questionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let interItemSpacing = layout.minimumInteritemSpacing
            let totalSpace: CGFloat = CGFloat(NumberOfCategories - 1) * interItemSpacing
            let dimension = floor((questionCollectionView.bounds.width - totalSpace) / CGFloat(NumberOfCategories))
            return CGSize(width: dimension, height: dimension)
        }
        
        // Return UICollectionViewFloatLayout default size
        return CGSize(width: 50, height: 50)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedPrice = priceFromIndexPath(indexPath)
        let selectedCategory = categoryFromIndexPath(indexPath)
        
        // Set the selected question on game object
        if let category = game?.categories[selectedCategory] {
            // If there is already an answered question for this category and price, don't do anything
            if category.answeredQuestions[selectedPrice] != nil {
                return
            }
            
            Question.loadQuestion(category, price: selectedPrice, responseHandler: { (error, question) -> () in
                
                if error == nil {
                    
                    self.game?.currentQuestion = question
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("ShowQuestionBuzzSegue", sender: nil)
                    })
                    
                } else {
                    print("Error trying to load question: \(error)")
                }
                
            })
           
        }
    }
    
    // MARK: Private
    
    private func priceFromIndexPath(indexPath: NSIndexPath) -> Int {
        let row = indexPath.item / NumberOfCategories
        let price = (row + 1) * 200
        return price
    }
    
    private func categoryFromIndexPath(indexPath: NSIndexPath) -> Int {
        let column = indexPath.item % NumberOfCategories
        return column
    }


}
