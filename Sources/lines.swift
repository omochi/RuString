//
//  lines.swift
//  RuString
//
//  Created by omochimetaru on 2017/04/01.
//
//

public extension RuString {
    func lines() -> [String] {
        return components(separatedBy: ["\r\n", "\n", "\r"],
                          keepSeparator: true)
    }
}
