import Foundation

func main() {
    let fileURL = URL(fileURLWithPath: "input03.txt")
    guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
        print("couldnt read file")
        return
    }
    let lines = content.split(separator: "\n")

}

main()