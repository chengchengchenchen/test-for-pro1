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

let albums = [
    Album(name:"Mojito", singer: "Jay Chou", text:"Mojito", describe:"best for you", time: 190),
    Album(name:"Perfect", singer: "Ed Sheeran", text:"divide", describe:"best for you", time: 263),
    Album(name:"In the End", singer: "Linkin Park", text:"in the end", describe:"best for you", time: 216),
    Album(name:"Numb", singer: "Linkin Park", text:"last in the fire", describe:"best for you", time: 186),
    Album(name:"Style", singer: "Taylor Swift", text:"Taylor", describe:"best for you", time: 231),
    Album(name:"Rise", singer: "The Glitched Mob", text:"for S8 IG", describe:"best for you", time: 192),
    Album(name:"Ignite", singer: "Alan Walker", text:"League of Legends", describe:"best for you", time: 210),
    Album(name:"The original high", singer: "Adam", text:"chasing the sun", describe:"best for you", time: 216)
]
let lightShadowColor = UIColor(red: 0.720, green: 0.751,blue: 0.802, alpha: 1.0)
let darkShadowColor = UIColor(red: 1.000, green: 1.000,blue: 1.000, alpha: 1.0)

struct ContentView: View {
    @State var progress:CGFloat=0.01
    @State var isPlayed = false
    @State var index=0
    @State private var showModal = false
    
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
                .fullScreenCover(isPresented: $showModal){
                    FullScreenView.init(progress:$progress,isPlayed: $isPlayed, index: $index,time:albums[index].time)
                    }
                .overlay(
                    VStack() {
                        Divider()
                        HStack {
                            Button(action: {
                                showModal.toggle()
                            }){
                                Image(albums[index].name)
                                    .resizable()
                                    .frame(width:40,height: 40)
                                Text(albums[index].name)
                            }.foregroundColor(.black)
                            
                            Spacer()
                            Button(action: {
                                withAnimation(.linear){
                                    isPlayed.toggle()
                            }}){
                                if(isPlayed){
                                    Image(systemName: "pause.fill")
                                        .resizable()
                                        .frame(width:25,height: 25)
                                }else{
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width:25,height: 25)
                                        
                                }
                            }.foregroundColor(.black)
                                .padding(.horizontal)
                            
                            Button(action: {
                                withAnimation(.easeIn){
                                    index=(index+1)%8
                                }
                            }){
                                Image(systemName: "forward.fill")
                                    .resizable()
                                    .frame(width:25,height: 18)
                            }.foregroundColor(.black)
                            
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
struct FullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var progress: CGFloat
    @Binding var isPlayed:Bool
    @Binding var index:Int
    @State var time:Int
    
    var frame: Double {
        isPlayed ? 340 : 300
    }
    var body: some View {
        ZStack{
            Image(albums[index].name)
                .resizable()
                .blur(radius: 10)
                .frame(width: 900,height: 900)
            VStack{
                Spacer().frame(height:40)
                HStack{
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundColor(.gray)
                            
                    }.padding([.top, .leading], 6.0)
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                Image(albums[index].name)
                    .resizable()
                    .frame(width: frame,height: frame)
                    .cornerRadius(10.0)
                    .shadow(color: Color(uiColor: lightShadowColor),
                            radius: 1, x: 3, y: 3)
                    .shadow(color: Color(uiColor: darkShadowColor),
                            radius: 1, x: -3, y: -3)
                
                HStack{
                    VStack(alignment: .leading){
                        Text(albums[index].name)
                            .font(.system(size:35))
                            .foregroundColor(.white)
                        Text(albums[index].singer)
                            .font(.system(size:25))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color(uiColor: .systemGray6))
                        .frame(width:UIScreen.main.bounds.width*0.9,height: 10)
                    Rectangle()
                        .foregroundColor(Color(uiColor: .systemGray4))
                        .frame(width: progress * UIScreen.main.bounds.width*0.9, height: 10)
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.progress = min(max(value.location.x / UIScreen.main.bounds.width/0.9, 0), 1)
                            }
                        )
                }
                //.padding()
                .frame(width: UIScreen.main.bounds.width*0.9)
                HStack{
                    Text(String(format:"%01d",Int(Double(time)*progress)/60)+":"+String(format:"%02d",Int(Double(time)*progress)%60))
                        .foregroundColor(Color.init(uiColor: .systemGray6))
                    Spacer()
                    
                    Text("-"+String(format:"%01d",Int(Double(time)*(1-progress))/60)+":"+String(format:"%02d",Int(Double(time)*(1-progress))%60))
                        .foregroundColor(Color.init(uiColor: .systemGray6))
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn){
                            index=(index+7)%8
                            time = albums[index].time
                            progress=0.01
                        }
                    }){
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width:25,height: 18)
                    }.foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()){
                            isPlayed.toggle()
                    }}){
                        if(isPlayed){
                            Image(systemName: "pause.fill")
                                .resizable()
                                .frame(width:25,height: 25)
                        }else{
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width:25,height: 25)
                                
                        }
                    }.foregroundColor(.white)
                        .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn){
                            index=(index+1)%8
                            time = albums[index].time
                            progress=0.01
                        }
                    }){
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width:25,height: 18)
                    }.foregroundColor(.white)
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width)
                Spacer()
            }
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
                    .cornerRadius(15.0)
                
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
                ForEach(0 ... 3, id: \.self) { index in
                    Spacer()
                    HStack{
                        Spacer()
                        pCard(album: albums[index*2],mul:1.0)
                        Spacer()
                        pCard(album: albums[index*2+1],mul:1.0)
                        Spacer()
                    }
                }
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
        ScrollView(showsIndicators: false){
            VStack(alignment: .center){
                Spacer()
                Image(album.name)
                    .resizable()
                    .frame(width:250,height: 250)
                    .cornerRadius(30.0)
                    .shadow(color: Color(uiColor: lightShadowColor),
                            radius: 3, x: 3, y: 3)
                    .shadow(color: Color(uiColor: darkShadowColor),
                            radius: 3, x: -3, y: -3)
                Text(album.name)
                    .font(.system(size:30))
                    .fontWeight(.medium)
                    
                Text(album.singer)
                    .font(.system(size:25))
                    .fontWeight(.light)
                    .foregroundColor(.red)
                
                Text("流行 · 2023 · 无损")
                    .font(.system(size:12))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                
                HStack{
                    HStack{
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width:20,height: 20)
                        Text("播放")
                    }.foregroundColor(.red)
                        .frame(width:160,height:50)
                        .background(Color.init(uiColor: .systemGray6))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 6.0)
                    HStack{
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width:20,height: 20)
                        Text("随机播放")
                    }.foregroundColor(.red)
                        .frame(width:160,height:50)
                        .background(Color.init(uiColor: .systemGray6))
                        .cornerRadius(10.0)
                        .padding(.horizontal, 6.0)
                }
                Spacer()
                Group{
                    ForEach(0 ... 7, id: \.self) { index in
                        Divider()
                            .padding(.horizontal)
                        HStack{
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15,height: 15)
                                .foregroundColor(.gray)
                                .padding(.leading, 2.0)
                            Text("\(index+1)")
                                .foregroundColor(.gray)
                            Text(albums[index].name)
                                .padding(.leading)
                            Spacer()
                            Image(systemName: "ellipsis")
                                .rotationEffect(Angle.init(degrees: 90))
                        }.padding(.vertical, 3.0)
                    }
                    Divider()
                        .padding(.horizontal)
                }
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Apple 数字母带")
                            .font(.system(size:14))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.leading, 10.0)
                            .padding(.vertical, 3.0)
                        Text("2022年12月14日")
                            .font(.system(size:14))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.leading, 10.0)
                        Text("8首歌曲，30分钟")
                            .font(.system(size:14))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.leading, 10.0)
                        Text("2022 Bin Music International Limited")
                            .font(.system(size:14))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.leading, 10.0)
                    }
                    Spacer()
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
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
                    
                    
                    Group{
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
                                ForEach(0 ... 2, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:250.0,dis:true)
                                    }
                                    Spacer()
                                }
                            }
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
                                //
                                ForEach(3 ... 5, id: \.self) { index in
                                    NavigationLink(
                                        destination:MusicView(album:albums[index])){pCard(album:albums[index])}
                                    Spacer()
                                }
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
                                //
                                ForEach(6 ... 8, id: \.self) { index in
                                    NavigationLink(
                                        destination:MusicView(album:albums[index%8])){pCard(album:albums[index%8])}
                                    Spacer()
                                }
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
        NavigationView(){
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        Text("Browse")
                            .font(.system(size:35))
                            .fontWeight(.medium)
                            .padding(.leading, 10.0)
                        Spacer()
                    }
                    
                    Group{
                        Divider()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Try now")
                        ){
                         Text("Try now >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                           
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                ForEach(2 ... 5, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:300.0,dis:true, mul: 1.0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Group{
                        Spacer()
                        Spacer()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Best choice")
                        ){
                         Text("Best choice >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                           
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                ForEach(0 ... 3, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:200.0,mul: 1.0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Group{
                        Spacer()
                        Spacer()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Great")
                        ){
                         Text("Great >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                           
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                ForEach(4 ... 7, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:200.0,mul: 1.0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}
struct radio: View{
    var body: some View{
        NavigationView(){
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        Text("Radio")
                            .font(.system(size:35))
                            .fontWeight(.medium)
                            .padding(.leading, 10.0)
                        Spacer()
                    }
                    
                    Group{
                        Divider()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Recommended")
                        ){
                         Text("Recommended >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                           
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                ForEach(2 ... 3, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:350.0,dis:true, mul: 1.0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    Group{
                        Spacer()
                        Spacer()
                        NavigationLink(
                            destination: DetailView().navigationTitle("Recent played >")
                        ){
                         Text("Recent played >")
                             .font(.system(size:22))
                             .fontWeight(.heavy)
                             .padding(.leading, 10.0)
                        }.foregroundColor(.black)
                        
                           
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                Spacer()
                                ForEach(0 ... 3, id: \.self) { index in
                                    NavigationLink(destination: MusicView(album:albums[index])){
                                        pCard(album:albums[index],wsize:200.0,mul: 1.0)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    
                }
            }
        }
        
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
