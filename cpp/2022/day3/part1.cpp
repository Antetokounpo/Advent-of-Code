#include <algorithm>
#include <fstream>
#include<iostream>
#include <string>
#include <vector>

using namespace std;

int main(int argc, char** argv){
    int sum = 0;

    ifstream t(argv[1]);
    if(t.is_open()){
        string line;
        string sack_1, sack_2;
        while(getline(t, line)){
            sack_1 = line.substr(0, line.size()/2);
            sack_2 = line.substr(line.size()/2);

            sort(sack_1.begin(), sack_1.end());
            sort(sack_2.begin(), sack_2.end());

            int i = 0, j = 0;
            while(sack_1[i] != sack_2[j]){
                if(sack_1[i] > sack_2[j])
                    j++;
                else
                    i++;
            }

            auto item = sack_1[i];

            if(item < 97)
                sum += item - 38;
            else
                sum += item - 96;
        }
    }

    cout << sum << endl;

    return 0;
}
