import blogatto
import blogatto/config
import blogatto/config/feed
import blogatto/config/markdown
import blogatto/config/markdown/code
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/error
import blogatto/post.{type Post}
import gleam/dict
import gleam/io
import gleam/list
import gleam/option
import gleam/order
import gleam/result
import gleam/string
import gleam/time/calendar
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import smalto/lustre/themes

const site_url = "https://blog.lovirent.eu"

pub fn config() {
  config.new(site_url)
  |> config.output_dir("./dist")
  |> config.static_dir("./static")
  |> config.markdown(md())
  |> config.route("/", home_view)
  |> config.route("/archive", archive)
  |> config.feed(rss())
  |> config.sitemap(sitemap.new("/sitemap.xml"))
  |> config.robots(
    robots.RobotsConfig(sitemap_url: site_url <> "/sitemap.xml", robots: [
      robots.Robot(
        user_agent: "*",
        allowed_routes: ["/"],
        disallowed_routes: [],
      ),
    ]),
  )
}

pub fn rss() {
  feed.new("Lovis' Blog", site_url, "my thoughts")
  |> feed.language("en-us")
  |> feed.generator("Blogatto")
}

fn head(descr: String, title: String) -> Element(Nil) {
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

fn blog_post_template(p: Post(Nil), _all_posts: List(Post(Nil))) -> Element(Nil) {
  let lang = option.unwrap(p.language, "en")

  html.html([attribute.lang(lang)], [
    head(p.title, p.description),
    html.body([], [
      html.header([], [
        html.nav([], [
          html.a([attribute.href("/")], [element.text("← Home")]),
        ]),
      ]),
      html.main([], [
        html.article([], [
          html.h1([], [element.text(p.title)]),
          html.p([], [html.em([], [element.text(p.description)])]),
          html.div([], p.contents),
        ]),
      ]),
    ]),
  ])
}

pub fn md() {
  let syntax_config =
    code.default()
    |> code.smalto_config(themes.dracula())

  markdown.default()
  |> markdown.markdown_path("./blog")
  |> markdown.route_prefix("blog")
  |> markdown.template(blog_post_template)
  |> markdown.syntax_highlighting(syntax_config)
  |> markdown.pre(fn(children) {
    html.pre([attribute.class("code-block")], children)
  })
  |> markdown.code(fn(language, children) {
    let lang_class = case language {
      option.Some(lang) -> "language-" <> lang
      option.None -> ""
    }
    html.code([attribute.class(lang_class)], children)
  })
}

pub fn main() {
  case blogatto.build(config()) {
    Ok(Nil) -> io.println("Site built successfully!")
    Error(err) -> io.println("Build failed: " <> error.describe_error(err))
  }
}

fn home_view(posts: List(Post(Nil))) -> Element(Nil) {
  let sorted =
    list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })
    |> list.filter(fn(p) { post_is_in_archive(p) })

  html.html([], [
    head("Lovis' Blog", "my thoughts, startpage"),
    html.body([], [
      html.hr([]),
      html.main([attribute.class("container")], [
        html.div([attribute.class("row")], [
          html.h3([attribute.class("offset-4 col-2")], [
            html.text("Lovis' Blog"),
          ]),
        ]),
        html.div([attribute.class("row")], []),
        html.ul(
          [],
          list.map(sorted, fn(p) {
            html.li([], [
              html.a([attribute.href("/blog/" <> p.slug)], [
                element.text(p.title),
              ]),
            ])
          }),
        ),
        html.ul([attribute.style("list-style", "none")], [
          html.li([], [
            html.a(
              [attribute.href("/archive"), attribute.class("archive-card")],
              [
                html.text("archive"),
              ],
            ),
          ]),
        ]),
      ]),
    ]),
  ])
}

fn post_is_in_archive(p: Post(Nil)) -> Bool {
  case p.extras |> dict.get("archive") {
    Ok(val) ->
      case string.compare(val, "true") {
        order.Eq -> False
        _ -> True
      }
    Error(_) -> True
  }
}

fn post_card(post: Post(Nil)) -> Element(Nil) {
  let title_image: String =
    post.extras |> dict.get("title-image") |> result.unwrap("/:3.png")
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
          html.img([attribute.src(title_image), attribute.class("title-image")]),
          html.img([attribute.src(image), attribute.class("preview-image")]),
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

fn nav() -> Element(Nil) {
  html.nav([], [
    html.menu([], [
      html.li([], [html.text("ee")]),
      html.li([], [html.text("ee")]),
    ]),
  ])
}

fn archive(posts: List(Post(Nil))) -> Element(Nil) {
  let sorted =
    list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })
    |> list.filter(fn(p) { !post_is_in_archive(p) })

  html.html([], [
    head("Lovis' Blog Archive", "my thoughts, startpage"),
    html.body([], [
      nav(),
      html.main([], [
        html.h1([], [element.text("Lovis' Blog Archive")]),
        html.ul(
          [attribute.style("list-style", "none"), attribute.class("post-list")],
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
    ]),
  ])
}
