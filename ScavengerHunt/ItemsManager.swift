//
//  ItemsManager.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import Foundation

class ItemsManager {
    var itemsList = [ScavengerHuntItem]() //initializing itemsList
    
    //Determine where to save the file
    func archivePath() -> String? { // Returns an optional string
        let directoryList =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/ScavengerHuntItems" //append the file name of the file where we can save it
        }
        assertionFailure("Could not dertermind where to save file!") //ex: chose documentationdirectory instead
        
        return nil //Returns an optional string, so if no string return nil
    }
    
    //We are using NSKeyedArchiver, so each element in the archive is a referenced key
    //Thus, we need keys for each of the elements. See: SvavengerHuntItem.swift
    func save() {
        if let theArchivePath = archivePath() { //unwrap it since it's options
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath) {
                print("Saved Successfully.")
            } else {
                assertionFailure("Could not save data to \(theArchivePath)")
            }
        }
    }
    
    init() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
    
}