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

    override func prepareForReuse() {
        super.prepareForReuse()
        // セル情報の初期化
        dayLabel.text = ""
        if #available(iOS 13.0, *) {
            dayLabel.backgroundColor = .systemBackground
            dayLabel.textColor = .label
        } else {
            dayLabel.backgroundColor = .white
            dayLabel.textColor = .darkGray
        }
        countedView.isHidden = true
        self.layer.borderWidth = 0
    }
}
