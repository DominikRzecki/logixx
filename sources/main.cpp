#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSGRendererInterface>
#include <QQuickWindow>

#include "headers/nodebackend.h"
#include "headers/slotbackend.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QQuickWindow::setSceneGraphBackend(QSGRendererInterface::OpenGLRhi);
    QGuiApplication app(argc, argv);

    /*qmlRegisterType<NodeType>("com.rzecki.logix", 1, 0, "NodeType");
    qmlRegisterType<NodeBackend>("com.rzecki.logix", 1, 0, "NodeBackend");
    qmlRegisterType<SlotBackend>("com.rzecki.logix", 1, 0, "SlotBackend");*/

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
        if (engine.rootObjects().isEmpty())
            return -1;

    return app.exec();
}
