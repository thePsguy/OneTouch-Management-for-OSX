//
//  ViewController.swift
//  UzitNow
//
//  Created by Pushkar Sharma on 19/02/16.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

    
    @IBOutlet weak var hostName: NSTextField!
    @IBOutlet weak var osxLogo: NSImageView!
    @IBOutlet weak var osName: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func getOSVersion()-> Int {
            var OSVer: String = NSProcessInfo.processInfo().operatingSystemVersionString
            OSVer = OSVer.substringWithRange(Range<String.Index>(start: OSVer.startIndex.advancedBy(11), end: OSVer.startIndex.advancedBy(13)))
            return Int(OSVer)!
        }
        
        let hostString = NSProcessInfo.processInfo().hostName
        let OSVer = getOSVersion()
        var OSName:String
        
        self.hostName.stringValue = hostString
        
        switch(OSVer){
        case 11:
            OSName = "OSX El Capitan"
            break
        case 10:
            OSName = "OSX Yosemite"
            break
        case 9:
            OSName = "OSX Mavericks"
            break
        case 8:
            OSName = "OSX Mountain Lion"
            break
        case 7:
            OSName = "OSX Lion"
            break
        case 6:
            OSName = "OSX Snow Leopard"
            break
        default:
            OSName = "OSX Leopard"
            break
        }
        self.osName.stringValue = OSName
        //let imgName = NSURL(fileURLWithPath:"Images/OSX/11.png")
        self.osxLogo.image = NSImage(named: String(OSVer))
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

