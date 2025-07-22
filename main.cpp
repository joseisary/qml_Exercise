#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "iobattery.h"

static void registerTypes();
static void registerByContext(QQmlApplicationEngine &engine, IOBattery &battery);

int main(int argc, char *argv[]) {

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    registerTypes();

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("battery", "Main");

    return app.exec();
}

static void registerTypes() {
    qmlRegisterType<IOBattery>("capgemini.com", 1, 0, "IOBattery");
}

static void registerByContext(QQmlApplicationEngine &engine, IOBattery &battery) {
    engine.rootContext()->setContextProperty("ioBattery", &battery);
}
