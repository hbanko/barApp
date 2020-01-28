//
//  AppDelegate.swift
//  barApp
//
//  Created by Holger Banko on 14/12/19.
//  Copyright © 2019 Holger Banko. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "🌯"

        let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
        statusBarItem.menu = statusBarMenu

        statusBarMenu.addItem(
            withTitle: "Generate List",
            action: #selector(AppDelegate.orderABurrito),
            keyEquivalent: "")

        statusBarMenu.addItem(
            withTitle: "Cancel",
            action: #selector(AppDelegate.cancelBurritoOrder),
            keyEquivalent: "")
        print("Running...")
    }


    @objc func orderABurrito() {
        print("Generating..")
        let vmlist = list_vms()
        let matched = matches(for: "\"(.*?)\"",in: vmlist)

        for match in matched {
           print(match.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil))
        }
        }


    @objc func cancelBurritoOrder() {
        print("Canceling :(")
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
