set(qmlplugin_SRCS
    qmlplugin.cpp
    GlosbitConfig.cpp
)

add_library (glosbitqmlplugin SHARED ${qmlplugin_SRCS})


target_link_libraries (glosbitqmlplugin
    Qt5::Core
    Qt5::Qml
    Qt5::Quick
    KF5::ConfigCore
#    KF5::KIOCore
#    KF5::KIOWidgets
)

install (TARGETS glosbitqmlplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/glosbit)
install (FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/glosbit)
