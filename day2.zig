const std = @import("std");

fn abs(a: i32) i32 {
    if (a < 0) {
        return -a;
    } else {
        return a;
    }
}

pub fn main() !void {
    var stdin = std.io.getStdIn().reader();
    var buf: [1000]u8 = undefined;
    var safe: i32 = 0;

    outer: while (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, " ");
        var vec = [_]i32{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        var cnt: usize = 0;

        while (it.next()) |x| {
            const int = try std.fmt.parseInt(i32, x, 10);
            vec[cnt] = int;
            cnt += 1;
        }

        var inc = vec[1] > vec[0];
        var prev = vec[0];

        for (vec[1..cnt]) |val| {
            const diff = abs(val - prev);

            if ((val > prev) != inc) {
                continue :outer;
            }

            if (diff < 1 or diff > 3) {
                continue :outer;
            }

            prev = val;
        }

        safe += 1;
    }

    std.debug.print("safe - {d}\n", .{safe});
}
