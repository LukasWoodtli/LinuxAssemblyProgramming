/* using standard libray would require
   a more complex makefile for finding 
   the directory of the stdlib to link
   against it. */

//#include <iostream>

extern "C" void stats(int[], int, int*, int*);

int main() {
    int lst[] = {1, -2, 3, -4, 5, 7, 9, 11};
    int len = 8;
    int sum, ave;
    
    stats(lst, len, &sum, &ave);
    
//    std::cout << "Stats:\n";
//    std::cout << "Sum = " << sum << "\n";
//    std::cout << "Ave = " << ave << "\n";

    return 0;
}
