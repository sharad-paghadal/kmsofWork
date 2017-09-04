//
//  BookManager.swift
//  Books
//
//  Created by Prateek Panjwani on 02/11/16.
//  Copyright © 2016 Panjwani, Prateek A. All rights reserved.
//

import UIKit
import CoreData
class BookManager: NSObject {
    
    
    override init() {
        
        super.init()
        
    }
    
    func numberOfSection(fetchResulatsController:NSFetchedResultsController<NSFetchRequestResult>) -> Int
    {
        //1
        guard let sectionCount = fetchResulatsController.sections?.count else {
            return 0
        }
        return sectionCount
    }
    
    func countOfBooks( section:Int, fetchResulatsController:NSFetchedResultsController<NSFetchRequestResult>) -> Int
    {
        guard let sectionData = fetchResulatsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    
    func insertBook( index:IndexPath , context:NSManagedObjectContext) -> Books
    {

        let insertBookRef = NSEntityDescription.insertNewObject (forEntityName: "Books", into:context ) as! Books;
        insertBookRef.bookTitle = "Title"
        insertBookRef.bookAuthor = "Author"
        insertBookRef.publicationDate = "Date"
        return insertBookRef;
    }
    
    
    func getBookFetchRequest () ->NSFetchRequest<NSFetchRequestResult>
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        let fetchSort = NSSortDescriptor(key: "bookAuthor", ascending: true)
        fetchRequest.sortDescriptors = [fetchSort]
        
        return fetchRequest
    }
    
    
}

