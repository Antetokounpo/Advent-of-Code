#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>


int main(int argc, char** argv)
{
    std::ifstream t(argv[1]);

    int max_calories = 0;
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

            if(calories > max_calories)
                max_calories = calories;
        }
        t.close();
    } 

    std::cout << max_calories << std::endl;

    return 0;
}
