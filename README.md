# glosbit

Glosbit is a translation tool powered by https://glosbe.com/. You may translate a single word or a phrase using the top glosbe.com dictionaries. Moreover, a set of examples of usage of the word or phrase are presented.

Glosbit is a touch friendly and has been created for plasma mobile. Nevertheless, it may run as a desktop application as well.   

It can also be compiled for Android alongside with Kirigami2 and Qt for Android with OpenSSL.

# Compile Dependencies (kde-neon)

qtquickcontrols2-5-dev  
kirigami2-dev  


# Installation

mkdir build  
cd build  
cmake -DKDE_INSTALL_USE_QT_SYS_PATHS=ON  ..  
make  
(sudo) make install  

This will install Glosbit to /usr/local since CMAKE_INSTALL_PREFIX variable normally defaults to /usr/local. If you want to change installation directory (e.g. to /usr) change cmake line to:  
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_PREFIX_PATH=/usr -DKDE_INSTALL_USE_QT_SYS_PATHS=ON  ..  
