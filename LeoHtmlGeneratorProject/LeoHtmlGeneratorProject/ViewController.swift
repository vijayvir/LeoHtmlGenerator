//
//  ViewController.swift
//  LeoHtmlGeneratorProject
//
//  Created by tecH on 01/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit
import Html

struct SomeStruct  {
    var index : String
    var value  : String
    var intValue : Int
    var computedStrig : String {
        
        return "\(intValue)"
    }
    
    
}


class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
        var someValue : [SomeStruct] = []
        
        someValue.append(SomeStruct(index: "1", value: "3fsdfsd", intValue: 4))
        
        someValue.append(SomeStruct(index: "2", value: "3ffdsfsdfsdsdfsd", intValue: 4))
        
      
        
        var nodesd : [Node] = []
        
        
        
        for object in someValue {
            let listTag = Node.ul(
                .li(  "index: \(object.index)"),
                .li("Dog" , "\(object.value)"),
                .li("Rabbit" , "\(object.computedStrig)")
            )
            nodesd.append(listTag)
            
            
        }
        
        
        for index in 1...5 {
            let listTag = Node.ul(
                .li(  "index: "),
                .li("Dog"),
                .li("Rabbit")
            )
            nodesd.append(listTag)
        }
        
        
        
        
        
        
        let document: Node = .document(
            .html(
                .body(
                     .b( "Hello" , .i("World") , "dsdd"  ),
                    .h1("Welcome!"),
                    .p("You’ve found our site!"),
                    .fragment(nodesd)
                )
            )
        )
        
        
        
        
        
        
        
   
        let html = render(document)
        
        
        
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        
        pdfData.write(to: outputURL, atomically: true)
        print("open \(outputURL.path)")
        
        
    }


}

