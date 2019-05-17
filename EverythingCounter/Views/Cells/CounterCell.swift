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
    static let rowHeight: CGFloat = 50
    
    var disposeBag = DisposeBag()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
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
        reactor.state
            .map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
