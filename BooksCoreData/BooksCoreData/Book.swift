//
//  Book.swift
//  Books
//
//  Created by Panjwani, Prateek A on 9/29/16.
//  Copyright © 2016 Panjwani, Prateek A. All rights reserved.
//

import UIKit

class Book: NSObject , NSCoding {
    var bookTitle : String
    var bookAuthor : String
    var publicationDate : String
    
    init(title:String, author:String, pubDate : String)
    {
        self.bookTitle = title
        self.bookAuthor = author
        self.publicationDate = pubDate
    }
    
    override init() {
        self.bookTitle = "Booktitle"
        self.bookAuthor = "AuthorName"
        self.publicationDate = "Publication Date"
        
        // init on super
        super.init()
    }
    
    
    required init(coder decoder: NSCoder) {
        self.bookTitle = decoder.decodeObject(forKey: "bookTitle") as! String
        self.bookAuthor = decoder.decodeObject(forKey: "bookAuthor") as! String
        self.publicationDate = decoder.decodeObject(forKey: "publicationDate") as! String
        
        
        super.init() // super.init(coder:decoder)
    }
    
    func encode(with encoder: NSCoder) {
        
        encoder.encode(bookTitle, forKey: "bookTitle")
        encoder.encode(bookAuthor, forKey: "bookAuthor")
        encoder.encode(publicationDate, forKey: "publicationDate")
        
    }
    
    
}
