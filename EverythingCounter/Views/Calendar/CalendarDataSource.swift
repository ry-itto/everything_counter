//
//  CalendarDataSource.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class CalendarDataSource: UICollectionViewFlowLayout, UICollectionViewDataSource, RxCollectionViewDataSourceType {
    typealias Element = [Day]
    
    var days: Element = []
    var showStarted: Bool = false
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count + (days.first?.dayOfWeek ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        let dayOfWeek = days[0].dayOfWeek
        
        if indexPath.item == dayOfWeek {
            showStarted = true
        } else if !showStarted {
            cell.dayLabel.text = ""
            return cell
        }
        let dayModel = days[indexPath.row - dayOfWeek]
        
        if dayModel.isToday() {
            cell.dayLabel.backgroundColor = UIColor.Nippon.byakugun.color()
            cell.dayLabel.textColor = .white
            cell.dayLabel.clipsToBounds = true
            cell.dayLabel.layer.cornerRadius = cell.dayLabel.frame.width / 2
        }
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
