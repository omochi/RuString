public extension RuString {
    func components(separatedBy separator: String,
                    limit: Int? = nil,
                    keepSeparator: Bool = false) -> [String] {
        return components(separatedBy: [separator],
                          limit: limit, keepSeparator: keepSeparator)
    }

    func components(separatedBy separators: [String],
                    limit: Int? = nil,
                    keepSeparator: Bool = false) -> [String]
    {
        if let limit = limit {
            precondition(limit > 0, "limit > 0")
        }

        let stringChars: String.CharacterView = selfString.characters
        let separatorCharsList: [String.CharacterView] = separators.map { $0.characters }
        var index = stringChars.startIndex
        var charsList: [String.CharacterView] = []
        while true {
            if let limit = limit {
                if charsList.count + 1 == limit {
                    break
                }
            }

            var foundIndexOpt: String.CharacterView.Index? = nil
            var foundEndIndexOpt: String.CharacterView.Index? = nil
            for separatorChars in separatorCharsList {
                if let fi = findSubArray(array: stringChars, index: index, target: separatorChars) {
                    foundIndexOpt = foundIndexOpt.map { min($0, fi) } ?? fi
                    foundEndIndexOpt = stringChars.index(foundIndexOpt!, offsetBy: separatorChars.count)
                }
            }

            guard let foundIndex = foundIndexOpt,
                let foundEndIndex = foundEndIndexOpt else {
                break
            }

            let charsEndIndex = keepSeparator ? foundEndIndex : foundIndex
            charsList.append(stringChars[index..<charsEndIndex])

            index = foundEndIndex
        }

        charsList.append(stringChars[index..<stringChars.endIndex])
        return charsList.map { String($0) }
    }
}


