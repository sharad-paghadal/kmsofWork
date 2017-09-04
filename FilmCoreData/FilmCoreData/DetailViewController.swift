//
//  DetailViewController.swift
//  FilmCoreData
//
//  Created by Sharad Paghadal on 07/12/16.
//  Copyright © 2016 temp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var filmNameText: UITextField!
    @IBOutlet weak var actorNameText: UITextField!
    @IBOutlet weak var releaseDateText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet var viewbar: UIView!
    @IBAction func showPicker(sender: AnyObject) {
        datePicker.hidden = false
    }
    @IBAction func hidePicker(sender: AnyObject) {
        datePicker.hidden = true
    }

    var detailItem: Films? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    var delegate: MasterViewController?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.filmNameText {
                label.text = detail.valueForKey("filmName")!.description
            }
            if let label = self.actorNameText {
                label.text = detail.valueForKey("actorName")?.description
            }
            if let label = self.releaseDateText {
                label.text = detail.valueForKey("releaseDate")?.description
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.hidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.viewbar.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    func handleTap() {
        if datePicker.hidden == false {
            datePicker.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setDateAndTime() {
//        
//        dateFormatter.dateStyle = NSDateFormatter.defaultFormatterBehavior()
//        //timeFormatter.timeStyle = DateFormatter.Style.full
//        dateTimeDisplay.text = dateFormatter.string(from: datePicker.date) + " " + timeFormatter.string(from: timePicker.date)
//    }
//    
    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        releaseDateText.text = strDate
    }
    

    @IBAction func saveBtnClicked(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        self.detailItem?.filmName = filmNameText.text
        self.detailItem?.actorName = actorNameText.text
        self.detailItem?.releaseDate = releaseDateText.text
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error saving book \(error.localizedDescription)")
        }
        
        delegate!.detailViewEditComplete()
    }

    @IBAction func cancelBtnClicked(sender: AnyObject) {
        delegate?.detailViewEditCancel()
    }
}

