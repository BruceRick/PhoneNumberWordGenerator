//
//  ContentView.swift
//  PhoneNumber
//
//  Created by Bruce Rick on 2022-09-07.
//

import SwiftUI

// Given a phone number print all possible words.
// Hint use recursion
// 23 -> AD AE AF BD BE BF CD CE CF
// 234 -> ADG ADH ADI AEG AEH AEI AFG AFH AFI BDG BDH BDI BEG BEH BEI etc etc
let numberMap: [String: [String]] = [
  "0": ["0"],
  "1": ["1"],
  "2": ["A", "B", "C"],
  "3": ["D", "E", "F"],
  "4": ["G", "H", "I"],
  "5": ["J", "K", "L"],
  "6": ["M", "N", "O"],
  "7": ["P", "Q", "R", "S"],
  "8": ["U", "V"],
  "9": ["W", "X", "Y", "Z"]
]

struct ContentView: View {
  @State var possibleWords: [String] = []
  @State var phoneNumber: String = ""
  var body: some View {
    HStack {
      Text("Phone Number:")
      TextField("Phone Number", text: $phoneNumber)
        .textContentType(.telephoneNumber)
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
        .onSubmit {
          updatePossibleWords()
        }
      Button {
        updatePossibleWords()
      } label: {
        Text("Submit")
      }
    }.padding()
    if possibleWords.isEmpty {
      Text("NO WORDS").foregroundColor(.red)
      Spacer()
    } else {
      List(possibleWords, id: \.self) {
        Text($0)
      }
    }
  }
  
  func updatePossibleWords() {
    possibleWords = []
    addWords()
  }
  
  func addWords(digitIndex: Int = 0) {
    let phoneNumberCharacters = phoneNumber.map(digitCharacters)
    if digitIndex >= phoneNumberCharacters.count { return }
    let array = phoneNumberCharacters[digitIndex]
    if possibleWords.isEmpty {
      possibleWords += array
    } else {
      possibleWords.forEach { (c1) in
        array.forEach({ (c2) in
          possibleWords.append(c1+c2)
        })
        if !array.isEmpty {
          possibleWords.removeAll { $0 == c1 }
        }
      }
    }
    addWords(digitIndex: digitIndex+1)
  }
  
  func digitCharacters(digit: Character) -> [String] {
    guard let possibleChars = numberMap["\(digit)"] else {
      return []
    }
    
    return possibleChars
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
