#pragma once

#include <string>


typedef struct input_t {
    std::string input;
} input_t;

typedef struct output_t {
    std::string part1;
    std::string part2;
} output_t;

std::string read_input(int year, int day);

output_t day1(const std::string& input);
output_t day2(const std::string& input);
output_t day3(const std::string& input);
output_t day4(const std::string& input);
