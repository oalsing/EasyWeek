//
//  AppDelegate.swift
//  EasyWeek
//
//  Created by Oscar Alsing on 23/02/16.
//  Copyright © 2016 Oscar Alsing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var loginCheckButton: NSButton!
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    
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
    }
    func switchCheckButton(){
        if(NSUserDefaults.standardUserDefaults().boolForKey("loginCheckButton") == false) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "loginCheckButton")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "loginCheckButton")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
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

