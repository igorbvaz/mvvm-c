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
    func request<T: Decodable>(endpoint: Endpoint, method: HTTPMethod, parameters: Parameters? = nil) -> Observable<Result<T>> {
        return Observable.create { (observer) -> Disposable in

            AF.request(endpoint.url, method: method, parameters: parameters, headers: nil).validate(statusCode: 200..<300).responseDecodable(of: T.self) { (response) in
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
}
