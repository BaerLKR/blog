import blogatto/post.{type Post}
import gleam/dict
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import gleam/time/calendar
import gleam/time/timestamp
import lib.{get_title_img}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn head(descr: String, title: String) -> Element(Nil) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
    html.link([attribute.rel("icon"), attribute.href("/favicon.ico")]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1"),
    ]),
    html.title([], title),
    html.meta([
      attribute.name("description"),
      attribute.content(descr),
    ]),
  ])
}

pub fn nav(tags: option.Option(List(String))) -> Element(Nil) {
  let tag_link = fn(name, path) {
    html.li([], [
      html.a([attribute.href("/tag/" <> name)], [
        html.img([
          attribute.src(path),
          attribute.class("nav-item"),
        ]),
      ]),
    ])
  }
  let tag_items = {
    let all = [
      html.hr([
        attribute.style("width", "100%"),
        attribute.style("color", "var(--dark)"),
      ]),
      tag_link("programming", "/programming.svg"),
      tag_link("git", "/git.svg"),
      tag_link("nix", "/nix.svg"),
      tag_link("haskell", "/haskell.svg"),
      tag_link("erlang", "/erlang.svg"),
    ]
    case tags {
      option.Some(ts) ->
        [
          html.hr([
            attribute.style("width", "100%"),
            attribute.style("color", "var(--dark)"),
          ]),
        ]
        |> list.append(list.map(ts, fn(t) { tag_link(t, "/" <> t <> ".svg") }))
      option.None -> all
    }
  }
  html.nav([], [
    html.menu(
      [],
      [
        html.li([], [
          html.a([attribute.href("/")], [
            html.img([attribute.src("/home.svg"), attribute.class("nav-item")]),
          ]),
        ]),
        html.li([], [
          html.a([attribute.href("/archive")], [
            html.img([
              attribute.src("/archive_small.svg"),
              attribute.class("nav-item"),
            ]),
          ]),
        ]),
      ]
        |> list.append(tag_items),
    ),
  ])
}

pub fn footer() -> Element(Nil) {
  todo
}

pub fn post_card(post: Post(Nil)) -> Element(Nil) {
  let image: String =
    post.extras |> dict.get("image") |> result.unwrap("/favicon.ico")
  html.li([], [
    html.a(
      [
        attribute.href("/blog/" <> post.slug),
        attribute.style("text-decoration", "none"),
      ],
      [
        html.div([attribute.class("post-card")], [
          // html.img([attribute.src(image), attribute.class("preview-image")]),
          html.img([
            attribute.src(get_title_img(post)),
            attribute.class("title-image"),
            attribute.alt(post.title),
          ]),
          html.span([attribute.class("timestamp")], [
            html.text(
              post.date
              |> timestamp.to_rfc3339(calendar.utc_offset)
              |> string.drop_end(10),
            ),
          ]),
        ]),
      ],
    ),
  ])
}
