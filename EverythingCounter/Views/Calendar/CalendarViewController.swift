//
//  CalendarView.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class CalendarViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()

    @IBOutlet weak var calendarNavigation: UINavigationItem!
    @IBOutlet weak var previousMonthButton: UIBarButtonItem! {
        didSet {
            previousMonthButton.tintColor = UIColor.Nippon.byakugun.color()
        }
    }
    @IBOutlet weak var nextMonthButton: UIBarButtonItem! {
        didSet {
            nextMonthButton.tintColor = UIColor.Nippon.byakugun.color()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            let layout = UICollectionViewFlowLayout()
            let itemWidth = UIScreen.main.bounds.width / 7
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            collectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var closeButton: UIButton!

    func bind(reactor: CalendarReactor) {
        reactor.state
            .map { "\($0.currentYear)年\($0.currentMonth)月" }
            .bind(to: calendarNavigation.rx.title)
            .disposed(by: disposeBag)

        let dataSource = CalendarDataSource()
        reactor.state
            .map { $0.days }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        closeButton.rx.tap
            .bind(to: Binder(self) { calendarVC, _ in
                calendarVC.presentingViewController?.dismiss(animated: true)
            }).disposed(by: disposeBag)

        previousMonthButton.rx.tap
            .map { Reactor.Action.changeToPreviousMonth }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        nextMonthButton.rx.tap
            .map { Reactor.Action.changeToNextMonth }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
