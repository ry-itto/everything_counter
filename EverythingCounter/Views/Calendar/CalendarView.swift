//
//  CalendarView.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class CalendarView: UIView, View {
    var disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    func bind(reactor: CalendarReactor) {
        
    }
}
