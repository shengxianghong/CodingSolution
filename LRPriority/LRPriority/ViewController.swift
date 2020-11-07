//
//  ViewController.swift
//  LRPriority
//
//  Created by s&z on 2020/10/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.leftLabel.text = "左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边左边"
        self.rightLabel.text = "右边优先哦哦哦右边优先哦哦哦右边优先哦哦哦"
    }


}

