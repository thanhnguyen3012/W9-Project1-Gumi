//
//  HomeViewModel.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

protocol HomeViewModelEvents: AnyObject {
    func temp()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelEvents?
    
    init(delegate: HomeViewModelEvents?) {
        self.delegate = delegate
    }
}
