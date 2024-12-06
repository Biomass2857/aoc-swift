import Foundation

struct Report {
    var levels: [Int8]

    enum Increase {
        case increasing, decreasing, nothing
    }

    func isValid() -> Bool {
        guard let first = levels.first else { return false }
        var previous = first
        var previousInc: Increase? = nil
        
        for index in 1..<levels.count {
            let nextLevel = levels[index]
            let diff = Int(nextLevel) - Int(previous)
            var currentInc: Increase
            
            if diff > 0 {
                currentInc = .increasing
            } else if diff < 0 {
                currentInc = .decreasing
            } else {
                currentInc = .nothing
            }

            if currentInc == .nothing {
                print("no increase")
                printReport()
                return false
            }

            if let pInc = previousInc {
                if pInc != currentInc {
                    print("wrong increase")
                    printReport()
                    return false
                }
            }

            if abs(diff) == 0 || abs(diff) > 3 {
                print("too high diff")
                printReport()
                return false
            }

            previous = nextLevel
            previousInc = currentInc
        }

        print("safe")
        printReport()
        return true
    }

    func printReport() {
        print(".levels = \(levels)")
    }
}

func main() {
    let fileURL = URL(fileURLWithPath: "inputs/input02.txt")
    guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
        print("couldnt read fle")
        return
    }
    let lines = content.split(separator: "\n")
    var reports: [Report] = []

    for line in lines {
        let levelsString = line.split(separator: " ")
        var levelsInteger: [Int8] = []

        for level in levelsString {
            if let intValue = Int8(level) {
                levelsInteger.append(intValue)
            }
        }

        reports.append(Report(levels: levelsInteger))
    }

    var sum: Int32 = 0
    for report in reports {
        if report.isValid() {
            sum += 1
        }
    }

    print("reports safe = \(sum)")
}

main()