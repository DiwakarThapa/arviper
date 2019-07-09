import UIKit

extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    
    func dismissModalStack(animated: Bool, completion: (() -> Void)?) {
        let fullscreenSnapshot = UIApplication.shared.delegate?.window??.snapshotView(afterScreenUpdates: false)
        if !isBeingDismissed {
            var rootVc = presentingViewController
            while rootVc?.presentingViewController != nil {
                rootVc = rootVc?.presentingViewController
            }
            let secondToLastVc = rootVc?.presentedViewController
            if fullscreenSnapshot != nil {
                secondToLastVc?.view.addSubview(fullscreenSnapshot!)
            }
            secondToLastVc?.dismiss(animated: false, completion: {
                rootVc?.dismiss(animated: true, completion: completion)
            })
        }
    }
}
