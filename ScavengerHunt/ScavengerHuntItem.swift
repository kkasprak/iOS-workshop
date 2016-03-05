//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

//Conform to protocol: NSObject, NSCoding
//Allows us to be able to code complete all the different methods
class ScavengerHuntItem : NSObject, NSCoding {
    
    //global constants for keys used to identify the name and photo values
    let nameKey = "name"
    let photoKey = "photo"
    
    let name : String
    //variable for photo; optional
    var photo : UIImage?
    var completed : Bool {
        return photo != nil
    }
    
    //Encode
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    //required = always update the initializer if you end up creating a subclass
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    //initializer
    init(name : String) {
        //similar to this.name in java
        self.name = name
    }
    
}

