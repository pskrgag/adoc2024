all: day1 day2

day1:
	rustc day1.rs

day2:
	zig run day2.zig
