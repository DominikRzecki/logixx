#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSGRendererInterface>
#include <QQuickWindow>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QQuickWindow::setSceneGraphBackend(QSGRendererInterface::OpenGLRhi);
    QGuiApplication app(argc, argv);

    /*qmlRegisterType<NodeType>("com.rzecki.logix", 1, 0, "NodeType");
    qmlRegisterType<NodeBackend>("com.rzecki.logix", 1, 0, "NodeBackend");
    qmlRegisterType<SlotBackend>("com.rzecki.logix", 1, 0, "SlotBackend");*/

    //Setting material Theme
    QQuickStyle::setStyle("Material");
    QQuickStyle::setFallbackStyle("Universal");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));
        if (engine.rootObjects().isEmpty())
            return -1;


    return app.exec();
}
