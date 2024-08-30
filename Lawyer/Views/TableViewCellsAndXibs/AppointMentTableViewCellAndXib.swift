//
//  AppointMentTableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class AppointMentTableViewCellAndXib: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    //MARK: - Variables
    internal let spacing:CGFloat = 10.0
    internal var arrayTiming = [AppointmentTimeDataModel]()
    internal var cellCollectionCallBack:((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.timeCollectionView?.collectionViewLayout = layout
        self.timeCollectionView.isScrollEnabled = false
        self.timeCollectionView.backgroundColor = AppColor.whiteColor
        self.timeCollectionView.delegate = self
        self.timeCollectionView.dataSource = self
        self.timeCollectionView.isHidden = false
        registerNib()
        
        
        
        
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.timeCollectionView.register(nib: TimeCollectionViewCellAndXib.className)
        DispatchQueue.main.async {
            self.timeCollectionView.reloadData()
        }
  
    }
    
}
