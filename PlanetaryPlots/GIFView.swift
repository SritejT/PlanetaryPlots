
import SwiftUI
import FLAnimatedImage

struct GIFView: UIViewRepresentable {
    
    var encodedGIF: String
    
    init(base64: String) {
        self.encodedGIF = base64
    }
    
    let animatedView = FLAnimatedImageView()
    func makeUIView(context: UIViewRepresentableContext<GIFView>) -> UIView {
        let view = UIView()
        
        if let gifData = Data(base64Encoded: encodedGIF) {
            let gif = FLAnimatedImage(animatedGIFData: gifData)
            animatedView.animatedImage = gif
        }
        
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        // animatedView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        // animatedView.layer.cornerRadius = 10
        // animatedView.layer.borderWidth = 1
        // animatedView.layer.borderColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 0.75).cgColor
        
        view.addSubview(animatedView)
        
        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalToConstant: 400.0),
            animatedView.widthAnchor.constraint(equalToConstant: 400.0)
        ])
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GIFView>) {
        
    }
    
}


