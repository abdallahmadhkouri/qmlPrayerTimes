 #ifndef PRAYERTIMESWRAPPER_H
#define PRAYERTIMESWRAPPER_H

#include <QObject>
#include <QString>
#include "prayertimes.hpp"

class PrayerTimesWrapper : public QObject
{
    Q_OBJECT

public:
    explicit PrayerTimesWrapper(QObject *parent = nullptr);

    Q_INVOKABLE QStringList calculatePrayerTimes(double latitude, double longitude, 
                                                double timezone, int year, int month, int day);
    
    Q_INVOKABLE void setCalculationMethod(int method);
    Q_INVOKABLE void setAsrMethod(int method);
    Q_INVOKABLE void setHighLatitudesMethod(int method);

private:
    PrayerTimes m_prayerTimes;
};

#endif // PRAYERTIMESWRAPPER_H