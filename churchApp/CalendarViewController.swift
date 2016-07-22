//
//  CalendarViewController.swift
//  churchApp
//
//  Created by Michael Voshell on 11/3/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit
import Parse
import Bolts

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    
    var objectIdArray : [String] = [];
    var dateArray : [String] = [];
    var eventArray : [String] = [];
    var timeArray : [String] = [];
   
   
    
    func getIDs()
    {
        let query = PFQuery(className:"calendar")
        query.whereKey("calendar", equalTo:"cal")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                // Do something with the found objects
                if let objects = objects as? [PFObject]! {
                    for object in objects {
                        
                        let myIDs = object.objectId
                        //print(myIDs)
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

    }
    
    func getData()
    {
        
        
        for  var i = 0; i < objectIdArray.count; ++i {
            let query = PFQuery(className:"calendar")
            query.getObjectInBackgroundWithId(objectIdArray[i]) {
                (sermonObject: PFObject?, error: NSError?) -> Void in
                if error == nil && sermonObject != nil {
                    
                    self.dateArray.append(sermonObject?.objectForKey("date") as! String)
                    self.eventArray.append(sermonObject?.objectForKey("event") as! String)
                    self.timeArray.append(sermonObject?.objectForKey("time") as! String)
                    //print(sermonObject?.objectForKey("title"))
                    
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.myTableView.reloadData()
                    });
                    
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
        
       

         getIDs()


        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return eventArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : calendarCustomCell = tableView.dequeueReusableCellWithIdentifier("myCell")! as! calendarCustomCell
        
        
        cell.calLabel.text = eventArray[indexPath.row]
        
        cell.dateLabel.text = dateArray[indexPath.row]
        
        cell.timeLabel.text = timeArray[indexPath.row]
        
        return cell
        
        
        
    }
  
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
