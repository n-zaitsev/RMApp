//
//  APIConfiguration.swift
//  School
//
//  Created by Импрув on 09.04.2021.
//

import Alamofire
import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Params? { get }
}

enum Params {
    case body(_: Parameters)
    case url(_: Parameters)
}
