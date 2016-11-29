//
//  HistoryViewCell.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

class HistoryViewCell: UITableViewCell {

    let TAP_WIDTH: CGFloat = 80
    let SECONDS_SHOW_MEMO = 2.5
    // Day LayOut
    let HistoryViewCellHeight = 31.0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var practiceLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var moodIconImage: UIImageView!
    @IBOutlet weak var memoIconLabel: UILabel!
    
    var mood: Int = 0{
        didSet {
           moodIconImage.image = Mood.image(with: mood)
        }
    }
    var hasMemo: Bool = false {
        didSet {
            memoIconLabel.text = hasMemo ? UserSettings.memoIndicator : ""
        }
    }
    
    // MARK: - touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let locationInView = touch!.location(in: self)
        if (locationInView.x >= (self.contentView.frame.width - TAP_WIDTH)) {
            if hasMemo {
                self.showMemo()
            }
        } else {
            // edit mood, add/edit memo , edit time???, delete.
            super.touchesBegan(touches, with: event)
        }
    }
    
    // MARK: - memo
    
    func showMemo() {
        displayMemo(true)
        perform(#selector(hideMemo), with: nil, afterDelay: SECONDS_SHOW_MEMO)

    }
    
    func hideMemo() {
        displayMemo(false)
    }
    
    func displayMemo(_ show: Bool) {
        memoLabel.isHidden = !show
        dateLabel.isHidden = show
        practiceLabel.isHidden = show
    }
    
}
