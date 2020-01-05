import Foundation
import UIKit
import RxSwift
//playgroundShouldContinueIndefinitely()
//
//example("of") {
//    struct Student {
//               var name: String
//               var score: Variable<Int>
//           }
//
//           let disposeBag = DisposeBag()
//
//           let studentA = Student(name: "Mr.A", score: Variable(5))
//           let studentB = Student(name: "Mr.B", score: Variable(10))
//           let studentC = Student(name: "Mr.C", score: Variable(15))
//
//           let sourceObservable = Observable.of(studentA, studentB, studentC)
//
//           sourceObservable
//               .flatMapLatest { element in
//                   return element.score.asObservable()
//               }
//               .subscribe(onNext: { score in
//                   print("Student's score \(score)")
//               })
//               .disposed(by: disposeBag)
//
//           studentA.score.value = 25
//           studentB.score.value = 30
////           studentC.score.value = 35
//
//}

struct Employee {
    var name: String
    var id: Int
    var favoriteToy: Toy

    enum CodingKeys: String, CodingKey {
      case id = "employeeId"
      case name
      case gift
    }
}

struct Toy: Codable {
    var name: String
}

extension Employee: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encode(favoriteToy.name, forKey: .gift)
  }
}

extension Employee: Decodable {
    init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
           let gift = try values.decode(String.self, forKey: .gift)
         favoriteToy = Toy(name: gift)
    }
}

let toy1 = Toy(name: "Teddy Bear");
let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee1)

let stringData = String(data: jsonData, encoding: .utf8)
print(stringData)
let jsonDecoder = JSONDecoder()
let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)
