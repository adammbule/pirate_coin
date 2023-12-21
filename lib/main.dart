import 'package:flutter/material.dart';
void main(){//defining the function parameters when defining a function
runApp(MaterialApp(home: Text() )//class
);//calling the function arguments when calling a function
}


//position argument
void main(){
    int multi(a, b){
    return a * b;
}
int result = multi(5, 7);
print (result);
}

multi(5, 7);

//named argument

void multi2({a, b}){
    print(a * b);
}

multi2(5,7);