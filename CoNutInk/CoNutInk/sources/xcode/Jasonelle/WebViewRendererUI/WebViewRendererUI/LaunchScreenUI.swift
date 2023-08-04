//
//  LaunchScreenUI.swift
//  WebViewRendererUI
//
//  Created by clsource on 16-02-23.
//  Copyright (c) 2023 Jasonelle.com
//
//  This file is part of Jasonelle Project <https://jasonelle.com>.
//  Jasonelle Project is dual licensed. You can choose between AGPLv3 or MPLv2.
//  MPLv2 is only valid if the software has a unique Jasonelle Key which was purchased in official channels.
//
//  == AGPLv3
//  Jasonelle is free software: you can redistribute it and/or modify it under the terms of the Affero GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//  Jasonelle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Affero GNU General Public License for more details.
//  You should have received a copy of the Affero GNU General Public License along with Jasonelle. If not, see <https://www.gnu.org/licenses/>.
//
//  == MPLv2 (Only valid if purchased a Jasonelle Key)
//  This Source Code Form is subject to the terms
//  of the Mozilla Public License, v. 2.0.
//  If a copy of the MPL was not distributed
//  with this file, You can obtain one at
//
//  <https://mozilla.org/MPL/2.0/>.
//

// This is a Simple Launch Screen
// That's shown when the website is loading
// You can configure it with animations, images
// or other good stuff.
// TODO: Maybe add a config in js?
// The first Launch Screen is inside the App.xcproject
// That one is loaded before this one.

/*import SwiftUI

struct LaunchScreenUI: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
    }
}

struct LaunchScreenUI_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenUI()
    }
}*/
//
//  LaunchScreenUI.swift
//  WebViewRendererUI
//
//  Created by clsource on 16-02-23.
//  Copyright (c) 2023 Jasonelle.com
//
//  This file is part of Jasonelle Project <https://jasonelle.com>.
//  Jasonelle Project is dual licensed. You can choose between AGPLv3 or MPLv2.
//  MPLv2 is only valid if the software has a unique Jasonelle Key which was purchased in official channels.
//
//  == AGPLv3
//  Jasonelle is free software: you can redistribute it and/or modify it under the terms of the Affero GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//  Jasonelle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Affero GNU General Public License for more details.
//  You should have received a copy of the Affero GNU General Public License along with Jasonelle. If not, see <https://www.gnu.org/licenses/>.
//
//  == MPLv2 (Only valid if purchased a Jasonelle Key)
//  This Source Code Form is subject to the terms
//  of the Mozilla Public License, v. 2.0.
//  If a copy of the MPL was not distributed
//  with this file, You can obtain one at
//
//  <https://mozilla.org/MPL/2.0/>.
//

// This is a Simple Launch Screen
// That's shown when the website is loading
// You can configure it with animations, images
// or other good stuff.
// TODO: Maybe add a config in js?
// The first Launch Screen is inside the App.xcproject
// That one is loaded before this one.

import SwiftUI
import UIKit

struct AnimatedGIFView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if let gifPath = Bundle.main.path(forResource: gifName, ofType: "gif") {
            if let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) {
                let image = UIImage.gifImageWithData(gifData)
                imageView.image = image
                imageView.startAnimating()
                view.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                    imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
                ])
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update your view here if needed
    }
}

extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let count = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        return UIImage.animatedImage(with: images, duration: 0.0)
    }
}

struct LaunchScreenUI: View
{
    @State private var isLoading = true
    
    var body: some View
    {
        ZStack
        {
            //Color.black.ignoresSafeArea()
           //x Color.clear
           /*ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.gray)
                    ).scaleEffect(2)*/
                    //conutinklogo
                /*Image("AppIcon.png")
                    .resizable()
                    .aspectRatio(contentMode: .fit)*/
                 Image("conutinklogo1stfraem")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                Spacer()
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.gray)
                    ).scaleEffect(2)
            
        }
    }
}
    
struct LaunchScreenUI_Previews: PreviewProvider
{
    static var previews: some View
    {
        LaunchScreenUI()
    }
}
        
