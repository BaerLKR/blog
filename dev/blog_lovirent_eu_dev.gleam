import blog_lovirent_eu
import blogatto/dev
import blogatto/error
import gleam/io

pub fn main() {
  let cfg = blog_lovirent_eu.config()

  case
    cfg
    |> dev.new()
    |> dev.build_command("gleam run")
    |> dev.port(3000)
    |> dev.start()
  {
    Ok(Nil) -> io.println("Dev server stopped.")
    Error(err) -> io.println("Dev server error: " <> error.describe_error(err))
  }
}
