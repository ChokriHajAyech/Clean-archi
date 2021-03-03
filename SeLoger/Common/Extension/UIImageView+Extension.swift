import UIKit
import SDWebImage

extension UIImageView {
    func downloadImage(url: String?, placeHolder: UIImage?,
                       completion: @escaping (_ image: UIImage?)
                        -> Void) throws {
        guard let url = url else {
            completion(placeHolder)
            return
        }
        self.sd_imageTransition =  .fade
        if let url = URL(string: url) {
            self.sd_imageIndicator?.startAnimatingIndicator()
            self.sd_setImage(with: url) { (image, _, _, _) in
                self.sd_imageIndicator?.stopAnimatingIndicator()
                completion(image)
            }
        } else {
            completion(placeHolder)
        }
    }
}
