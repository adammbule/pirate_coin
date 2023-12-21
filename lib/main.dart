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



//named argument

void main(){
    int multi2({a, b}){
        return a * b;
    }
  int result = multi2(a:5, b:5);
    print (result);
}

