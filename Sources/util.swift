//
//  util.swift
//  RuString
//
//  Created by omochimetaru on 2017/03/31.
//
//

internal func findIndex<C: Collection>(
    collection: C, startIndex: C.Index,
    pred: (C, C.Index) -> Bool) -> C.Index?
{
    var index = startIndex
    while index < collection.endIndex {
        if pred(collection, index) {
            return index
        }
        index = collection.index(after: index)
    }
    return nil
}

internal func findIndex<C: Collection>(
    collection: C, startIndex: C.Index,
    targets: [C]
    ) -> (index: C.Index, target: C)?
    where C.SubSequence.Iterator.Element : Equatable
{
    var result: (index: C.Index, target: C)? = nil

    let _ = findIndex(collection: collection, startIndex: startIndex) { (c, i) in
        for target in targets {
            if matchCollection(collection1: c, index1: i, collection2: target) {
                result = (index: i, target: target)
                return true
            }
        }
        return false
    }

    return result
}

internal func matchCollection<C: Collection>(
    collection1: C,
    index1: C.Index,
    collection2: C,
    index2 index2Opt: C.Index? = nil,
    length lengthOpt: C.IndexDistance? = nil) -> Bool
    where C.SubSequence.Iterator.Element : Equatable
{
    let index2 = index2Opt ?? collection2.startIndex
    let length = lengthOpt ?? collection2.distance(from: index2, to: collection2.endIndex)

    if collection1.distance(from: index1, to: collection1.endIndex) < length {
        return false
    }
    if collection2.distance(from: index2, to: collection2.endIndex) < length {
        return false
    }

    let test1 = collection1[index1..<collection1.index(index1, offsetBy: length)]
    let test2 = collection2[index2..<collection2.index(index2, offsetBy: length)]

    for (x1, x2) in zip(test1, test2) {
        if x1 != x2 {
            return false
        }
    }

    return true
}
