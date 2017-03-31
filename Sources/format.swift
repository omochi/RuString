//
//  format.swift
//  RuString
//
//  Created by omochimetaru on 2017/04/01.
//
//

import Darwin

public extension RuString {
    static func format(_ format: String, _ args: CVarArg...) -> String {
        return withVaList(args) {
            self.format(format, arguments: $0)
        }
    }
    
    static func format(_ format: String, arguments: CVaListPointer) -> String {
        var bufferp: UnsafeMutablePointer<CChar>? = nil
        let len = Int(Darwin.vasprintf(&bufferp, format, arguments))
        if len < 0 {
            fatalError("vasprintf failed")
        }
        let buffer = bufferp!
        defer {
            Darwin.free(buffer)
        }

        let str = buffer.withMemoryRebound(to: UInt8.self, capacity: len + 1) {
            (p: UnsafeMutablePointer<UInt8>) -> String in
            guard let decoded = String.decodeCString(p, as: UTF8.self) else {
                fatalError("decode failed")
            }
            return decoded.result
        }
        return str
    }
}
