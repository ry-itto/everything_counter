//
//  TodayViewController.swift
//  EveryThingCounterWidget
//
//  Created by 伊藤凌也 on 2019/10/20.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var tableView: UITableView!
    private var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config = Realm.Configuration()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ry-itto.everything_counter")!
        config.fileURL = url.appendingPathComponent("db.realm")
        do {
            realm = try Realm(configuration: config)
        } catch let e {
            fatalError(e.localizedDescription)
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
