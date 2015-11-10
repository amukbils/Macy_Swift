class ProgressHUDHelper {

  // MARK: - PROPERTIES (PRIVATE)
  private let aidProgress = UIActivityIndicatorView()
  private let containerView = UIView()

  // MARK: - CONSTRUCTORS
  class var sharedInstance: ProgressHUDHelper {
    struct Static {
      static let instance: ProgressHUDHelper = ProgressHUDHelper()
    }

    return Static.instance
  }

  // MARK: - FUNCTIONS
  func showProgressHUDInView(view: UIView) { // Pass 'self.navigationController.view' when using a Navigation Controller
    containerView.frame = view.frame
    containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    containerView.center = view.center

    aidProgress.frame = CGRectMake(0, 0, 40, 40)
    aidProgress.activityIndicatorViewStyle = .WhiteLarge
    aidProgress.center = CGPointMake(containerView.frame.size.width / 2, containerView.frame.size.height / 2)

    containerView.addSubview(aidProgress)
    view.addSubview(containerView)

    aidProgress.startAnimating()
  }

  func hideProgressHUD() {
    aidProgress.stopAnimating()

    aidProgress.removeFromSuperview()
    containerView.removeFromSuperview()
  }

}