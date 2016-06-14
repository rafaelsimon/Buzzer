//
//  Game.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-05-04.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//

import Foundation
//xx

class Game: NSObject {
    var player1: Player?
    var player2: Player?
    var player3: Player?
    
    var categories: [Category] = []
    var currentPlayer: Player?
    var currentQuestion: Question?
    
    func loadCategoriesForNewGame() {
        do {
            categories = try Category.loadCategories()
        }
        catch let error {
            print("Error loading categories: \(error)")
        }
    }
    
    func loadCategoriesForNewGame(numberOfCategories: Int, responseHandler : (error : NSError?) -> ()) {
        Category.loadCategories(numberOfCategories, responseHandler: { (error, items) -> () in
            self.categories = items!
            
            if let categoriesArray = items {
                self.categories = categoriesArray
            }
            
            responseHandler(error: error)
            
        })
    }
    
    
}
