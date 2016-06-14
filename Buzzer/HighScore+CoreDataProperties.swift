//
//  HighScore+CoreDataProperties.swift
//  Buzzer
//
//  Created by Rafael Maia on 2016-06-01.
//  Copyright © 2016 Rafael Maia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HighScore {

    @NSManaged var playerScore: NSNumber?
    @NSManaged var playerName: String?

}
