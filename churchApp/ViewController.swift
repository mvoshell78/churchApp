//
//  ViewController.swift
//  churchApp
//
//  Created by Michael Voshell on 10/31/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController{

   
    @IBOutlet weak var creed: UITextView!

    @IBOutlet weak var phone: UITextView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var name: UILabel!
  
    @IBOutlet weak var web: UITextView!
    
    var objectIdArray : [String] = [];
    
    
    func getData()
    {
        
        
        for  var i = 0; i < objectIdArray.count; ++i {
            let query = PFQuery(className:"about")
            query.getObjectInBackgroundWithId(objectIdArray[i]) {
                (aboutObject: PFObject?, error: NSError?) -> Void in
                if error == nil && aboutObject != nil {
                    
                    self.name.text = aboutObject?.objectForKey("name") as? String
                    self.phone.text = aboutObject?.objectForKey("phone") as? String
                    self.city.text = aboutObject?.objectForKey("city") as? String
                    self.address.text = aboutObject?.objectForKey("address") as? String
                    self.creed.text = aboutObject?.objectForKey("creed") as? String
                    self.web.text = aboutObject?.objectForKey("web") as? String
                   
                    
                   
                    
                } else {
                    let alert : UIAlertView = UIAlertView(title: "No Internet Connection", message: "Check your network settings and try again" , delegate: nil, cancelButtonTitle: "Dismiss")
                    // calls the alert
                    alert.show();
                }
                
            }
            
        }
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let query = PFQuery(className:"about")
        query.whereKey("church", equalTo:"yes")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                // Do something with the found objects
                if let objects = objects as [PFObject]! {
                    for object in objects {
                        
                        let myIDs = object.objectId
                        self.objectIdArray.append(myIDs!)
                        
                    }
                    //print(self.objectIdArray)
                    self.getData()
                }
            } else {
                let alert : UIAlertView = UIAlertView(title: "No Internet Connection", message: "Check your network settings and try again" , delegate: nil, cancelButtonTitle: "Dismiss")
                // calls the alert
                alert.show();
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
}
  

       /* let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }*/
        
    
     
        
        // Do any additional setup after loading the view, typically from a nib.







