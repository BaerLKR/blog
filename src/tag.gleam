import blogatto/post.{type Post}
import gleam/list
import gleam/option
import lib
import lustre/attribute
import lustre/element/html

// import lib.{get_title_img}
import gleam/time/timestamp
import lustre/element.{type Element}
import partials.{head, nav, post_card}

pub fn to_str(tag: Tags) -> String {
  case tag {
    Haskell -> "haskell"
    Git -> "git"
    Programming -> "programming"
    Nix -> "nix"
  }
}

pub type Tags {
  Haskell
  Git
  Programming
  Nix
}

pub fn tag(name: String) -> fn(List(Post(Nil))) -> Element(Nil) {
  fn(posts: List(Post(Nil))) {
    let sorted =
      list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })
      |> list.filter(fn(p) { lib.post_has_tag(p, name) })

    html.html([], [
      head(name <> "tag", "content tagged with " <> name),
      html.body([], [
        html.main([], [
          html.img([
            attribute.src("/" <> name <> ".svg"),
            attribute.class("site-title"),
          ]),
          html.ul(
            [
              attribute.style("list-style", "none"),
              attribute.class("post-list"),
            ],
            list.map(sorted, fn(p) {
              post_card(p)
              // html.li([], [
              // html.a([attribute.href("/blog/" <> p.slug)], [
              // element.text(p.title),
              // ]),
              // ])
            }),
          ),
        ]),
        nav(option.None),
      ]),
    ])
  }
}
// pub fn git_tag(posts: List(Post(Nil))) -> Element(Nil) {
//   let sorted = list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })
//
//   html.html([], [
//     head("Lovis' Blog Archive", "my thoughts, startpage"),
//     html.body([], [
//       html.main([], [
//         html.img([attribute.src("/archive.svg"), attribute.class("site-title")]),
//         html.ul(
//           [attribute.style("list-style", "none"), attribute.class("post-list")],
//           list.map(sorted, fn(p) {
//             post_card(p)
//             // html.li([], [
//             // html.a([attribute.href("/blog/" <> p.slug)], [
//             // element.text(p.title),
//             // ]),
//             // ])
//           }),
//         ),
//       ]),
//       nav(),
//     ]),
//   ])
// }
