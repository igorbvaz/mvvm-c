//
//  Endpoints.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import Foundation

protocol Endpoint {
    var url: String { get }
}

class Endpoints {

    private static func getUrl(path: String, queryItems: [URLQueryItem]) -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.port = 443
        components.path = "/v1/public" + path
        components.queryItems = queryItems
        components.queryItems?.append(URLQueryItem(name: "apikey", value: Keys.publicKey))
        components.queryItems?.append(URLQueryItem(name: "ts", value: Keys.ts))
        components.queryItems?.append(URLQueryItem(name: "hash", value: Keys.hash))
        return components.url?.absoluteString ?? ""
    }

    enum Characters: Endpoint {
        case getCharacters(offset: Int)

        var url: String {
            switch self {
            case .getCharacters(let offset):
                return Endpoints.getUrl(path: "/characters", queryItems: [
                    URLQueryItem(name: "offset", value: String(describing: offset)),
                    URLQueryItem(name: "limit", value: String(describing: 20))
                ])
            }

        }
    }

}
