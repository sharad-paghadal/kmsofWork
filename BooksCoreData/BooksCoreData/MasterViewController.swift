//
//  MasterViewController.swift
//  Books
//
//  Created by Panjwani, Prateek A on 9/29/16.
//  Copyright © 2016 Panjwani, Prateek A. All rights reserved.
//

import UIKit
import CoreData
protocol detailViewEdit {
    func detailViewEditComplete()
    func detailViewEditCancel()
}

class MasterViewController: UITableViewController,detailViewEdit ,NSFetchedResultsControllerDelegate{
    
    var detailViewController: DetailViewController? = nil

    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }()
  
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var bookDataSource = BookManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: bookDataSource.getBookFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        
    }
    
    
    func insertNewObject(_ sender: AnyObject) {
                
        let indexPath =  IndexPath(row: 0, section: 0)
        
        bookDataSource.insertBook(index: indexPath, context:context)
        
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let tempBook =   fetchedResultsController.object(at: indexPath) as! Books
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = tempBook
                controller.delegate = self
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        
      return  bookDataSource.numberOfSection(fetchResulatsController: fetchedResultsController)

    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookDataSource.countOfBooks(section:section , fetchResulatsController: fetchedResultsController)

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let tempBook =   fetchedResultsController.object(at: indexPath as IndexPath) as! Books
       
         cell.textLabel!.text = tempBook.bookTitle
        if tempBook.bookAuthor != nil || tempBook.publicationDate != nil
        {
             cell.textLabel!.text = tempBook.bookTitle
           cell.detailTextLabel!.text = tempBook.bookAuthor! + " " + tempBook.publicationDate!
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            let book =   fetchedResultsController.object(at: indexPath) as! Books
            context.delete(book)
            // 3
            do {
                try context.save()
            } catch let error as NSError {
                print("Error saving context after delete: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    
    private func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // 2
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            break;
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            break;
            
        case .update:
            
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath as IndexPath)
                configureCell(cell: cell!, atIndexPath: indexPath as NSIndexPath)
                
                
            }
            break;
        case .move:
            
            
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            
            if let indexPath = newIndexPath {
                let cell = tableView.cellForRow(at: indexPath as IndexPath)
                configureCell(cell: cell!, atIndexPath: indexPath as NSIndexPath)
                
                
            }
            
            break;
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let tempBook =   fetchedResultsController.object(at: indexPath as IndexPath) as! Books
        cell.textLabel!.text = tempBook.bookTitle
        if tempBook.bookAuthor != nil || tempBook.publicationDate != nil
        {
            cell.textLabel!.text = tempBook.bookTitle
            cell.detailTextLabel!.text = tempBook.bookAuthor! + " " + tempBook.publicationDate!
        }
       
    }
    
    
    // Protocol Functions
    func detailViewEditComplete()
    {
        _ = self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func detailViewEditCancel(){
        
        _ =   self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
