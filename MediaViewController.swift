//
//  MediaViewController.swift
//  churchApp
//
//  Created by Michael Voshell on 11/3/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MediaViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBAction func backButton ( segue : UIStoryboardSegue)
    {
        
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    var objectArray : [String] = [];
    var titleArray : [String] = [];
    var nameArray : [String] = [];
    var audioUrl : [String] = [];
    
   
    
   
    
    
    func getIDs()
    {
        
        let query = PFQuery(className:"sermons")
        query.whereKey("sermon", equalTo:"sermon")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
               // print(objects!.count)
                // Do something with the found objects
                if let objects = objects as? [PFObject]! {
                    for object in objects {
                        
                        let myIDs = object.objectId
                        //print("my ids\(myIDs)")
                        self.objectArray.append(myIDs!)
                        
                    }
                    //print(self.objectArray)
                    self.getData()
                   
                }
            } else {
                // Log details of the failure
                let alert : UIAlertView = UIAlertView(title: "No Internet Connection", message: "Check your network settings and try again" , delegate: nil, cancelButtonTitle: "Dismiss")
                // calls the alert
                alert.show();
            }
        }
        
    }
    func getData()
    {
        for  var i = 0; i < objectArray.count; ++i {
            let query = PFQuery(className:"sermons")
            query.getObjectInBackgroundWithId(objectArray[i]) {
                (sermonObject: PFObject?, error: NSError?) -> Void in
                if error == nil && sermonObject != nil {
                    
                    self.titleArray.append(sermonObject?.objectForKey("title") as! String)
                    self.nameArray.append(sermonObject?.objectForKey("name") as! String)
                    if let audioFile = sermonObject?["sermonFile"] as? PFFile {
                    
                    let audioFileUrlString: String = audioFile.url!
                    
                    print(audioFileUrlString)
                    self.audioUrl.append(audioFileUrlString)
                    }
                    
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
            print(self.titleArray)
            print(self.nameArray)
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
       
        return titleArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : MediaCustomCell = tableView.dequeueReusableCellWithIdentifier("myCell")! as! MediaCustomCell
        
        
            cell.title.text = titleArray[indexPath.row]
        
            cell.name.text = nameArray[indexPath.row]
        
        
        
        return cell
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   
        
            let mediaPlay : mediaPlayViewController = segue.destinationViewController as! mediaPlayViewController
            let indexPath : NSIndexPath? = myTableView.indexPathForSelectedRow;
        
           mediaPlay.titleLabel = titleArray[indexPath!.row]
            print(titleArray[indexPath!.row])
           mediaPlay.sermonTitle = nameArray[indexPath!.row]
           mediaPlay.audioFileUrlString = audioUrl[indexPath!.row]
        
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
