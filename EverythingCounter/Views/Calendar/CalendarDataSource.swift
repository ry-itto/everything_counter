//
//  CalendarDataSource.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class CalendarDataSource: UICollectionViewFlowLayout, UICollectionViewDataSource, RxCollectionViewDataSourceType {
    typealias Element = [Day]

    var days: Element = []

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count + (days.first?.dayOfWeek ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            as? CalendarCell else {
            return UICollectionViewCell()
        }
        let dayOfWeek = days[0].dayOfWeek

        if indexPath.item < dayOfWeek {
            return cell
        }
        let dayModel = days[indexPath.row - dayOfWeek]

        // 本日のセルだった場合日付の背景に色をつける
        if dayModel.isToday() {
            cell.dayLabel.backgroundColor = UIColor.Nippon.byakugun.color()
            cell.dayLabel.textColor = .white
            cell.dayLabel.clipsToBounds = true
            cell.dayLabel.layer.cornerRadius = cell.dayLabel.frame.width / 2
        }

        // カウントされた日だった場合カウントしたことを示すビューを表示する
        if dayModel.isCountedDay {
            cell.countedView.isHidden = false
        }

        // セルに外枠をつける
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        cell.layer.borderWidth = 0.5

        cell.dayLabel.text = "\(dayModel.day)"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<[Day]>) {
        Binder(self) { dataSource, days in
            dataSource.days = days
            collectionView.reloadData()
        }.on(observedEvent)
    }
}
