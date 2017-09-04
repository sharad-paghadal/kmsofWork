
//
//  Created by Sharad Paghadal on 07/12/16.
//  Copyright © 2016 temp. All rights reserved.
//
import UIKit
import CoreData
protocol detailViewEdit {
    func detailViewEditComplete()
    func detailViewEditCancel()
}

class MasterViewController: UITableViewController,detailViewEdit, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil

    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
    
    var fetchedResultsController: NSFetchedResultsController!
    var filmSource = FilmManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //Fetch All the dat from Core Data
        let fetchRequest = filmSource.getBookFetchRequest(context);
        
        fetchedResultsController =  fetchRequest
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }

        
        

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
    }
    
    
    func insertNewObject(sender: AnyObject) {
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        
        filmSource.insertFilms(indexPath, context:context)
        
    }
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let tempBook =   fetchedResultsController.objectAtIndexPath(indexPath)as! Films
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = tempBook
                controller.delegate = self
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  filmSource.numberOfSection(fetchedResultsController)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filmSource.countOfFilms(section, fetchResulatsController: fetchedResultsController)

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let tempFilmRef =   fetchedResultsController.objectAtIndexPath(indexPath) as! Films
        
        cell.textLabel?.text = tempFilmRef.filmName
        if tempFilmRef.actorName != nil || tempFilmRef.releaseDate != nil{
            cell.textLabel!.text = tempFilmRef.filmName
            cell.detailTextLabel!.text = tempFilmRef.actorName! + " " + tempFilmRef.releaseDate!
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let obj = fetchedResultsController.objectAtIndexPath(indexPath) as! Films
            context.deleteObject(obj)
            //context.delete(obj)
            do{
                try context.save()
            } catch let error as NSError{
                print("Error saving context after delete: \(error.localizedDescription)")
            }
        }
    }

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }


    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
            break;
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            break;
            
        case .Update:
            if let indexPath = indexPath {
                filmSource.configureCell(tableView , indexPath: indexPath as NSIndexPath,fetchResultsRef : fetchedResultsController)
            }
            break;
        case .Move:
            
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            
            if let indexPath = newIndexPath {
                
                filmSource.configureCell(tableView , indexPath: indexPath as NSIndexPath,fetchResultsRef : fetchedResultsController)
                
            }
            
            break;
            
        }

    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let tempBook =   fetchedResultsController.objectAtIndexPath(indexPath) as! Films
        cell.textLabel!.text = tempBook.filmName
        if tempBook.actorName != nil || tempBook.releaseDate != nil
        {
            cell.textLabel!.text = tempBook.filmName
            cell.detailTextLabel!.text = tempBook.actorName! + " " + tempBook.releaseDate!
        }
        
    }

// Protocol Functions
    func detailViewEditComplete()
    {
        _ = self.navigationController?.popViewControllerAnimated(true)
    }


    func detailViewEditCancel(){
        _ =   self.navigationController?.popViewControllerAnimated(true)
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}


