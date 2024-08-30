//
//  Detail_TableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import TagListView

class Detail_TableViewCellAndXib: SBaseTableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var btnSelectRef: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setUpTextField()
    }
    
    
    //MARK: - Configure method with
    public func configure(with info:[String]){
        
        self.tagListView.removeAllTags()
        
        for item in info{
            tagListView.addTag(item)
        }
        
        tagListView.textFont = AppFont.Regular.size(AppFontName.OpenSans, size: 16)
        tagListView.cornerRadius = 5
        tagListView.shadowRadius = 5
        tagListView.shadowOpacity = 0.4
        tagListView.shadowColor = AppColor.darkGrayColor
        tagListView.shadowOffset = CGSize(width: 1, height: 1)
        tagListView.paddingY = 5
        tagListView.paddingX = 12
        tagListView.marginY = 5
        tagListView.marginX = 7
        tagListView.alignment = .left
 
    }
    
    //TODO: Setup textFieldFloating
    private func setUpTextField(){
        lblValue.font = AppFont.Regular.size(AppFontName.OpenSans, size: 14)
        lblValue.textColor = AppColor.darkGrayColor
        lblValue.numberOfLines = 0
    }
  
}
