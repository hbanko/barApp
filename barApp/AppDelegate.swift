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
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func list_vms() -> String {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/local/bin/VBoxManage")
        
        let option = "list"
        let command = "vms"
        
        task.arguments = [option, command]
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        task.standardOutput = outputPipe
        task.standardError = errorPipe
        do {
            try task.run()
            } catch {
                print("Error launching VBoxManage")
                print(errorPipe)
                print(error.localizedDescription, error)
        }
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: outputData, as: UTF8.self)
        
        // let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        // let error = String(decoding: errorData, as: UTF8.self)
        print(output)
        return output
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
