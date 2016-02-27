//
//  AppDelegate.swift
//  EasyWeek
//
//  Created by Oscar Alsing on 23/02/16.
//  Copyright © 2016 Oscar Alsing. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var loginCheckButton: NSButton!
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    
    let launcherAppIdentifier = "oscar.alsing.EasyWeekHelperApp"
    
    override func awakeFromNib() {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        updateStatusBarItemTitle()
        
        menu.addItemWithTitle("Preferences...", action: Selector("displayPreferences:"), keyEquivalent: "")
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItemWithTitle("Quit EasyWeek", action: Selector("terminate:"), keyEquivalent: "q")
        
        setCheckButton()
    
        window.level =  Int(CGWindowLevelForKey(.MaximumWindowLevelKey))
        
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "updateStatusBarItemTitle", userInfo: nil, repeats: true)
    }
    


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        var startedAtLogin = false
        for app in NSWorkspace.sharedWorkspace().runningApplications {
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }
        
        if startedAtLogin {
            NSDistributedNotificationCenter.defaultCenter().postNotificationName("killme", object: NSBundle.mainBundle().bundleIdentifier!)
            //			NSLog("i killed the launcher app!")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    func setCheckButton(){
        //TODO: Implement functionality
        if(NSUserDefaults.standardUserDefaults().boolForKey("loginCheckButton") == false) {
            loginCheckButton.state = 0
        } else {
            loginCheckButton.state = 1
        }
        
        //you should move this next line to somewhere else this is for testing purposes only!!!
    }
    
    func switchCheckButton(){
        var boolVal = false
        
        if(loginCheckButton.state == 1) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginCheckButton")
            boolVal = true
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginCheckButton")
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        SMLoginItemSetEnabled(launcherAppIdentifier, boolVal)
        
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        window.close()
    }
    
    @IBAction func loginCheckButtonPressed(sender: AnyObject) {
        switchCheckButton()
    }
    func displayPreferences(sender: AnyObject?){
        window.orderFront(self)
    }
    
    func getWeek() -> Int {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        let myComponents = myCalendar.components(.WeekOfYear, fromDate: NSDate())
        let weekNumber = myComponents.weekOfYear
        return weekNumber
    }
    
    func updateStatusBarItemTitle() {
        statusBarItem.title = "Week \(getWeek())"
    }


}

