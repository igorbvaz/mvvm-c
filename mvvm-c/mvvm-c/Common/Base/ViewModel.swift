//
//  ViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 03/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewModel: class {
    var disposeBag: DisposeBag { get set }
}
