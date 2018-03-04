
if (NOT STATIC_LIBRARY)
    ecm_create_qm_loader(glosbit_QM_LOADER glosbit_qt)
endif()

set(glosbit_SRCS
    main.cpp
    )

qt5_add_resources(RESOURCES resources.qrc)

add_executable(glosbit ${glosbit_SRCS} ${RESOURCES})
target_link_libraries(glosbit Qt5::Core  Qt5::Qml Qt5::Quick Qt5::Svg KF5::ConfigCore)

install(TARGETS glosbit ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})

if (ANDROID)
    install(FILES contents/ui/glosbit.svg DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/kirigami.2/icons)
else()
    install(FILES contents/ui/glosbit.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps)
endif()

#include(KF5KirigamiMacros.cmake)
#kirigami_package_breeze_icons(ICONS system-search)
