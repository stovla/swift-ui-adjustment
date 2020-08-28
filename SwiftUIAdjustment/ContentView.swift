//
//  ContentView.swift
//  SwiftUIAdjustment
//
//  Created by Vlastimir on 26/08/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    // change different views
                    destination: ExpandingRowsView(),
                    label: {
                        Text("Navigate to Detail")
                    })
                
            }.navigationBarTitle("Navigation SwiftUI")
        }
    }
}

struct DetailView: View {
    var body: some View {
        Rectangle().fill(Color(.blue))
            .navigationBarTitle("Detail View")
    }
}

// UITableView
struct SomeKindOfListView: View {
    var body: some View {
        List([1, 2, 3, 4], id: \.self) { number in
            Text("\(number)")
        }
    }
}

struct VStackHStack: View {
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Rectangle().fill(Color.red)
                Rectangle().fill(Color.green)
                Rectangle().fill(Color.blue)
            }
            HStack(spacing: 0) {
                Rectangle().fill(Color.red)
                Rectangle().fill(Color.green)
                Rectangle().fill(Color.blue)
            }
        }
    }
}

// table view cell for twitter
struct TweetListView: View {
    let tweetListViewModel = TweetListViewModel()
    var body: some View {
        NavigationView {
            List(tweetListViewModel.tweetViewModels, id: \.self) {
                TweetView(tweetViewModel: $0)
            }.navigationBarTitle("Twitter")
        }
    }
}

struct TweetView: View {
    let tweetViewModel: TweetViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(tweetViewModel.name)
                Text(tweetViewModel.username)
                Text(tweetViewModel.timeSince)
            }
            Text(tweetViewModel.tweet)
            HStack {
                ForEach(tweetViewModel.footerIconViewModels, id: \.self) {
                    FooterIconView(footerIconViewModel: $0)
                }
            }
        }.padding(15)
    }
}

struct FooterIconView: View {
    let footerIconViewModel: FooterIconViewModel
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: footerIconViewModel.imageName)
                if footerIconViewModel.countText != nil {
                    Text(footerIconViewModel.countText!)
                }
            }
        }.foregroundColor(.black)
        .frame(maxWidth: .infinity)
    }
}

class TweetListViewModel {
    let tweetViewModels: [TweetViewModel] = [
        .init(name: "Vlastimir Radojevic", username: "@vlasti27", timeSince: "8h", tweet: "This is a tweet to show how quickly we can build a ui in swiftui. This is a tweet to show how quickly we can build a ui in swiftui. This is some random text", footerIconViewModels: [
            .init(imageName: "buble.left", countText: "123"),
            .init(imageName: "arrow.clockwise", countText: "123"),
            .init(imageName: "heart", countText: "12"),
            .init(imageName: "square.and.arrow.up", countText: nil)
        ])
    ]
}

struct TweetViewModel: Hashable {
    let name: String
    let username: String
    let timeSince: String
    let tweet: String
    let footerIconViewModels: [FooterIconViewModel]
}

struct FooterIconViewModel: Hashable {
    let imageName: String
    let countText: String?
}

// Expanding Rows
struct TutorialItem: Identifiable {
    let id = UUID()
    let title: String
    var tutorialItems: [TutorialItem]? // needs to be the same type as the parent struct
}

struct ExpandingRowsView: View {
    let tutorialItems: [TutorialItem] = [sampleUIKiet(), sampleSwiftUI()]
    var body: some View {
        List(tutorialItems, children: \.tutorialItems) { tutorial in
            Text(tutorial.title)
        }
    }
}

func sampleUIKiet() -> TutorialItem {
    return .init(title: "UIKit", tutorialItems: [.init(title: "UICollectionView"),
                                                 .init(title: "UIScrollView")])
}

func sampleSwiftUI() -> TutorialItem {
    return .init(title: "SwiftUI", tutorialItems: [.init(title: "NavigationView"),.init(title: "ExpandingRows")])
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
