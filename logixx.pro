QT += quick quickcontrols2 widgets
CONFIG += c++20 metatypes qmltypes
QML_IMPORT_NAME = com.rzecki.logix
QML_IMPORT_MAJOR_VERSION = 1

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS #\
	   #QT_DISABLE_DEPRECATED_BEFORE=0x050F00

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH +=	src/headers \
		src/headers/nodes \
		src/headers/nodes/input \
		src/headers/nodes/intermediary \
		src/headers/nodes/output \

RESOURCES += qml.qrc

TRANSLATIONS += \
    logixx_en_US.ts
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ANDROID_ABIS = armeabi-v7a arm64-v8a

HEADERS += \
	src/headers/containermodel.h \
	src/headers/iolist.h \
	src/headers/nodealgorithms.h \
	src/headers/nodebackend.h \
	src/headers/nodedroparea.h \
	src/headers/nodeprocessor.h \
	src/headers/nodes/intermediary/andbackend.h \
	src/headers/objectpointer.h \
	src/headers/slotbackend.h

SOURCES += \
	src/sources/containermodel.cpp \
	src/sources/iolist.cpp \
	src/sources/main.cpp \
	src/sources/nodealgorithms.cpp \
	src/sources/nodebackend.cpp \
	src/sources/nodedroparea.cpp \
	src/sources/nodeprocessor.cpp \
	src/sources/nodes/intermediary/andbackend.cpp \
	src/sources/objectpointer.cpp \
	src/sources/slotbackend.cpp
