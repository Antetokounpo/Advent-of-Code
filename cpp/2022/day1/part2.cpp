#include <algorithm>
#include <functional>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <numeric>


int main(int argc, char** argv)
{
    std::ifstream t(argv[1]);

    std::vector<int> elf_calories = {};
    if(t.is_open())
    {
        while(!t.eof())
        {
            std::string line;
            int calories = 0;
            while(std::getline(t, line))
            {
                if(line == "")
                    break;
                calories += std::stoi(line);
            }
            elf_calories.push_back(calories);
        }
        t.close();
    } 

    std::sort(elf_calories.begin(), elf_calories.end(), std::greater<int>());

    std::cout << std::accumulate(elf_calories.begin(), elf_calories.begin()+3, 0) << std::endl;

    return 0;
}
