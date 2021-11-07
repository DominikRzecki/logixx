TEMPLATE += app
QT += quick quickcontrols2 widgets svg
CONFIG += c++17 metatypes qmltypes qtquickcompiler
QML_IMPORT_NAME = com.rzecki.logix
QML_IMPORT_MAJOR_VERSION = 1

QMAKE_CXXFLAGS += -std=c++17

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

#ICON = logo.png
win32: RC_ICONS += logo.png
macx: ICON = logix.png

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

ANDROID_ABIS = armeabi-v7a

HEADERS += \
	src/headers/nodebackend.h \
	src/headers/nodes/intermediary/andbackend.h \
	src/headers/nodes/intermediary/nandbackend.h \
	src/headers/nodes/intermediary/norbackend.h \
	src/headers/nodes/intermediary/notbackend.h \
	src/headers/nodes/intermediary/orbackend.h \
	src/headers/slotbackend.h \
	src/headers/undobuffer.h \

SOURCES += \
	src/sources/main.cpp \
	src/sources/nodebackend.cpp \
	src/sources/nodes/intermediary/andbackend.cpp \
	src/sources/nodes/intermediary/nandbackend.cpp \
	src/sources/nodes/intermediary/norbackend.cpp \
	src/sources/nodes/intermediary/notbackend.cpp \
	src/sources/nodes/intermediary/orbackend.cpp \
	src/sources/slotbackend.cpp \
	src/sources/undobuffer.cpp \

DISTFILES += \
	android/AndroidManifest.xml \
	android/build.gradle \
	android/gradle.properties \
	android/gradle/wrapper/gradle-wrapper.jar \
	android/gradle/wrapper/gradle-wrapper.properties \
	android/gradlew \
	android/gradlew.bat \
	android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
