import blogatto
import blogatto/config
import blogatto/config/feed
import blogatto/config/markdown
import blogatto/config/robots
import blogatto/config/sitemap
import blogatto/error
import blogatto/post.{type Post}
import gleam/io
import gleam/list
import gleam/time/timestamp
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

const site_url = "https://blog.lovirent.eu"

pub fn config() {
  config.new(site_url)
  |> config.output_dir("./dist")
  |> config.static_dir("./static")
  |> config.markdown(md())
  |> config.route("/", home_view)
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

pub fn md() {
  markdown.default()
  |> markdown.markdown_path("./blog")
  |> markdown.route_prefix("blog")
  |> markdown.h1(fn(id, children) {
    html.h1([attribute.id(id), attribute.class("post-title")], children)
  })
}

pub fn main() {
  case blogatto.build(config()) {
    Ok(Nil) -> io.println("Site built successfully!")
    Error(err) -> io.println("Build failed: " <> error.describe_error(err))
  }
}

fn home_view(posts: List(Post(Nil))) -> Element(Nil) {
  let sorted = list.sort(posts, fn(a, b) { timestamp.compare(b.date, a.date) })

  html.html([], [
    html.head([], [html.title([], "My Blog")]),
    html.body([], [
      html.h1([], [element.text("My Blog")]),
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
    ]),
  ])
}
