//
//  Report2PresenterViewController.swift
//  JewelryTrader
//
//  Created by Daniel Slupskiy on 29.12.16.
//  Copyright © 2016 Daniel Slupskiy. All rights reserved.
//

import UIKit

class Report2PresenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let report = storyboard.instantiateViewControllerWithIdentifier("Report2") as! Report2ViewController
        
        presentViewController(report, animated: false, completion: nil)
        let pdfDestination = report.pdfDestination!
        report.dismissViewControllerAnimated(false, completion: {
            self.openPDFViewer(pdfDestination)
        })
    }
    private func openPDFViewer(pdfPath: String) {
        let url = NSURL(fileURLWithPath: pdfPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("PdfViewController") as! PDFPreviewVC
        vc.setupWithURL(url)
        presentViewController(vc, animated: true, completion: nil)
    }

}
