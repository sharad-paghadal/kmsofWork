//
//  FilmManager.swift
//  FilmCoreData
//
//  Created by Sharad Paghadal on 07/12/16.
//  Copyright © 2016 temp. All rights reserved.
//

import UIKit
import CoreData

class FilmManager: NSObject {
    
    override init() {
        
        super.init()
        
    }

    func numberOfSection(fetchResulatsController:NSFetchedResultsController) -> Int
    {
        
        guard let sectionCount = fetchResulatsController.sections?.count else {
            return 0
        }
        return sectionCount
    }
    
    func configureCell(tableViewRef:UITableView , indexPath:NSIndexPath , fetchResultsRef : NSFetchedResultsController)
    {
        let cell = tableViewRef.cellForRowAtIndexPath(indexPath)
        configureCellsss(cell!, atIndexPath: indexPath as NSIndexPath,fetchedResultsController:fetchResultsRef)
    }
    
    func configureCellsss(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath , fetchedResultsController : NSFetchedResultsController) {
        
        let tempFilmRef = fetchedResultsController.objectAtIndexPath(indexPath) as! Films
        cell.textLabel?.text = tempFilmRef.filmName
        
        if tempFilmRef.actorName != nil || tempFilmRef.releaseDate != nil
        {
            cell.textLabel!.text = tempFilmRef.filmName
            cell.detailTextLabel!.text = tempFilmRef.actorName! + " " + tempFilmRef.releaseDate!
        }
    }
    
    func getBookFetchRequest (context:NSManagedObjectContext) -> NSFetchedResultsController
    {
        let fetchRequest = NSFetchRequest(entityName: "Films")
        let fetchSort = NSSortDescriptor(key: "filmName", ascending: true)
        fetchRequest.sortDescriptors = [fetchSort]
        
        let fetch =  NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetch
    }
    
    
    func countOfFilms( section:Int, fetchResulatsController:NSFetchedResultsController) -> Int
    {
        guard let sectionData = fetchResulatsController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    
    func insertFilms( index:NSIndexPath , context:NSManagedObjectContext) -> Films
    {
        let insertFilmRef = NSEntityDescription.insertNewObjectForEntityForName("Films", inManagedObjectContext: context) as! Films
        insertFilmRef.filmName = "Title"
        insertFilmRef.actorName = "ActorName"
        insertFilmRef.releaseDate = ""
        return insertFilmRef;
    }

}
