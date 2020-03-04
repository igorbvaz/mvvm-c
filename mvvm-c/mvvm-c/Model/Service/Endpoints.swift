//
//  Endpoints.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

struct API {
    static let baseUrl = "https://gateway.marvel.com:443/v1/public"
}

class Endpoints {

    private static func getUrl(path: String) -> String {
        return "\(API.baseUrl)\(path)"
    }

    enum Characters: Endpoint {
        case getCharacters

        var path: String {
            switch self {
            case .getCharacters:
                return "/characters"
            }
        }

        var url: String {
            return Endpoints.getUrl(path: path)
        }
    }

}
