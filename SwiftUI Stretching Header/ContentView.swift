//
//  ContentView.swift
//  SwiftUI Stretching Header
//
//  Created by Brett Chapin on 7/8/20.
//

import SwiftUI

struct StretchingHeader<Content: View> : View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(content: content)
                .frame(width: geo.size.width, height: height(for: geo))
                .offset(y: offset(for: geo))
        }
    }
    
    func height(for proxy: GeometryProxy) -> CGFloat {
        let y = proxy.frame(in: .global).minY
        return proxy.size.height + max(0, y)
    }
    
    func offset(for proxy: GeometryProxy) -> CGFloat {
        let y = proxy.frame(in: .global).minY
        return min(0, -y)
    }
}

struct ContentView: View {
    var body: some View {
//        ScrollView {
//            VStack {
//                StretchingHeader {
//                    Image("Wide Landscape")
//                        .resizable()
//                        .scaledToFill()
//                }
//                .frame(height: 200)
//            }
//
//            Text("Hello World!")
//        }
//        .edgesIgnoringSafeArea(.all)
        
        List {
            Section(header:
                        StretchingHeader {
                            Image("Wide Landscape")
                                .resizable()
                                .scaledToFill()
                            
                            Text("Stretching Header Tutorial")
                                .font(.headline)
                            Text("From Paul Hudson")
                                .font(.caption)
                        }
                        .frame(height: 200)
            ) {
                ForEach(0..<20) { i in
                    Text("Row \(i + 1)")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
