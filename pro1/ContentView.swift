//
//  ContentView.swift
//  pro1
//
//  Created by qjc on 2023/3/12.
//

import SwiftUI
import UIKit

struct Album{
    var name:String
    var singer:String
    var text:String
    var describe: String
    var time:Int
}
var isMusicDetail=false
let musicIndex=0

let albums = [
    Album(name:"mojito", singer: "Jzhou", text:"mojito", describe:"best for you", time: 190),
    Album(name:"ed", singer: "", text:"divide", describe:"best for you", time: 200),
    Album(name:"hybrid theory", singer: "Jzhou", text:"in the end", describe:"best for you", time: 190),
    Album(name:"linkin park1", singer: "Jzhou", text:"last in the fire", describe:"best for you", time: 190),
    Album(name:"taylor", singer: "Jzhou", text:"taylor", describe:"best for you", time: 190),
    Album(name:"rise", singer: "Jzhou", text:"for S8 IG", describe:"best for you", time: 190),
    Album(name:"ignite", singer: "Jzhou", text:"league of legends", describe:"best for you", time: 190),
    Album(name:"adam", singer: "Jzhou", text:"chasing the sun", describe:"best for you", time: 190)
]
struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        if(isMusicDetail){
            Image("mojito")
                .resizable()
                .frame(width: 800)
                .ignoresSafeArea()
                .blur(radius: 30)
        }
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
                .overlay(
                    VStack() {
                        Divider()
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width:40,height: 40)
                            Text("Now playing")
                            Spacer()
                            Image(systemName: "forward.fill")
                        }.padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .padding(.trailing, 15)
                        
                        Divider()
                    }.background(.ultraThickMaterial)
                        .offset(y:298)
                )
        }
    }
}
struct pCard: View{
    var album:Album
    var wsize=160.0
    var dis=false
    var mul=1.3
    var body: some View{
        VStack(alignment: .leading){
            if(dis){
                Text(album.describe)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            Spacer()
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
            .frame(width: wsize,height: wsize*mul)
        }
    }
    
}
// 详情页面
struct DetailView: View {
    //环境值
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ScrollView{
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    pCard(album: albums[0],mul:1.0)
                    Spacer()
                    pCard(album: albums[1],mul:1.0)
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    pCard(album: albums[2],mul:1.0)
                    Spacer()
                    pCard(album: albums[3],mul:1.0)
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    pCard(album: albums[4],mul:1.0)
                    Spacer()
                    pCard(album: albums[5],mul:1.0)
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    pCard(album: albums[6],mul:1.0)
                    Spacer()
                    pCard(album: albums[7],mul:1.0)
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            // 点击按钮后的操作
            self.mode.wrappedValue.dismiss()
        }){
            //按钮及其样式
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
        })
    }
}


struct MusicView: View {
    var album:Album
    //环境值
    @Environment(\.presentationMode) var mode
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Spacer()
                Image(album.name)
                    .resizable()
                    .frame(width:250,height: 250)
                    .cornerRadius(10.0)
                
                Text(album.name)
                    .font(.system(size:40))
                    .fontWeight(.medium)
                    
                Text(album.singer)
                    .font(.system(size:30))
                    .fontWeight(.light)
                    .foregroundColor(.red)
                
                Text("流行 2023 无损")
                    .foregroundColor(.gray)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            // 点击按钮后的操作
            self.mode.wrappedValue.dismiss()
        }){
            //按钮及其样式
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
        })
    }
}
struct listen: View{
    var body: some View{
        NavigationView(){
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        Text("Listen Now")
                            .font(.system(size:35))
                            .fontWeight(.medium)
                            .padding(.leading, 10.0)
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45.0,height: 45.0)
                            .clipShape(Circle())
                            .padding([.bottom, .trailing])
                    }
                    
                    
                    Divider()
                    NavigationLink(
                        destination: DetailView().navigationTitle("Top picks")
                    ){
                     Text("Top picks")
                         .font(.system(size:22))
                         .fontWeight(.heavy)
                         .padding(.leading, 10.0)
                    }.foregroundColor(.black)
                    
                       
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing:5){
                            Spacer()
                            NavigationLink(destination: MusicView(album:albums[0])){
                                pCard(album:albums[0],wsize:250.0,dis:true)
                            }
                            Spacer()
                            pCard(album:albums[1],wsize:250.0)
                            Spacer()
                            pCard(album:albums[2],wsize:250.0)
                            Spacer()
                        }
                    }
                    Group{
                        Spacer()
                        Spacer()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Recent played")
                        ){
                         Text("Recent played >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                pCard(album:albums[3])
                                Spacer()
                                pCard(album:albums[4])
                                Spacer()
                                pCard(album:albums[5])
                                Spacer()
                            }
                        }
                    }
                    
                    Group{
                        Spacer()
                        Spacer()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Pop Music")
                        ){
                         Text("Pop Music")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                pCard(album:albums[6])
                                Spacer()
                                pCard(album:albums[7])
                                Spacer()
                                pCard(album:albums[2])
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        
    }
}
struct browse: View{
    var body: some View{
        Text("read")
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
