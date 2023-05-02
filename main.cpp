#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QObject>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQuickWindow>
#include <QSurfaceFormat>
#include "keygenerator.h"

// Main wrapper program.
// Special handling is needed when using Qt Quick Controls for the top window.
// The code here is based on what qmlscene does.

int main(int argc, char ** argv)
{
    QGuiApplication app(argc, argv);

    // Register our component type with QML.
    qmlRegisterType<KeyGenerator>("com.ics.demo", 1, 0, "KeyGenerator");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ics_keygen", "Main");

    return app.exec();
}
