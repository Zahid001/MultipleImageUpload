//
//  ContentView.swift
//  MultipleImageUpload
//
//  Created by Md Zahidul Islam Mazumder on 7/12/20.
//

import SwiftUI
import Alamofire
import UIKit

struct ContentView: View {
    @State var ImageArray : NSMutableArray!
     var body: some View {
        Text("Hello, world!")
            .onAppear(){
                

                // Here is your post parameter
                let parameters = [
                    
                    "productname" : "z",
                    "productpriceoriginal": "22",
                    "sellproductprice":"333",
                    "productcategoryID":"7",
                    "vendorID":"2",
                    "isrecentproduct":"is_new",

                
                ] as  [String:String]
                
                let ImageDic = [
                    "productcoverImage" : UIImage(named: "a")!.pngData(),
                    "product_image[0]image" : UIImage(named: "aa")!.pngData(),
                    "product_image[1]image" : UIImage(named: "c")!.pngData(),
                    "product_image[2]image" : UIImage(named: "cc")!.pngData()
                
                ]


                ImageArray = NSMutableArray(array: [ImageDic as NSDictionary])

  
                let url = ""
                postImageRequestWithURL(withUrl: url, withParam: parameters, withImages: ImageArray) { (isSuccess, response) in
                      
                    print("ss",isSuccess.description)
                    print("res",response)
                    }
            }
    }
    
    

    
    func postImageRequestWithURL(withUrl strURL: String,withParam postParam: Dictionary<String, Any>,withImages imageArray:NSMutableArray,completion:@escaping (_ isSuccess: Bool, _ response:NSDictionary) -> Void)
    {

        AF.upload(multipartFormData: { (MultipartFormData) in

            
            for (imageDic) in imageArray
            {
                let imageDic = imageDic as! NSDictionary

                for (key,valus) in imageDic
                {
                    MultipartFormData.append(valus as! Data, withName:key as! String,fileName: "file.jpg", mimeType: "image/jpg")
                }
            }

            
            for (key, value) in postParam
            {
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }

        }, to: strURL, usingThreshold: UInt64.init(), method: .post).response { (response) in
            print("response",response.debugDescription)
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
