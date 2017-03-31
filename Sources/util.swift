//
//  util.swift
//  RuString
//
//  Created by omochimetaru on 2017/03/31.
//
//

internal func findSubArray<C: Collection>(
    array: C, index: C.Index, target: C
) -> C.Index?
    where C.SubSequence.Iterator.Element : Equatable
{
    var i = index
    while i < array.endIndex {
        if matchArray(array1: array, index1: i,
                      array2: target, index2: target.startIndex,
                      length: target.count)
        {
            return i
        }
        i = array.index(after: i)
    }
    return nil
}

internal func matchArray<C: Collection>(
    array1: C, index1: C.Index,
    array2: C, index2: C.Index, length: C.IndexDistance) -> Bool
    where C.SubSequence.Iterator.Element : Equatable
{
    if array1.distance(from: index1, to: array1.endIndex) < length {
        return false
    }
    if array2.distance(from: index2, to: array2.endIndex) < length {
        return false
    }

    let test1 = array1[index1..<array1.index(index1, offsetBy: length)]
    let test2 = array2[index2..<array2.index(index2, offsetBy: length)]

    for (x1, x2) in zip(test1, test2) {
        if x1 != x2 {
            return false
        }
    }

    return true
}
