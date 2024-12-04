module hello_world;
import std::io;
import std::core::string;

fn char[] !read_file(String filename, char[] buffer) {
  File file = file::open(filename, "r") !;

  defer(void) file.close();

  file.read(buffer) !;
  return buffer;
}

struct Coord {
  usz x;
  usz y;
}

def Permut = fn Coord(Coord);

fn int check_part2(String[] lines, Coord c) {
   if (lines[c.x][c.y] != 'A') {
     return 0;
   }

   if (c.x == 0 || c.y == 0 || c.x == lines.len - 1|| c.y == lines[0].len - 1) {
     return 0;
   }

   char[] diag1 = {lines[c.x - 1][c.y + 1], lines[c.x][c.y], lines[c.x + 1][c.y - 1]};
   char[] diag2 = {lines[c.x + 1][c.y + 1], lines[c.x][c.y], lines[c.x - 1][c.y - 1]};

   if ((String) diag1 != "MAS" && (String) diag1 != "SAM") {
     return 0;
   }

   if ((String) diag2 != "MAS" && (String) diag2 != "SAM") {
     return 0;
   }

   return 1;
}

fn int count2(String[] lines) {
  int count = 0;

  foreach (ic, column : lines) {
    foreach (ir, row : column) {
      Coord c;

      c.x = ic;
      c.y = ir;
      count += check_part2(lines, c);
    }
  }

  return count;
}

fn int check(String[] lines, Coord c, Permut p) {
  char[] expected = {'X', 'M', 'A', 'S'};

  for (int i = 0; i < expected.len; ++i, c = p(c)) {
    if (c.x >= lines.len || c.y >= lines[0].len) {
       return 0;
    }

    // Idk, something wrong happened??
    if (lines[c.x].len == 0) {
      return 0;
    }

    if (lines[c.x][c.y] != expected[i]) {
      return 0;
    }
  }

  return 1;
}

fn int count(String[] lines) {
  int count = 0;

  foreach (ic, column : lines) {
    foreach (ir, row : column) {
      Coord c;

      c.x = ic;
      c.y = ir;

      Permut[] fns = {
        fn (c) {
              c.x -= 1;
              return c;
        }, // Up
        fn (c) {
              c.x += 1;
              return c;
        }, // Down
        fn (c) {
              c.y -= 1;
              return c;
        }, // Left
        fn (c) {
              c.y += 1;
              return c;
        }, // Right
        fn (c) {
              c.x -= 1;
              c.y -= 1;
              return c;
        }, // Diag up left
        fn (c) {
              c.x -= 1;
              c.y += 1;
              return c;
        }, // Diag up right
        fn (c) {
              c.x += 1;
              c.y -= 1;
              return c;
        }, // Diag down left
        fn (c) {
              c.x += 1;
              c.y += 1;
              return c;
        } // Diag down right
      };

      foreach(elem: fns) {
         count += check(lines, c, elem);
      }
    }
  }
  return count;
}

fn void !main() {
  char[] buffer = mem::new_array(char, 140 * 140 + 140);
  defer free(buffer);

  char[] !read_buffer = read_file("input", buffer);
  if (catch excuse = read_buffer) {
    return excuse ? ;
  }

  String bstr = (String)read_buffer;
  String[] lines = bstr.split("\n");

  io::printn(count2(lines[0 .. lines.len - 2]));
}
