//
//  CounterCell.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/18.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class CounterCell: UITableViewCell, View {
    static let cellIdentifier = "CounterCell"
    static let rowHeight: CGFloat = 70
    
    var disposeBag = DisposeBag()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton! {
        didSet {
            decreaseButton.backgroundColor = UIColor.Nippon.byakugun.color()
            decreaseButton.layer.cornerRadius = decreaseButton.frame.height / 2
            // 影の設定
            decreaseButton.layer.shadowOpacity = 0.5
            decreaseButton.layer.shadowRadius = 3
            decreaseButton.layer.shadowColor = UIColor.black.cgColor
            decreaseButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var increaseButton: UIButton! {
        didSet {
            increaseButton.backgroundColor = UIColor.Nippon.byakugun.color()
            increaseButton.layer.cornerRadius = increaseButton.frame.height / 2
            // 影の設定
            increaseButton.layer.shadowOpacity = 0.5
            increaseButton.layer.shadowRadius = 3
            increaseButton.layer.shadowColor = UIColor.black.cgColor
            increaseButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    @IBOutlet weak var valueLabel: UILabel!
    
    //MARK:- reactorがセットされたタイミングで呼ばれる
    func bind(reactor: CounterCellReactor) {
        // Action
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        // title
        reactor.state
            .map { $0.title }
            .distinctUntilChanged()
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        // value
        reactor.state
            .map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
