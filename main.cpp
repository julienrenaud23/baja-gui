#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QEventLoop>
#include <QTimer>
#include <chrono>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    auto now = std::chrono::system_clock::now();

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app, []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    engine.loadFromModule("dashbee", "Main");

    return app.exec();
}
