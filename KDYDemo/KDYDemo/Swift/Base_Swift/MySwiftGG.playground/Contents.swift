//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, SwiftGG"

/**
 *  1 使用泛型来避免UIKit的模板代码
 */

public class GenericView: UIView {
    public required init() {
        super.init(frame: CGRect.zero)
        configureView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureView() {}
}

class AwesomeView: GenericView {
    override func configureView() {
        //...
    }
}
let awesomeView = AwesomeView()

//将这个模式配合泛型ViewController
public class GenericViewController<View: GenericView>: UIViewController {
    internal var contentView: View {
        return view as! View
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func loadView() {
        view = View()
    }
}

class AwesomeViewController: GenericViewController<AwesomeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        //...
    }
}

/**
 *  2 Guard大法好，入Guard保平安
 */

/**
    @objc func didPressLogIn(sender: AnyObject?) {
        guard !isPerformingLogIn else { return }
        isPerformingLogIn = true
        
        let email = contentView.formView.emailField.text
        let password = contentView.formView.passwordField.text
        
        guard validateAndShowError(email, password: password) else {
            isPerformingLogIn = false
            return
        }
        
        sendLogInRequest(ail, password: password)
    }
 */

/**
    currentRequest?.getValue { [weak self] result in
        guard let user = result.okValue where result.errorValue = nil else {
            self?.showRequestError(result.errorValue)
            self?.isPerformingSignUp = false
            return
        }
        
        self?.finishSignUp(user)
    }
*/

/**
 *  3 在使用subViews时候，将声明和配置同时进行
 *  - OC也有同样的写法，而在Swift中我们可以利用"属性声明代码块"来配置view
 */
class AwesomeTwoView: GenericView {
    let bestTitleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = .redColor()
        
        return label
    }()
    
    let otherTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Left
        label.textColor = .greenColor()
        
        return label
    }()
    
    override func configureView() {
        super.configureView()
        
        addSubview(bestTitleLable)
        addSubview(otherTitleLabel)
    }
}

/**
 *  4 面向协议编程
 *  - 知道什么是协议扩展，但是到底什么是面向协议编程呢？
 *  - 在有了协议扩展后，在以类为主的UIKit中改为基于协议的实现方式更有价值。
 *    怎么将Swift的协议扩展与真实世界中的UI完美结合。
 *  - 当需要在应用中添加共享代码和通用的功能时，协议和协议扩展就会变得非常有价值，且代码组织清晰有条理。
 */

protocol P {
    var somePropery: String { get }
    func someFunc()
}

extension P {
    var somePropery: String {
        return ""
    }
    
    func someFunc() {
    
    }
}

extension UICoordinateSpace {
    func invertedRect(rect: CGRect) -> CGRect {
        var transform = CGAffineTransformMakeScale(1, -1)
        transform = CGAffineTransformTranslate(transform, 0, -self.bounds.size.height)
        return CGRectApplyAffineTransform(rect, transform)
    }
}

extension UITableViewDataSource {
    func totalRows(tableView: UITableView) -> Int {
        let totalSections = self.numberOfSectionsInTableView?(tableView) ?? 1
        
        var s = 0, t = 0
        while s < totalSections {
            t += self.tableView(tableView, numberOfRowsInSection: s)
            s += 1
        }
        
        return t
    }
}

//扩展自定义协议
//Model管理中的协议(M)
protocol RemoteResource {}

extension RemoteResource {
    func load(url: String, completion: ((success: Bool)->())?) {
        print("Request Url: ", url)
    }
}

protocol JSONResource: RemoteResource {
    var jsonHost: String { get }
    var jsonPath: String { get }
    func processJSON(success: Bool)
}

extension JSONResource {
    var jsonHost: String {
        return "api.pearmusic.com"
    }
    
    var jsonURL: String {
        return String(format: String(format: "http://%@%@", self.jsonHost, self.jsonPath))
    }
    
    func loadJSON(completion: (()->())?) {
        self.load(self.jsonURL) { (success) -> () in
            self.processJSON(success)
            
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
}

//在样式中使用协议(V)
protocol Styled {
    func updateStyles()
}

protocol BackgroundColor: Styled {
    var color: UIColor { get }
}

protocol FontWieght: Styled {
    var size: CGFloat { get }
    var bold: Bool { get }
}

protocol BackgroundColor_Purple: BackgroundColor {}
extension BackgroundColor_Purple {
    var color: UIColor { return UIColor.purpleColor() }
}

protocol FontWight_H1: FontWieght {}
extension FontWight_H1 {
    var size: CGFloat { return 24.0 }
    var bold: Bool { return true }
}

extension UITableViewCell: Styled {
    func updateStyles() {
        if let s = self as? BackgroundColor {
            self.backgroundColor = s.color
            self.textLabel?.textColor = .whiteColor()
        }
        
        if let s = self as? FontWieght {
            self.textLabel?.font =
                (s.bold) ? UIFont.boldSystemFontOfSize(s.size) : UIFont.systemFontOfSize(s.size)
        }
    }
} 

class PurpleHeaderCell: UITableViewCell, BackgroundColor_Purple, FontWight_H1 {}

/**
 *  5 Block实现链式编程
 */

struct Dictionary<Key, Value where Key: Hashable> {
    private var storage = []
    subscript(key: Key) -> Value? {
        get {
            return nil
        }
        set {
            
        }
    }
}



