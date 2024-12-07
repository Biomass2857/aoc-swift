import Foundation

let magicWord = "XMAS"

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard indices ~= index else {
            return nil
        } 

        return self[index]
    }
}

struct LetterMap {
    private let data: [[Character]]

    init(repr: String) {
        let lines = repr.split(separator: "\n")
        var data: [[Character]] = []
        for line in lines {
            data.append(line.compactMap { $0 })
        }

        self.data = data
    }

    private func getStringAtTrace(i: Int, j: Int, trace: (Int) -> (Int, Int)) -> String? {
        let positions = Array(0..<magicWord.count).map { index -> (Int, Int) in
            let offset = trace(index)
            return (i + offset.0, j + offset.1)
        }

        let size = size()

        guard positions.allSatisfy({ (x, y) in
            0..<(size.0) ~= x && (0..<(size.1)) ~= y
        }) else {
            return nil
        }

        return String(positions.compactMap { (x, y) -> Character? in
            return self.data[x][y]
        })
    }

    func getStringsLeftDiagonalDownwards(i: Int, j: Int) -> [String] {
        [
            getStringAtTrace(i: i, j: j) { offset in
                (offset, 0)
            },
            getStringAtTrace(i: i, j: j) { offset in
                (0, offset)
            },
            getStringAtTrace(i: i, j: j) { offset in
                (offset, offset)
            },
            getStringAtTrace(i: i, j: j) { offset in
                (offset, -offset)
            }
        ].compactMap { $0 }
    }

    func size() -> (i: Int, j: Int) {
        (data.count, data[0].count)
    }
}

func main() {
    let fileURL = URL(fileURLWithPath: "inputs/input04.txt")
    guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
        print("couldnt read file")
        return
    }

    let map = LetterMap(repr: content)
    let size = map.size()
    var sum = 0
    for i in 0..<size.0 {
        for j in 0..<size.1 {
            let forwards = map.getStringsLeftDiagonalDownwards(i: i, j: j)
            let backwards = forwards.map { String($0.reversed()) }
            let all = forwards + backwards

            if(i == size.i - 5 && j == size.j - 5) {
                print("all i == size.i - 5, j == size.j - 5:")
                dump(all)
            }

            sum += all.count { $0 == magicWord }
        }
    }

    print("sum = \(sum)")
}


main()