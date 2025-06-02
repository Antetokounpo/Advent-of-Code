#include <fstream>
#include<iostream>
#include <map>
#include <string>

using namespace std;

int mod(int a, int b)
{
    return ((a % b) + b) % b;
}

int main(int argc, char** argv){
    ifstream t(argv[1]);

    map<char, int> m = {
        {'A', 0},
        {'X', -1},
        {'B', 1},
        {'Y', 0},
        {'C', 2},
        {'Z', 1},
    };

    int score = 0;

    if(t.is_open()){
        string line;
        char p1, p2;
        while(getline(t, line)){
            p1 = m[line[0]];
            p2 = m[line[2]];

            if(p2 == 1)
            {
                score += 6;
            }else if(p2 == 0){
                score += 3;
            }

            score += mod((p1 + p2), 3) + 1;
        }
        t.close();
    }

    std::cout << score << std::endl;

    return 0;
}
