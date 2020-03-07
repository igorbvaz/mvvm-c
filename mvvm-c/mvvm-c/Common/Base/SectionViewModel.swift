//
//  SectionViewModel.swift
//  mvvm-c
//
//  Created by Igor Vaz on 05/03/20.
//  Copyright © 2020 Igor Vaz. All rights reserved.
//

import RxDataSources

final class SectionViewModel<T>: SectionModelType {

    typealias Item = T

    var title: String?
    var items: [T]

    init(title: String? = nil, items: [T]) {
        self.title = title
        self.items = items
    }

    convenience init(original: SectionViewModel, items: [T]) {
        self.init(title: original.title, items: items)
    }

}
