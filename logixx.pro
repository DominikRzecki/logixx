QT += quick quickcontrols2 widgets
CONFIG += c++17 metatypes qmltypes
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
		src/submodules/QOlm/include \
		src/submodules/eventpp/include

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
	#src/headers/iolist.h \
	src/headers/nodebackend.h \
	src/headers/nodes/intermediary/andbackend.h \
	src/headers/slotbackend.h \
	src/headers/undobuffer.h \
	src/submodules/QOlm/include/QOlm/Export.hpp \
	src/submodules/QOlm/include/QOlm/QOlm.hpp \
	src/submodules/QOlm/include/QOlm/QOlmBase.hpp \
	src/submodules/eventpp/include/eventpp/callbacklist.h \
	src/submodules/eventpp/include/eventpp/eventdispatcher.h \
	src/submodules/eventpp/include/eventpp/eventpolicies.h \
	src/submodules/eventpp/include/eventpp/eventqueue.h \
	src/submodules/eventpp/include/eventpp/hetercallbacklist.h \
	src/submodules/eventpp/include/eventpp/hetereventdispatcher.h \
	src/submodules/eventpp/include/eventpp/hetereventqueue.h \
	src/submodules/eventpp/include/eventpp/internal/eventpolicies_i.h \
	src/submodules/eventpp/include/eventpp/internal/eventqueue_i.h \
	src/submodules/eventpp/include/eventpp/internal/hetercallbacklist_i.h \
	src/submodules/eventpp/include/eventpp/internal/typeutil_i.h \
	src/submodules/eventpp/include/eventpp/mixins/mixinfilter.h \
	src/submodules/eventpp/include/eventpp/mixins/mixinheterfilter.h \
	src/submodules/eventpp/include/eventpp/utilities/anyid.h \
	src/submodules/eventpp/include/eventpp/utilities/argumentadapter.h \
	src/submodules/eventpp/include/eventpp/utilities/conditionalfunctor.h \
	src/submodules/eventpp/include/eventpp/utilities/conditionalremover.h \
	src/submodules/eventpp/include/eventpp/utilities/counterremover.h \
	src/submodules/eventpp/include/eventpp/utilities/eventmaker.h \
	src/submodules/eventpp/include/eventpp/utilities/eventutil.h \
	src/submodules/eventpp/include/eventpp/utilities/orderedqueuelist.h \
	src/submodules/eventpp/include/eventpp/utilities/scopedremover.h

SOURCES += \
	#src/sources/iolist.cpp \
	src/sources/main.cpp \
	src/sources/nodebackend.cpp \
	src/sources/nodes/intermediary/andbackend.cpp \
	src/sources/slotbackend.cpp \
	src/sources/undobuffer.cpp \
	src/submodules/QOlm/src/QOlmBase.cpp
