//
//  DetailViewController.swift
//  Books
//
//  Created by Panjwani, Prateek A on 9/29/16.
//  Copyright © 2016 Panjwani, Prateek A. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var tapGestuer: UITapGestureRecognizer!
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var year: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var viewbar: UIView!
    
    
    @IBAction func yearFN(_ sender: AnyObject) {
        pickerView.isHidden = true
    }
    @IBAction func yearFn(_ sender: AnyObject) {
        pickerView.isHidden = false
    }
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var yearArray : [Int] = []
    var detailItem: Books? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var delegate: MasterViewController?
    
    @IBAction func SaveSelected(_ sender: UIButton) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        

             
        self.detailItem?.bookTitle = bookTitle.text
        self.detailItem?.bookAuthor = name.text
        self.detailItem?.publicationDate = year.text
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error saving book \(error.localizedDescription)")
        }
        
        
        
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        
//        //2
//        let entity =  NSEntityDescription.entity(forEntityName: "Books",
//                                                 in:managedContext)
//        
//        let book = NSManagedObject(entity: entity!,
//                                     insertInto: managedContext)
//        
//        //3
//        book.setValue(bookTitle.text, forKey: "bookTitle")
//        
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Error saving movie \(error.localizedDescription)")
//        }
       //  _ = self.navigationController?.popViewController(animated: true)
        

//        detailItem?.bookTitle = bookTitle.text!
//        detailItem?.bookAuthor = name.text!
//        detailItem?.publicationDate = year.text!
    delegate!.detailViewEditComplete()
    }
    
    
    @IBAction func cancelSelected(_ sender: UIButton) {
        delegate?.detailViewEditCancel()
        
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.bookTitle {
                // label.text = detail.description
                label.text = detail.bookTitle
            }
            if let label = self.year {
                // label.text = detail.description
                label.text = detail.publicationDate
            }
            if let label = self.name {
                // label.text = detail.description
                label.text = detail.bookAuthor
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearArray.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(yearArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case row:
            year.text = String(yearArray[row])
            break
            
        default:
            print("Wrong Selection")
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        
        
        for i in 1899...2015 {
            yearArray.append(i+1)
        }
        
        tapGestuer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTapGesture))
        self.viewbar.addGestureRecognizer(tapGestuer)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    func handleSingleTapGesture(){
        if pickerView.isHidden == false {
            pickerView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

