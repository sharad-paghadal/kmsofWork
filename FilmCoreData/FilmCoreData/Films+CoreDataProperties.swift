//
//  Films+CoreDataProperties.swift
//  FilmCoreData
//
//  Created by Sharad Paghadal on 07/12/16.
//  Copyright © 2016 temp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Films {

    @NSManaged var filmName: String?
    @NSManaged var actorName: String?
    @NSManaged var releaseDate: String?

}
