import blogatto/post.{type Post}
import gleam/dict
import gleam/io
import gleam/list
import gleam/order
import gleam/result
import gleam/string

pub fn post_has_tag(p: Post(Nil), tag: String) -> Bool {
  case p.extras |> dict.get("tags") {
    Ok(val) -> {
      string.contains(val, tag)
    }
    Error(_) -> False
  }
}

pub fn get_tags(p: Post(Nil)) -> List(String) {
  p.extras
  |> dict.get("tags")
  |> result.try(fn(ts) {
    Ok(string.split(ts, on: ",") |> list.map(fn(s) { string.trim(s) }))
  })
  |> result.unwrap([])
}

pub fn post_is_not_archived(p: Post(Nil)) -> Bool {
  case p.extras |> dict.get("archive") {
    Ok(val) ->
      case string.compare(val, "true") {
        order.Eq -> False
        _ -> True
      }
    Error(_) -> True
  }
}

pub fn get_title_img(p: Post(Nil)) -> String {
  p.extras |> dict.get("title-image") |> result.unwrap("/:3.png")
}
