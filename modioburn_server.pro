QT += av svg qml quick sql

CONFIG += c++11

HEADERS += \
    mbtimer.h \
    mbquerymodel.h \
    dbfuncs.h \
    phonecodeverifier.h \
    user.h \
    role.h \
    session.h \
    rbacusermanager.h \
    mbproxyquerymodel.h \
    transactionitem.h \
    shoppingcart.h \
    transactionsmodel.h \
    itempricemanager.h \
    mbfilemanager.h \
    transactionsquerymodel.h \
    stockitemsmodel.h \
    stockitem.h \
    stockitemspurchaseslist.h \
    stockitemspurchasesmodel.h \
    personnelmanagementmodel.h

SOURCES += \
    main.cpp \
    dbfuncs.cpp \
    mbquerymodel.cpp \
    phonecodeverifier.cpp \
    mbtimer.cpp \
    user.cpp \
    role.cpp \
    session.cpp \
    rbacusermanager.cpp \
    mbproxyquerymodel.cpp \
    shoppingcart.cpp \
    transactionsmodel.cpp \
    itempricemanager.cpp \
    mbfilemanager.cpp \
    transactionsquerymodel.cpp \
    stockitemsmodel.cpp \
    stockitemspurchaseslist.cpp \
    stockitemspurchasesmodel.cpp \
    personnelmanagementmodel.cpp

RESOURCES += \
    qml.qrc \
    audioplayer/icons.qrc \
    audioplayer/audioplayer.qrc \
    videoplayer/videoplayer.qrc

COMMON = $$PWD/videoplayer/common
INCLUDEPATH *= $$COMMON $$COMMON/..
RESOURCES += $$COMMON/icons/theme.qrc
isEmpty(PROJECTROOT): PROJECTROOT = $$PWD/../..

DEFINES += BUILD_QOPT_LIB
HEADERS *= \
    $$COMMON/common.h \
    $$COMMON/config.h \
    $$COMMON/qoptions.h \
    $$COMMON/screensaver.h \
    $$COMMON/common_export.h

SOURCES *= \
    $$COMMON/common.cpp \
    $$COMMON/config.cpp \
    $$COMMON/qoptions.cpp \
    $$COMMON/screensaver.cpp

INCLUDEPATH += /usr/local/include
LIBS += -L/usr/local/lib -lsodium

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
