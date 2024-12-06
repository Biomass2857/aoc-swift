import Foundation

func main() {
    let fileURL = URL(fileURLWithPath: "inputs/input03.txt")
    guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
        print("couldnt read file")
        return
    }
    let mulRegex = /mul\(([0-9]+),([0-9]+)\)/

    var offset: String.Index = content.startIndex
    var sum = 0
    while let match = try? mulRegex.firstMatch(in: content[offset...])  {
        let num1 = Int(match.output.1)!
        let num2 = Int(match.output.2)!

        print("found \(match.output.0)")

        sum += num1 * num2

        offset = match.range.upperBound
    }

    print("sum = \(sum)")
}

main()