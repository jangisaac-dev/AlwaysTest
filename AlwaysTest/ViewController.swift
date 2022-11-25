//
//  ViewController.swift
//  AlwaysTest
//
//  Created by Isaac Jang on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {
    //test change

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var strUrls : [String] = [
            "https://media.istockphoto.com/id/1095468748/vector/qr-code-abstract-vector-modern-bar-code-sample-for-smartphone-scanning-isolated-on-white.jpg?s=612x612&w=0&k=20&c=Jnh2TAkAFm7QpaBgCyCuGbCA6nomDfk4-XiTsBhbHFk=", //failed
            "https://www.investopedia.com/thmb/hJrIBjjMBGfx0oa_bHAgZ9AWyn0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/qr-code-bc94057f452f4806af70fd34540f72ad.png",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2kqCkYsqrHO8kIJZjyZLv7rMCNYH9Sqj1gfYZ_ts&s",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwsbys2Uo5s2BgmUm_nEmndt9dwEt_S20X2A&usqp=CAU",
            "https://www.cyberciti.biz/media/new/faq/2021/09/qrcode-for-URL-www.cyberciti.biz_.png",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKwic4EB1IA5Nv_QlzbVhuit53AtNlJD7_UQ&usqp=CAU",
            "https://edit.org/img/blog/7go-qr-code-menu-restaurant-template-print.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzzsnzkqFiiUbdK64yy3NfrUam0loEGk8FbQ&usqp=CAU",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjZ2YGR-jyLIhxJwNNgdjX8WTV3CXvDas5Ww&usqp=CAU", // failed
            "https://rocketbookhelp.zendesk.com/hc/article_attachments/360041006473/IMG_3405_2.jpg",
            "https://i.pinimg.com/736x/e4/9c/07/e49c079079cc115887787063c9b96adf--carb-free-window-decals.jpg"
        ]
        
        for strUrl in strUrls {
            loadImage(
                strUrl: strUrl
            ) { img in
                
                guard let img = img else {
                    return
                }
                guard let detector : CIDetector = CIDetector(
                    ofType: CIDetectorTypeQRCode,
                    context: nil,
                    options: [CIDetectorAccuracy : CIDetectorAccuracyHigh]
    //                options: [CIDetectorAccuracy : CIDetectorAccuracyLow]
                ) else {
                    return
                }
                
                guard let ciImage:CIImage = CIImage(image:img) else {
                    return
                }
                
                var qrCodeLink = ""
                
                guard let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
                    return
                }
                
                
                for feature in features {
                    qrCodeLink += feature.messageString ?? ""
                }

                if qrCodeLink=="" {
                    print("\(strUrl) : nothing")
                }else{
                    print("\(strUrl) : \(qrCodeLink)")
                }
            }
        }
    
        
    }
    
    
    func loadImage(strUrl: String, completion: @escaping (UIImage?)->Void) {
        DispatchQueue.global().async { // background thread
            guard let url = URL(string: strUrl) else {
                completion(nil)
                return
            }
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
            else {
                completion(nil)
            }
        }
    }

}
