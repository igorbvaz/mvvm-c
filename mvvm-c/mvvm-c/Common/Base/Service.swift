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
        return Observable.create { (observer) -> Disposable in
            Alamofire.SessionManager.default.session.getAllTasks { tasks in
                tasks.forEach { (task) in
                    if task.currentRequest?.url?.absoluteString == url {
                        print("URL: \(url) WAS CANCELLED!")
                        task.cancel()
                    }
                }
            }
            Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if response.result.isSuccess {
                    if let data = response.data {
                        if let object = try? JSONDecoder().decode(T.self, from: data) {
                            observer.onNext(.success(value: object))
                        }
                    }
                } else if let code = (response.error as NSError?)?.code {
                    if code == NSURLErrorNetworkConnectionLost || code == NSURLErrorCancelled {

                    } else {
                        if let error = response.error {
                            observer.onNext(.failure(error: error))
                        }
                    }
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
