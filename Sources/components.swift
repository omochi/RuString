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

            guard let found = findIndex(collection: stringView, startIndex: index, targets: separatorViewList) else {
                break
            }

            let foundEndIndex = stringView.index(found.index, offsetBy: found.target.count)
            let charsEndIndex = keepSeparator ? foundEndIndex : found.index
            resultViewList.append(stringView[index..<charsEndIndex])
            index = foundEndIndex
        }

        resultViewList.append(stringView[index..<stringView.endIndex])
        return resultViewList.map { String($0) }
    }
}


