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
            Alamofire.SessionManager.default.session.getAllTasks { tasks in
                tasks.forEach { (task) in
                    if task.currentRequest?.url?.absoluteString == url {
                        print("URL: \(url) WAS CANCELLED!")
                        task.cancel()
                    }
                }
            }

            guard let urlWithKeys = self?.handleUrl(url: url) else { return Disposables.create() }
            Alamofire.request(urlWithKeys, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if let code = (response.error as NSError?)?.code {
                    if code == NSURLErrorNetworkConnectionLost || code == NSURLErrorCancelled {

                    } else {
                        if let error = response.error {
                            observer.onNext(.failure(error: error))
                        }
                    }
                } else if response.result.isSuccess {
                    if let data = response.data {
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            print("Got \(T.self) from request")
                            observer.onNext(.success(value: object))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
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
