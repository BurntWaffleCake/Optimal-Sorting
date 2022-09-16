//command
//cat random.txt | head -n 1000 | swift Sorting.swift
import Foundation

var randomWords : [String] = []
while let input = readLine() {
    randomWords.append(input)
}

//from apple forums
func flatten(_ array: [Any]) -> [Any] {
    var result = [Any]()
    for element in array {
        if let element = element as? [Any] {
            result.append(contentsOf: flatten(element))
        } else {
            result.append(element)
        }
    }
    return result
}

func returnChar(string:String, offsetBy:Int) -> Character? {
    if string.count > offsetBy {
        let index = string.index(string.startIndex, offsetBy:offsetBy)
        return string[index]
    }
    return Character(" ")
}

func compareWords(wordA: String, wordB:String) -> String { 
    if wordA.lowercased().filter({"abcdefghijklmnopqrstuvwxyz".contains($0)}) < wordB.lowercased().filter({"abcdefghijklmnopqrstuvwxyz".contains($0)}) {
        return wordA
    } else {
        return wordB
    }
}

func sortStrings(strings:[String], charCount:Int) -> [Any] {
    var Strings: [[Any]] = []
    for word in strings {
        var added = false
        for (count, array) in Strings.enumerated() {
            //compare array's first word's first letter with word's first letter
            if returnChar(string:array[0] as! String, offsetBy:charCount) == returnChar(string:word, offsetBy:charCount) {
                if charCount <= word.count {
                    Strings[count].append(word)
                    added = true
                }
                break
            }
        }
        
        //if no array with first letter of word was found, make new array with word
        if !added {
            var position = 0
            for array in Strings {
                if compareWords(wordA: word,wordB: array[0] as! String) == word {
                    break
                } else {
                    position += 1
                }
            }
            Strings.insert([word],at:position)                
        }
    }
    
    for (count,array) in Strings.enumerated() {
        if array.count > 1 {
            Strings[count] = (sortStrings(strings: array as! [String], charCount:charCount + 1))
        }
    }
    return Strings 
}

/* lowercased sort */
// var randomWordsLower : [String] = []
// for word in randomWords {
//     randomWordsLower.append(word.lowercased())
// }

for _ in 0..<1 {
    let start = DispatchTime.now()
    let sortedStrings = flatten(sortStrings(strings: randomWords, charCount:0))

    let end = DispatchTime.now()
    let differenceNano = end.uptimeNanoseconds - start.uptimeNanoseconds
    let runtime = Double(differenceNano) / 1_000_000.0
    //print(sortedStrings)
    print("Runtime: \(runtime) ms")
}

// let start2 = DispatchTime.now()
// let sortedWords = randomWords.sorted { $0.lowercased() < $1.lowercased() }
// let end2 = DispatchTime.now()

// let differenceNano2 = end2.uptimeNanoseconds - start2.uptimeNanoseconds
// let runtime2 = Double(differenceNano2) / 1_000_000.0
// print("Runtime: \(runtime2) ms")
