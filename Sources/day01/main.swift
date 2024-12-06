import Foundation

func main() {
    let filePath = "inputs/input01.txt"
    
    guard let content = try? String(contentsOfFile: filePath) else {
        print("Failed to read file.")
        return
    }
    
    let lines = content.split(separator: "\n")
    
    var list1: [Int] = []
    var list2: [Int] = []
    
    for line in lines {
        let values = line.split(separator: "   ")
        
        guard values.count >= 2,
              let val1 = Int(values[0].trimmingCharacters(in: .whitespacesAndNewlines)),
              let val2 = Int(values[1].trimmingCharacters(in: .whitespacesAndNewlines)) else {
            continue
        }
        
        list1.append(val1)
        list2.append(val2)
    }
    
    list1.sort()
    list2.sort()
    
    assert(list1.count == list2.count)
    
    var diff: UInt32 = 0
    for index in 0..<list1.count {
        let v1 = list1[index]
        let v2 = list2[index]
        
        diff += UInt32(abs(v2 - v1))
    }
    
    print("diff = \(diff)")
}

main()