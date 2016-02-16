//: Playground - noun: a place where people can play
import UIKit
import XCPlayground


class MyCell: UITableViewCell {
  
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
    }
    override func drawRect(rect: CGRect) {
        
        self.contentView.backgroundColor = UIColor.clearColor()
        
        
        
        let whiteRoundedView = UIView(frame: CGRectMake(10, 10, rect.width - 20 , rect.height - 10))
        
        whiteRoundedView.backgroundColor = UIColor.whiteColor()
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        

        
        self.contentView.addSubview(whiteRoundedView)
        self.contentView.sendSubviewToBack(whiteRoundedView)
        
    }
}
class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MyCell()
        cell.clearsContextBeforeDrawing = true
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
}


let tv = UITableView(frame: CGRect(x: 0, y: 0, width: 350, height: 600))
tv.backgroundColor = UIColor.cyanColor()

let ds = DataSource()

tv.delegate = ds
tv.dataSource = ds

XCPlaygroundPage.currentPage.liveView = tv
