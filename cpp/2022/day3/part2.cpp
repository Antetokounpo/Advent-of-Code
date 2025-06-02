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
        string sack_1, sack_2, sack_3;
        while(getline(t, sack_1) && getline(t, sack_2) && getline(t, sack_3)){
            sort(sack_1.begin(), sack_1.end());
            sort(sack_2.begin(), sack_2.end());
            sort(sack_3.begin(), sack_3.end());

            int i = 0, j = 0, k = 0;
            while(!(sack_1[i] == sack_2[j] && sack_2[j] == sack_3[k])){
                if(sack_1[i] > sack_2[j])
                    j++;
                else if(sack_2[j] > sack_3[k])
                    k++;
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
