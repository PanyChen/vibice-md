#include <fstream>
#include <string>
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

int main() {
    ifstream File("meas_final.txt");
    string line, last_line;

    // Read through the file to get the last line
    while (getline(File, line)) {
        last_line = line;
    }

    // Use istringstream to split the last line into values
    istringstream data(last_line);
    vector<string> values;
    string value;
    while (data >> value) {
        values.push_back(value);
    }

    // Assuming the file format is consistent and there are enough columns,
    // the 3rd column is at index 2 (since indexing starts at 0)
    if (values.size() > 2) { // Check if there are at least three columns
        string thirdColumnValue = values[2];
        int PE = stod(thirdColumnValue); // Convert the 3rd column value to int
        cout << PE << endl; // Print it to the console

        // Write the extracted value to a file named pe.txt
        ofstream File2("pe.txt");
        if (File2.is_open()) { // Check if the file is successfully opened
            File2 << PE; // Write the PE value to the file
            File2.close(); // Close the file after writing
        } else {
            cout << "Unable to open file for writing." << endl;
        }
    } else {
        cout << "The last line does not contain enough columns." << endl;
    }

    File.close(); // Close the input file
    return 0;
}
