//
//  AddViewController.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    //Optional SHI variable that the destination view controller can use to retrieve new item if there is one
    var newItem: ScavengerHuntItem?
    
    //Text field outlet
    @IBOutlet weak var textField: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Check if this is the DoneItem segue
        if segue.identifier == "DoneItem" {
            //Get the source view controller, which is an instance of AddViewController
            if let name = textField.text {//unwrap the testField's text value
                //If the Add View Controller has a new item, add it to the list of items
                if !name.isEmpty { //check if the name is empty
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

