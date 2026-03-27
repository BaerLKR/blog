import blogatto/post.{type Post}
import gleam/result
import gleam/dict
import gleam/string
import gleam/order

pub fn post_is_in_archive(p: Post(Nil)) -> Bool {
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
