//
//  Ru.swift
//  RuString
//
//  Created by omochimetaru on 2017/03/31.
//
//

//  Believe copy on write
public struct RuString {
    internal init(string: String) {
        self.selfString = string
    }

    internal let selfString: String
}

public extension String {
    var ru: RuString {
        return RuString(string: self)
    }

    static let ru: RuString.Type = RuString.self
}
