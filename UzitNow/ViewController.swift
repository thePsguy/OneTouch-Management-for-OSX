//
//  ViewController.swift
//  UzitNow
//
//  Created by Pushkar Sharma on 19/02/16.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import Cocoa
import Foundation
import Security


class ViewController: NSViewController {

    
    @IBOutlet weak var hostName: NSTextField!
    @IBOutlet weak var osxLogo: NSImageView!
    @IBOutlet weak var osName: NSTextField!
    @IBOutlet weak var CPUPerc: NSTextField!
    @IBOutlet weak var RAMPerc: NSTextField!
    @IBAction func onDisk(sender: AnyObject) {
        runTerm("diskutil verifyvolume ")
    }
    

    
    @IBAction func onTerm(sender: AnyObject) {
     runTerm("")
    }
    
    @IBAction func onCleaner(sender: AnyObject) {
            runTerm("sudo rm -rf ~/.Trash/ && rm -rf ~/Library/Logs && rm -rf TMPDIR && rm -rf ~/Library/Logs")
    }
    @IBAction func onSysinfo(sender: AnyObject) {
        runTerm("/Applications/Utilities/\'System Information.app\'/Contents/MacOS/\'System Information\'")
    }
    @IBAction func onRobo(sender: AnyObject) {
           runTerm("/Applications/Utilities/\'Activity Monitor.app\'/Contents/MacOS/\'Activity Monitor\'")
    }
    @IBAction func onScan(sender: AnyObject) {
        runTerm("/System/Library/CoreServices/\'Network Diagnostics.app\'/Contents/MacOS/\'Network Diagnostics\'")
    }
    
    @IBAction func onApps(sender: AnyObject) {
        runTerm("open /Applications")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        func getOSVersion()-> Int {
            var OSVer: String = NSProcessInfo.processInfo().operatingSystemVersionString
            OSVer = OSVer.substringWithRange(Range<String.Index>(start: OSVer.startIndex.advancedBy(11), end: OSVer.startIndex.advancedBy(13)))
            return Int(OSVer)!
        }

       
        
        let _: NSTimer! = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        
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
        
        
        
        self.RAMPerc.stringValue = getRAM()
        // Do any additional setup after loading the view.
        
            }
    
    func runTerm(command:String){
        let actve: String = "activate application \"Terminal\""
        let s: String = "tell application \"Terminal\" to do script \"\(command)\""
        let script2: NSAppleScript = NSAppleScript(source: actve)!
        let script: NSAppleScript = NSAppleScript(source: s)!
        script.executeAndReturnError(nil)
        script2.executeAndReturnError(nil)
    }
    
    
    func getCPUPerc() -> String{
        let pipe: NSPipe = NSPipe()
        let file: NSFileHandle = pipe.fileHandleForReading
        let task: NSTask = NSTask()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c","ps -A -o %cpu | awk '{s+=$1} END {print s \"%\"}'"]
        task.standardOutput = pipe
        task.launch()
        let data: NSData = file.readDataToEndOfFile()
        file.closeFile()
        let CPUput = String(data: data, encoding: NSUTF8StringEncoding)
        
        return CPUput!
    }
    
    func getRAM() -> String{
        let pipe: NSPipe = NSPipe()
        let file: NSFileHandle = pipe.fileHandleForReading
        let task: NSTask = NSTask()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c","sysctl hw.memsize"]
        task.standardOutput = pipe
        task.launch()
        let data: NSData = file.readDataToEndOfFile()
        file.closeFile()
        var RAM:String = String(data: data, encoding: NSUTF8StringEncoding)!
        RAM = RAM.substringWithRange(Range<String.Index>(start: RAM.startIndex.advancedBy(12), end: RAM.endIndex.advancedBy(-1)))
        let RAMvalue:String = String(Int(RAM)!/1073741824) + " GB"
        return RAMvalue
    }


    
    func runTimedCode() {
       // print(getCPUPerc())
       self.CPUPerc.stringValue = getCPUPerc()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

