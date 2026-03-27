import blogatto
import partials.{nav, head, post_card}
import lib.{post_is_in_archive, get_title_img}
import blogatto/config
import blogatto/config/feed
import blogatto/config/markdown
import blogatto/config/markdown/code
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/error
import blogatto/post.{type Post}
import gleam/io
import gleam/list
import gleam/option
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import smalto/lustre/themes

// TODO: Tags

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

fn blog_post_template(p: Post(Nil), _all_posts: List(Post(Nil))) -> Element(Nil) {
  let lang = option.unwrap(p.language, "en")

  html.html([attribute.lang(lang)], [
    head(p.title, p.description),
    html.body([], [
      html.main([], [
        html.div([attribute.style("text-align", "center")], [
          html.img([
            attribute.src(get_title_img(p)),
            attribute.style("height", "5em"),
            attribute.style("padding", "1em"),
          ]),
        ]),
        html.article([], [
          html.p([attribute.style("text-align", "center")], [
            html.em([], [element.text(p.description)]),
          ]),
          html.div([], p.contents),
        ]),
      ]),
      nav(),
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
      html.main([attribute.class("container")], [
        html.div([attribute.class("row")], [
          html.img([
            attribute.src("/lovis_blog.svg"),
            attribute.class("site-title"),
          ]),
        ]),
        html.div([attribute.class("row")], []),
        html.ul(
          [attribute.style("list-style", "none"), attribute.class("post-list")],
          list.map(sorted, fn(p) {
            post_card(p)
            // html.li([], [
            //   html.a([attribute.href("/blog/" <> p.slug)], [
            //     element.text(p.title),
            //   ]),
            // ])
          }),
        ),
      ]),
      nav(),
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
      html.main([], [
        html.img([attribute.src("/archive.svg"), attribute.class("site-title")]),
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
      nav(),
    ]),
  ])
}
