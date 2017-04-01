//
//  strip.swift
//  RuString
//
//  Created by omochimetaru on 2017/04/01.
//
//

public extension RuString {
    static let whiteStrings: [String] = ["\n", "\r", " ", "\t"]

    func lstrip(removes: [String] = whiteStrings) -> String {
        typealias View = String.UnicodeScalarView
        let stringView: View = selfString.unicodeScalars
        let removeViewList: [View] = removes.map { $0.unicodeScalars }

        var newStartIndex = stringView.startIndex

        while true {
            var found = false

            for removeChars in removeViewList {
                if matchCollection(collection1: stringView,
                                   index1: newStartIndex,
                                   collection2: removeChars)
                {
                    found = true
                    newStartIndex = stringView.index(newStartIndex, offsetBy: removeChars.count)
                    break
                }
            }

            if !found {
                break
            }
        }

        return String(stringView[newStartIndex..<stringView.endIndex])
    }

    func rstrip(removes: [String] = whiteStrings) -> String {
        typealias View = String.UnicodeScalarView
        let stringView: View = selfString.unicodeScalars
        let removeViewList: [View] = removes.map { $0.unicodeScalars }
        
        var newEndIndex = stringView.endIndex

        while true {
            var found = false

            for removeChars in removeViewList {
                if matchCollection(collection1: stringView,
                                   index1: stringView.index(newEndIndex, offsetBy: -removeChars.count),
                                   collection2: removeChars)
                {
                    found = true
                    newEndIndex = stringView.index(newEndIndex, offsetBy: -removeChars.count)
                    break
                }
            }

            if !found {
                break
            }
        }

        return String(stringView[stringView.startIndex..<newEndIndex])
    }

    func strip(removes: [String] = whiteStrings) -> String {
        var s = selfString
        s = s.ru.lstrip(removes: removes)
        s = s.ru.rstrip(removes: removes)
        return s
    }

}
