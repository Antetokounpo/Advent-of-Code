#include <fstream>
#include<iostream>
#include <map>
#include <string>

using namespace std;

int main(int argc, char** argv){
    ifstream t(argv[1]);

    map<char, int> m = {
        {'A', 0},
        {'x', 0},
        {'B', 1},
        {'Y', 1},
        {'C', 2},
        {'Z', 2},
    };

    int score = 0;

    if(t.is_open()){
        string line;
        int p1, p2;
        while(getline(t, line)){
            p1 = m[line[0]];
            p2 = m[line[2]];

            if(p2 == ((p1+1) % 3))
            {
                score += 6;
            }else if(p2 == p1){
                score += 3;
            }

            score += p2 + 1;
        }
        t.close();
    }

    std::cout << score << std::endl;

    return 0;
}
