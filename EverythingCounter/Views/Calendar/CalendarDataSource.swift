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
        
        if indexPath.item == days[0].dayOfWeek {
            showStarted = true
        } else if !showStarted {
            cell.dayLabel.text = ""
            return cell
        }
        
        cell.dayLabel.text = "\(days[indexPath.row - days[0].dayOfWeek].day)"
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<[Day]>) {
        Binder(self) { dataSource, days in
            dataSource.days = days
            collectionView.reloadData()
        }.on(observedEvent)
    }
}
