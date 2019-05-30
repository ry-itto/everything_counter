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

final class CalendarViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()

    @IBOutlet weak var calendarNavigation: UINavigationItem!
    @IBOutlet weak var previousMonthButton: UIBarButtonItem!
    @IBOutlet weak var nextMonthButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            let layout = UICollectionViewFlowLayout()
            let screenBounds = UIScreen.main.bounds
            layout.itemSize = CGSize(width: screenBounds.width / 7, height: screenBounds.width / 7)
            layout.minimumInteritemSpacing = 0
            collectionView.collectionViewLayout = layout
        }
    }
    
    func bind(reactor: CalendarReactor) {
        reactor.state
            .map { "\($0.currentYear)年\($0.currentMonth)月" }
            .bind(to: calendarNavigation.rx.title)
            .disposed(by: disposeBag)
        
        let dataSource = CalendarDataSource()
        reactor.state
            .map { $0.days }
            .debug()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
