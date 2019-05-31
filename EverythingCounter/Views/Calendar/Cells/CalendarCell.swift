//
//  CalendarCell.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/27.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit

final class CalendarCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var countedView: UIView! {
        didSet {
            countedView.layer.cornerRadius = countedView.frame.width / 2
            countedView.clipsToBounds = true
            countedView.backgroundColor = UIColor.Nippon.shinsyu.color()
            countedView.isHidden = true
        }
    }
}
