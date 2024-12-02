use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();

    let mut left = Vec::with_capacity(1000);
    let mut right = Vec::with_capacity(1000);

    for line in stdin.lock().lines() {
        let line = line.unwrap();
        let mut iter = line.split_whitespace();

        let num1 = iter.next().unwrap().parse::<i64>().unwrap();
        let num2 = iter.next().unwrap().parse::<i64>().unwrap();

        assert!(iter.next().is_none());

        left.push(num1);
        right.push(num2);
    }

    left.sort();
    right.sort();

    let res = std::iter::zip(left, right).fold(0, |mut x, (l, r)| {
        x += (l - r).abs();
        x
    });

    println!("{res}");
}
