#include <QtQuickTest>
#include <QQmlEngine>
#include <QQmlContext>

class Setup : public QObject
{
    Q_OBJECT

public:
    Setup() {}

public slots:
    void applicationAvailable()
    {
        // Called right after QApplication instantiation
        // Perform any app-level setup here
    }

    void qmlEngineAvailable(QQmlEngine *engine)
    {
        // Called when QML engine is available
        // Add any import paths or register types here
        // The qmlPrayerTimes module should be automatically available
        // if built and linked correctly

        // Add the module's build directory to import paths if needed
        // engine->addImportPath("qrc:/");
    }

    void cleanupTestCase()
    {
        // Called after test execution
        // Cleanup resources here
    }
};

QUICK_TEST_MAIN_WITH_SETUP(qmlPrayerTimes, Setup)

#include "tst_qmlPrayerTimes.moc"
