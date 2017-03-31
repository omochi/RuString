public extension String {
    func split(separator: String, limit: Int? = nil) -> [String] {
        if limit == .some(0) {
            return []
        }

        var codes: [UnicodeScalar] = self.unicodeScalars.map { $0 }
        let separaterCodes: [UnicodeScalar] = separator.unicodeScalars.map { $0 }
        var index = 0
        var strs: [[UnicodeScalar]] = []
        while true {
            if let lim = limit {
                if strs.count + 1 == lim {
                    break
                }
            }
            if let foundIndex = findSubArray(array: codes, index: index, target: separaterCodes) {
                strs.append(Array(codes[index..<foundIndex]))
                index = foundIndex + separaterCodes.count
            } else {
                break
            }
        }
        strs.append(Array(codes[index..<codes.count]))

        return strs.map { codes in
            var view = String.UnicodeScalarView()
            view.append(contentsOf: codes)
            return String(view)
        }
    }
}

internal func findSubArray<T: Equatable> (
    array: [T], index: Int, target: [T]
) -> Int?
{
    for i in index..<array.count {
        if matchArray(array1: array, index1: i, array2: target, index2: 0, length: target.count) {
            return i
        }
    }
    return nil
}

internal func matchArray<T: Equatable>(
    array1: [T], index1: Int,
    array2: [T], index2: Int, length: Int) -> Bool
{
    if array1.count - index1 < length {
        return false
    }
    if array2.count - index2 < length {
        return false
    }
    for i in 0..<length {
        if array1[index1 + i] != array2[index2 + i] {
            return false
        }
    }
    return true
}
