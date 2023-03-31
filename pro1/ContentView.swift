//
//  ContentView.swift
//  pro1
//
//  Created by qjc on 2023/3/12.
//

import SwiftUI

struct Album{
    var name:String
    var singer:String
    var text:String
    var describe: String
    var time:Int
}
let albums = [
    Album(name:"mojito", singer: "Jzhou", text:"test", describe:"best for you", time: 190),
    Album(name:"ed", singer: "", text:"test", describe:"best for you", time: 200),
    Album(name:"hybrid theory", singer: "Jzhou", text:"test", describe:"best for you", time: 190),
    Album(name:"linkin park1", singer: "Jzhou", text:"test", describe:"best for you", time: 190),
    Album(name:"taylor", singer: "Jzhou", text:"test", describe:"best for you", time: 190),
    Album(name:"rise", singer: "Jzhou", text:"test", describe:"best for you", time: 190),
    Album(name:"ignite", singer: "Jzhou", text:"test", describe:"best for you", time: 190)
]
struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom){
            TabView{
                listen()
                    .tabItem({
                        Group{
                            Text("listen now")
                            Image(systemName: "arrowtriangle.right.circle")
                        }
                    })
                browse()
                    .tabItem({
                        Group{
                            Text("browse")
                            Image(systemName: "square.split.2x2.fill")
                        }
                    })
                radio()
                    .tabItem({
                        Group{
                            Text("radio")
                            Image(systemName: "dot.radiowaves.left.and.right")
                        }
                    })
                library()
                    .tabItem({
                        Group{
                            Text("library")
                            Image(systemName: "play.square.stack.fill")
                        }
                    })
                search()
                    .tabItem({
                        Group{
                            Text("search")
                            Image(systemName: "magnifyingglass")
                        }
                    })
            }.accentColor(.red)
            
            VStack{
                Divider()
                HStack {
                    Image(systemName: "play.circle.fill")
                    Text("Now playing")
                    Spacer()
                    Image(systemName: "forward.fill")
                }
                Divider()
            }.background(Rectangle()
                .fill(Color.white)
                .frame(height: 20))
            .offset(y:-60)
        }
    }
}
struct pCard: View{
    var album:Album
    var wsize=200.0
    var body: some View{
        VStack(alignment: .leading){
            Text(album.describe)
                .font(.body)
                .foregroundColor(.gray)
            
            ZStack(alignment:.bottom){
                Image(album.name)
                    .resizable()
                    .cornerRadius(10.0)
                
                Text(album.text)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.all, 7.0)
                    .frame(width:wsize)
                    .background(.ultraThinMaterial.opacity(0.9))
                    .cornerRadius(10.0)
            }
            .frame(width: wsize,height: wsize*1.5)
        }
    }
    
}

struct listen: View{
    var body: some View{
        ScrollView{
            VStack(alignment:.leading, spacing: 0){
                Text("Listen Now")
                    .font(.largeTitle)
                    .padding(.leading, 20.0)
                
                Divider()
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:5){
                        Spacer()
                        pCard(album:albums[0])
                        Spacer()
                        pCard(album:albums[1])
                        Spacer()
                        pCard(album:albums[2])
                        Spacer()
                    }
                }
            }
        }
    }
}
struct browse: View{
    var body: some View{
        Text("read")
        Text("git")
    }
}
struct radio: View{
    var body: some View{
        Text("go")
    }
}
struct library: View{
    var body: some View{
        Text("go")
    }
}
struct search: View{
    var body: some View{
        Text("go")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
