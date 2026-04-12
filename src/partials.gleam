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

pub fn head(title: String, descr: String) -> Element(Nil) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1"),
    ]),
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
          attribute.alt(name),
          attribute.src(path),
          attribute.class("nav-item"),
        ]),
      ]),
    ])
  }
  let tag_items = {
    let all = [
      html.hr([]),
      tag_link("programming", "/tag/programming.svg"),
      tag_link("linux", "/tag/linux.svg"),
      tag_link("rust", "/tag/rust.svg"),
      tag_link("git", "/tag/git.svg"),
      tag_link("nix", "/tag/nix.svg"),
      tag_link("haskell", "/tag/haskell.svg"),
      tag_link("erlang", "/tag/erlang.svg"),
    ]
    case tags {
      option.Some(ts) ->
        [
          html.hr([]),
        ]
        |> list.append(
          list.map(ts, fn(t) { tag_link(t, "/tag/" <> t <> ".svg") }),
        )
      option.None -> all
    }
  }
  html.nav([], [
    html.menu(
      [],
      [
        html.li([], [
          html.a([attribute.href("/")], [
            html.img([
              attribute.src("/home.svg"),
              attribute.class("nav-item"),
              attribute.alt("home"),
            ]),
          ]),
        ]),
        html.li([], [
          html.a([attribute.href("/archive")], [
            html.img([
              attribute.src("/archive_small.svg"),
              attribute.class("nav-item"),
              attribute.alt("archive"),
            ]),
          ]),
        ]),
      ]
        |> list.append(tag_items),
    ),
  ])
}

pub fn footer() -> Element(Nil) {
  html.footer([], [
    html.a([attribute.href("https://lovirent.eu")], [
      html.img([attribute.src("https://lovirent.eu/88x31.gif")]),
    ]),
    html.a([attribute.href("https://eupl.eu/1.2/en/")], [html.text("EUPLv1.2")]),
  ])
}

pub fn post_card(post: Post(Nil)) -> Element(Nil) {
  // let image: String =
  // post.extras |> dict.get("image") |> result.unwrap("/favicon.ico")
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
