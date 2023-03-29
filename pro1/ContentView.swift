//
//  ContentView.swift
//  pro1
//
//  Created by qjc on 2023/3/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
