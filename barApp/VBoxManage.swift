//
//  VBoxManage.swift
//  barApp
//
//  Created by Holger Banko on 28/1/20.
//  Copyright © 2020 Holger Banko. All rights reserved.
//
import Foundation

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
    task.executableURL = URL(fileURLWithPath: "/Applications/VirtualBox.app/Contents/MacOS/VBoxManage")
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
    }
    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: outputData, as: UTF8.self)
    
    // let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
    // let error = String(decoding: errorData, as: UTF8.self)

    return output
}
