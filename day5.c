#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(x[0]))

struct tree_order {
	int less[30];
	int less_size;
	int val;
};

static struct tree_order val_to_root[100];

static void add_less(int less, int gt)
{
	struct tree_order *cur = &val_to_root[less];

	assert(cur->less_size < ARRAY_SIZE(cur->less));

	cur->less[cur->less_size++] = gt;
}

static int small_atoi(const char *ptr)
{
	int val;

	val = (ptr[0] - '0') * 10;
	val += ptr[1] - '0';

	return val;
}

static void build_order(void)
{
	ssize_t res;
	char *line = NULL;
	size_t line_size;

	while ((res = getline(&line, &line_size, stdin) >= 0) &&
	       line[0] != '\n') {
		int less = small_atoi(line);
		int greater = small_atoi(line + 3);
		assert(line[2] == '|');

		add_less(less, greater);
	}

	free(line);
}

static int is_less_than(int from, int target)
{
	for (size_t i = 0; i < val_to_root[from].less_size; ++i) {
		if (val_to_root[from].less[i] == target)
			return 1;
	}

	return 0;
}

static int proccess_order(int skip)
{
	ssize_t res;
	char *line = NULL;
	size_t line_size;
	int sum = 0;

skip_line:
	while (getline(&line, &line_size, stdin) >= 0) {
		size_t len = strlen(line);
		int arr[100] = {};
		size_t arr_len = 0;
		int consider_line = skip;

		for (size_t i = 0; i < len; i += 3) {
			size_t idx = arr_len++;

			arr[idx] = small_atoi(line + i);
			assert(arr[idx] < 100 && arr[idx] > 10);
		}

		for (size_t i = 0; i < arr_len - 1; i++) {
			if (!is_less_than(arr[i], arr[i + 1])) {
				int tmp;

				if (skip)
					goto skip_line;

				consider_line = 1;

				tmp = arr[i];
				arr[i] = arr[i + 1];
				arr[i + 1] = tmp;

				i = -1;
			}
		}

		if (consider_line)
			sum += arr[arr_len / 2];
	}

	free(line);
	return sum;
}

int main(void)
{
	build_order();

	/* printf("%d\n", proccess_order(1)); */
	printf("%d\n", proccess_order(0));
}
