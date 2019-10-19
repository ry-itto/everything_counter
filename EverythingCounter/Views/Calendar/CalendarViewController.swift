//
//  CalendarView.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

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
            collectionView.collectionViewLayout = createLayout()
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

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 7),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
