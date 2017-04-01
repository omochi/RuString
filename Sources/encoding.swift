//
//  encode.swift
//  RuProcess
//
//  Created by omochimetaru on 2017/04/01.
//
//

public extension RuString {
    enum Encoding {
        case utf8
        case utf16le
        case utf16be
    }
}

public extension RuString {
    func encode(encoding: Encoding = .utf8) -> [UInt8] {
        switch encoding {
        case .utf8:
            return selfString.utf8.map { $0 }
        case .utf16le:
            let us = selfString.utf16.map { $0.littleEndian }
            return us.withUnsafeBytes {
                (buf: UnsafeRawBufferPointer) -> [UInt8] in
                return buf.map { $0 }
            }
        case .utf16be:
            let us = selfString.utf16.map { $0.bigEndian }
            return us.withUnsafeBytes {
                (buf: UnsafeRawBufferPointer) -> [UInt8] in
                return buf.map { $0 }
            }
        }
    }

    static func decode(data: [UInt8], encoding: Encoding = .utf8) -> String {
        if data.count == 0 {
            return ""
        }

        switch encoding {
        case .utf8:
            return decodeCodecUnits(data, codec: UTF8.self)
        case .utf16le:
            let units: [UInt16] = data.withUnsafeBytes { buf in
                let mem = buf.baseAddress!.bindMemory(to: UInt16.self, capacity: buf.count)
                let tbuf = UnsafeBufferPointer<UInt16>(start: mem,
                                                       count: buf.count / 2)
                return tbuf.map { UInt16(littleEndian: $0) }
            }
            return decodeCodecUnits(units, codec: UTF16.self)
        case .utf16be:
            let units: [UInt16] = data.withUnsafeBytes { buf in
                let mem = buf.baseAddress!.bindMemory(to: UInt16.self, capacity: buf.count)
                let tbuf = UnsafeBufferPointer<UInt16>(start: mem,
                                                       count: buf.count / 2)
                return tbuf.map { UInt16(bigEndian: $0) }
            }
            return decodeCodecUnits(units, codec: UTF16.self)
        }
    }

    private static func decodeCodecUnits<S: Sequence, C: UnicodeCodec>(
    _ units: S, codec: C.Type) -> String
    where S.Iterator.Element == C.CodeUnit
    {
        var view = String.UnicodeScalarView()

        var c = codec.init()
        var iterator = units.makeIterator()
        var exit = false
        while !exit {
            switch c.decode(&iterator) {
            case let .scalarValue(x):
                view.append(x)
            case .emptyInput:
                exit = true
                break
            case .error:
                break
            }
        }

        return String(view)
    }
}
