//
//  SerchView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var postStore: PostStore
    @State private var cardScale: Bool = true
    @State private var cardScale1: Bool = true
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State private var searchText: String = "오운완"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // MARK: - 뷰가 위로 넘어가는 것을 방지하기 위한 rectangle
                    Rectangle()
                        .fill(Color.backgroundColor)
                        .frame(height: 1)
                    
                    ScrollView(showsIndicators: false, content: {
                        // MARK: - 검색창
                        VStack {
                            VStack {
                                Label {
                                    TextField("Search...", text: $searchText)
                                } icon : {
                                    Image(systemName: "magnifyingglass")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .padding(.leading, 5)
                                }
                                .frame(width: 345, height: 40)
                                .background(.gray)
                                .opacity(0.3)
                                .cornerRadius(10)
                            }
                        }
                        // MARK: - 카테고리
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Image("searchCategory1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                
                                Image("searchCategory2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                
                                Image("searchCategory3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                
                                Image("searchCategory4")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        Divider()
 
                        // TODO: - 추후 피드들 넣을 스크롤뷰, 현재 카드형태로 넣을 예정
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(postStore.posts) { post in
                                SearchCardView(post: post)
                            }
                        }
                    })
                }
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear {
            postStore.fetchPosts()
        }
        .refreshable {
            postStore.fetchPosts()
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(PostStore())
    }
}
