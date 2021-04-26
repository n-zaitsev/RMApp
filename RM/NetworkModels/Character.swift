// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome

struct CharactersResponse: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info

struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result

struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown
}

// MARK: - Location

struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case humanoid = "Humanoid"
    case poopybutthole = "Poopybutthole"
    case mythologicalCreature = "Mythological Creature"
    case animal = "Animal"
    case robot = "Robot"
    case cronenberg = "Cronenberg"
    case disease = "Disease"
    case unknown
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
