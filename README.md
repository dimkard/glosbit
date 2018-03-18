# glosbit

Glosbit is a translation tool powered by https://glosbe.com/. You may translate a single word or a phrase using the top glosbe.com dictionaries. Moreover, a set of uses of the word/phrase are presented.

Glosbit is a touch friendly plasma mobile application. Nevertheless, it may run as a desktop application as well.  

# Compile Dependencies (kde-neon)

qtquickcontrols2-5-dev  
kirigami2-dev  


# Installation

mkdir build  
cd build  
cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. (or any other location you may prefer)  
make  
(sudo) make install  

