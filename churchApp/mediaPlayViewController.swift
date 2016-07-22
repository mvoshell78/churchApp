//
//  mediaPlayViewController.swift
//  churchApp
//
//  Created by Michael Voshell on 11/3/15.
//  Copyright © 2015 Michael Voshell. All rights reserved.
//

import UIKit
import AVFoundation
import Parse
import Bolts

class mediaPlayViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer = AVPlayer()
    var sermonTitle : String = "";
    var titleLabel : String = "";
    var objectId : String = "";
    var audioFileUrlString : String = "";
    
    @IBOutlet weak var trackTitle: UILabel!
   
    @IBAction func playOrPause(sender: AnyObject) {
       if (audioPlayer.rate < 0.99)
       {
        audioPlayer.play()
     sender.setImage(UIImage(named: "pause.png")!, forState: .Normal)
       } else {
      print("Play Pushed")
      
        audioPlayer.pause()
       sender.setImage(UIImage(named: "play.png")!, forState: .Normal)
        }
    }
    
    
    @IBAction func fastForward(sender: AnyObject) {
        
        if (audioPlayer.rate < 0.99)
        {
            audioPlayer.play()
        } else if (audioPlayer.rate == 1)
        {
           audioPlayer.rate = 10.0
        } else if (audioPlayer.rate == 10.0)
        {
            audioPlayer.rate = 1
        } else {
            audioPlayer.rate = 0
        }
        
        
    }
   
    @IBAction func rewind(sender: AnyObject) {
        if (audioPlayer.rate == 1)
        {
            audioPlayer.rate = -10
        } else if (audioPlayer.rate == -10)
        {
            audioPlayer.rate = 1
        
        } else {
            audioPlayer.rate = 0
        }
    }
    
    

    
    
    
    @IBOutlet weak var displayTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(objectId)
        myAudio()
        print("test\(titleLabel)")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        displayTitle.text = titleLabel
        trackTitle.text = sermonTitle
        
    }
   
    func myAudio (){
        /*print("myAudio Loaded")
        let mySongQuery = PFQuery(className:"sermons")
        mySongQuery.getObjectInBackgroundWithId(self.objectId, block: {
            (object : PFObject?, error: NSError?) -> Void in
            //print(self.objectId)
            
            
            if let audioFile = object?["sermonFile"] as? PFFile {
                let audioFileUrlString: String = audioFile.url!
        
                //self.audioUrl.append(audioFileUrlString)*/
                 print(audioFileUrlString)
                let audioFileUrl = NSURL(string: audioFileUrlString)!
                self.audioPlayer = AVPlayer(URL: audioFileUrl)
            //}
        //})
        
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
