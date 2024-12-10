#include <cassert>
#include <iostream>
#include <sstream>
#include <vector>

bool procces_nums(const std::vector<unsigned long> &vec, unsigned long target,
                  unsigned long perms) {
  if (perms < (1UL << (vec.size() - 1))) {
    unsigned long sum = perms & 1 ? vec[0] * vec[1] : vec[0] + vec[1];

    for (int i = 2; i < vec.size(); ++i) {
      sum = (perms & (1 << (i - 1)) ? sum * vec[i] : sum + vec[i]);
      if (sum > target)
        break;
    }

    if (sum == target)
      return true;
  } else {
    return false;
  }

  [[clang::musttail]] return procces_nums(vec, target, perms + 1);
}

static unsigned long op(unsigned long lhs, unsigned long rhs, int mask) {
  std::stringstream oss;
  unsigned long res;

  switch (mask) {
  case 0:
    return lhs + rhs;
  case 1:
    return lhs * rhs;
  case 2:
    oss << lhs << rhs;
    oss >> res;
    return res;
  case 3:
    return -1;
  }

  __builtin_unreachable();
}

bool procces_nums_two(const std::vector<unsigned long> &vec,
                      unsigned long target, unsigned long perms_orig) {
  unsigned long perms = perms_orig;

  if (perms < (1UL << ((vec.size() - 1) * 2))) {
    unsigned long sum = op(vec[0], vec[1], perms & 3);

    perms >>= 2;

    for (int i = 2; i < vec.size() && sum < target; ++i, perms >>= 2) {
      sum = op(sum, vec[i], perms & 3);
    }

    if (sum == target)
      return true;
  } else {
    return false;
  }

  [[clang::musttail]] return procces_nums_two(vec, target, perms_orig + 1);
}

int main(void) {
  std::string line;
  unsigned long answer = 0;

  while (std::getline(std::cin, line)) {
    std::istringstream iss(line);
    char c;
    unsigned long result, number;
    std::vector<unsigned long> nums{};

    assert(iss >> result >> c);

    while (iss >> number)
      nums.push_back(number);

    if (procces_nums_two(nums, result, 0))
      answer += result;
  }

  std::println("{}", answer);
}
