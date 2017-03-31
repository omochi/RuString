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
        typealias View = String.UnicodeScalarView

        if let limit = limit {
            precondition(limit > 0, "limit > 0")
        }

        let stringView: View = selfString.unicodeScalars
        let separatorViewList: [View] = separators.map { $0.unicodeScalars }
        var index = stringView.startIndex
        var resultViewList: [View] = []
        while true {
            if let limit = limit {
                if resultViewList.count + 1 == limit {
                    break
                }
            }

            var foundIndexOpt: View.Index? = nil
            var foundEndIndexOpt: View.Index? = nil
            for separatorChars in separatorViewList {
                if let fi = findSubArray(array: stringView, index: index, target: separatorChars) {
                    if foundIndexOpt == nil || fi < foundIndexOpt! {
                        foundIndexOpt = fi
                        foundEndIndexOpt = stringView.index(foundIndexOpt!, offsetBy: separatorChars.count)
                    }
                }
            }

            guard let foundIndex = foundIndexOpt,
                let foundEndIndex = foundEndIndexOpt else {
                break
            }

            let charsEndIndex = keepSeparator ? foundEndIndex : foundIndex
            resultViewList.append(stringView[index..<charsEndIndex])

            index = foundEndIndex
        }

        resultViewList.append(stringView[index..<stringView.endIndex])
        return resultViewList.map { String($0) }
    }
}


