//
//  AppDelegate.swift
//  EasyWeekHelperApp
//
//  Created by Oscar Alsing on 23/02/16.
//  Copyright © 2016 Oscar Alsing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainAppIdentifier = "oscar.alsing.EasyWeek"
        let running           = NSWorkspace.sharedWorkspace().runningApplications
        var alreadyRunning    = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: "terminate", name: "killme", object: mainAppIdentifier)
            
            let path = NSBundle.mainBundle().bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("EasyWeek") //main app name
            
            let newPath = NSString.pathWithComponents(components)
            
            NSWorkspace.sharedWorkspace().launchApplication(newPath)
        }
        else {
            self.terminate()
        }
    }
    
    func terminate() {
        //		NSLog("I'll be back!")
        NSApp.terminate(nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

