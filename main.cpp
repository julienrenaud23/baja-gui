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

    /*QTimer* timer = new QTimer();
    QTimer::connect(timer, &QTimer::timeout, [&]() {
        if (!engine.children().empty()) {
            QObject* clockLabel = engine.rootObjects().first()->findChild<QObject*>("clockLabel");
        }
    });

    timer->start(1000);
    */
    engine.loadFromModule("dashbee", "Main");
    return app.exec();
}
