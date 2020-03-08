//
//  Service.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class Service {
    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?) -> Observable<Result<T>> {
        return Observable.create { [weak self] (observer) -> Disposable in
//            AF.SessionManager.default.session.getAllTasks { tasks in
//                tasks.forEach { (task) in
//                    if task.currentRequest?.url?.absoluteString == url {
//                        print("URL: \(url) WAS CANCELLED!")
//                        task.cancel()
//                    }
//                }
//            }

            guard let urlWithKeys = self?.handleUrl(url: url) else { return Disposables.create() }
            AF.request(urlWithKeys, method: method, parameters: parameters, headers: nil).validate(statusCode: 200..<300).responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success:
                    guard let value = response.value else { return }
                    observer.onNext(.success(value: value))
                case let .failure(error):
                    observer.onNext(.failure(error: error))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func handleUrl(url: String) -> String {
        if url.contains("?") {
            return url + "&apikey=\(Keys.publicKey)&ts=\(Keys.ts)&hash=\(Keys.hash)"
        } else {
            return url + "?apikey=\(Keys.publicKey)&ts=\(Keys.ts)&hash=\(Keys.hash)"
        }

    }
}
