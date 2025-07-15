#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "iobattery.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    IOBattery battery;
    engine.rootContext()->setContextProperty("ioBattery", &battery);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("battery", "Main");

    return app.exec();
}
