//
//  ViewController.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import UIKit

final class APODViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "APOD"
      
        let request = Request()
        
        print(request.url)
        // Do any additional setup after loading the view.
    }


}

