public extension RuString {
    func components(separatedBy separator: String, limit: Int? = nil) -> [String] {
        if limit == .some(0) {
            return []
        }

        let stringChars: String.CharacterView = selfString.characters
        let separatorChars: String.CharacterView = separator.characters
        var index = stringChars.startIndex
        var charsList: [String.CharacterView] = []
        while true {
            if let lim = limit {
                if charsList.count + 1 == lim {
                    break
                }
            }
            if let foundIndex = findSubArray(array: stringChars, index: index, target: separatorChars) {
                charsList.append(stringChars[index..<foundIndex])
                index = stringChars.index(foundIndex, offsetBy: separatorChars.count)
            } else {
                break
            }
        }
        charsList.append(stringChars[index..<stringChars.endIndex])
        return charsList.map { String($0) }
    }
}


