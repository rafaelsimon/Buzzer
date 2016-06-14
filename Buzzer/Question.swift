//
//  Question.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-05-04.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import Foundation


class Question: NSObject {
    weak var category: Category?
    var price: Int = 0
    var question: String = ""
    var answer: String = ""
    var playerAnswer: String = ""
    
    func formattedPrice() -> String {
        return "$\(price)"
    }
    
    class func parseJSON(jsonDictionary: Dictionary<String, AnyObject>) -> Question {
        let question = Question()
        question.question = jsonDictionary["question"] as! String
        question.price = jsonDictionary["value"] as! Int
        question.answer = jsonDictionary["answer"] as! String
        
        return question
    }
    
    //load from file
    class func loadQuestion(category: Category, price: Int) throws -> Question {
        if let jsonPath = NSBundle.mainBundle().pathForResource("Question", ofType: "json"), let jsonData = NSData(contentsOfFile: jsonPath) {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            
            if let array = json as? Array<AnyObject>, object = array.first as? Dictionary<String, AnyObject> {
                let question = Question.parseJSON(object)
                question.category = category
                return question
            }
        }
        
        throw NSError(domain: "Buzzer!", code: 100, userInfo: [NSLocalizedDescriptionKey: "Found invalid JSON data when looking for file Question.json"])
    }
    
    
    //Load from internet
    class func loadQuestion(category: Category, price: Int, responseHandler: (error : NSError? , question : Question?) -> ()) {
        
        let url = NSURL(string: "http://jservice.io/api/clues?value=\(price)&category=\(category.id)")
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, requestError) -> Void in
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                print(jsonData)
                
                if let array = jsonData as? Array<AnyObject> {
                    print(array)
                    
                    if array.count > 0 {
                        
                        // TODO : Student Enhancement: Get random number and pass as offset to randomize the game somewhat.
                        
                        let object = array[0]
                        let question = Question.parseJSON(object as! Dictionary<String, AnyObject>)
                        question.category = category
                        responseHandler(error: requestError, question: question)
                    } else {
                        
                        responseHandler(error: requestError, question: nil)
                    }
                }
                
            } catch {
                print(error)
                responseHandler(error: requestError, question: nil)
            }
            
        }
        
        task.resume()
    }
}