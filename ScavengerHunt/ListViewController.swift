//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Apple on 3/5/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Instantiates a new ItemsManager for us
    let myManager = ItemsManager()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //create an instance of UIPickerController
        let imagePicker = UIImagePickerController()
        //Ask if source type 'Camera' is available
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            //tell our instance imagePicker that we want it to use the source type Camera
            imagePicker.sourceType = .Camera
        } else {
            //If no camera, set source type to PhotoLibrary for our instance called imagePicker
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        //UIImagePickerController has a presentViewController method
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            //ask info dictionary for the photo
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
            dismissViewControllerAnimated(true, completion: { () -> Void in self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)})
        }
    }
    
    //Implement the two methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count //will return the number of items in the list (array)
    }
    
    //Cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        //Add text to the cell
        let item = myManager.itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        if (item.completed) {
            //Add an accessory type of checkmark to the end of the cell
            cell.accessoryType = .Checkmark
            //Set the image view
            cell.imageView?.image = item.photo
        } else {
            //No checkmark (because there is no photo)
            cell.accessoryType = .None
            //no image view
            cell.imageView?.image = nil
        }
        
        //Return the cell
        return cell
    }
    
    //Unwind segue
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        //If the segue is the DoneItem segue
        if segue.identifier == "DoneItem" {
            //create constant that will be the reference to AddViewController
            //use as! to say it has to be an AddViewController
            let addVC = segue.sourceViewController as! AddViewController
            //ask AddView Controller for the new item that was created
            if let newItem = addVC.newItem {
                //Store it in the items list
                myManager.itemsList += [newItem] //used [] to say it was an array of one item so we could add them together
                myManager.save() //save early and often
                //Add to the table view
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    

}
