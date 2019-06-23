//
//  AppDelegate.swift
//  MCCalc
//
//  Created by Stephane Carteaux on 28/6/18.
//  Copyright © 2018 SCLab. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    //Cerrar la aplicacion despues de cerrar la ventana
    func applicationShouldTerminateAfterLastWindowClosed (_ theApplication: NSApplication) -> Bool {
        return true
    }


}

