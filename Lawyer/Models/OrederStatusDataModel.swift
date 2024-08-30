//
//  OrederStatusDataModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 15/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation


/*
 

 Experience = "8-10 years";

 LawyerAssign = 37;
 LawyerName = gaurav;
 PaymentAmount = "<null>";
 PaymentDate = "01/01/1970 05:30:00";
 PaymentMethod = "<null>";
 ProfilePhoto = "https://www.allindialegal.com/uploads/37/profile/\U2014Pngtree\U2014vector_user_young_boy_avatar_4827810.png";
 Qualification = "B.B.A.+ L.L.B.- Bachelor of Business Administration & Bachelor of Legislative of Law";
 Query = "";
 Status =     (
             {
         id = 0;
         name = "Payment Pending";
     },
             {
         id = 1;
         name = "Payment Done";
     },
             {
         id = 2;
         name = "Lawyer Assigned";
     }
 );
 SupportEmail = "aman.sharma@corwhite.com";
 SupportPhoneNumber = 0123456789;
 
 */


class OrederStatusDataModel{
    
    var PaymentAmount:String = String()
    var PaymentDate:String = String()
    var PaymentMethod:String = String()
    var GST:String = String()
    var Query:String = String()
    
    var LawyerAssign:String = String()
    var LawyerName:String = String()
    var Experience:String = String()
    var ProfilePhoto:String = String()
    var Qualification:String = String()
    var BookingDate:String = String()
    var BookingTime:String = String()
    
    var SupportEmail:String = String()
    var SupportPhoneNumber:String = String()
    
    var title:String = String()
    
    var Review:String = String()
    var IsRating:String = String()
    
   
  
    init(PaymentAmount:String,PaymentDate:String,PaymentMethod:String,GST:String,Query:String,LawyerAssign:String,LawyerName:String,Experience:String,ProfilePhoto:String,Qualification:String,SupportEmail:String,SupportPhoneNumber:String,title:String,BookingDate:String,BookingTime:String,Review:String,IsRating:String){
        self.PaymentAmount = PaymentAmount
        self.PaymentDate = PaymentDate
        self.PaymentMethod = PaymentMethod
        self.GST = GST
        self.Query = Query
        
        self.LawyerAssign = LawyerAssign
        self.LawyerName = LawyerName
        self.Experience = Experience
        self.ProfilePhoto = ProfilePhoto
        self.Qualification = Qualification
        
        self.BookingDate = BookingDate
        self.BookingTime = BookingTime
        
        self.Review = Review
        self.IsRating = IsRating
        
        self.SupportEmail = ProfilePhoto
        self.SupportPhoneNumber = Qualification
        
        self.title = title
    }
    
}
