//
//  RuStringStatic.swift
//  RuString
//
//  Created by omochimetaru on 2017/04/01.
//
//

public struct RuStringStatic {
    internal init() {}
}

public extension String {
    public static let ru: RuStringStatic = RuStringStatic()
}
