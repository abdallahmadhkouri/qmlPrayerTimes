#include "prayertimeswrapper.h"

PrayerTimesWrapper::PrayerTimesWrapper(QObject *parent)
    : QObject(parent)
{
}

QStringList PrayerTimesWrapper::calculatePrayerTimes(double latitude, double longitude, 
                                                    double timezone, int year, int month, int day)
{
    double times[PrayerTimes::TimesCount];
    m_prayerTimes.get_prayer_times(year, month, day, latitude, longitude, timezone, times);
    
    QStringList prayerTimes;
    for (int i = 0; i < PrayerTimes::TimesCount; ++i) {
        prayerTimes.append(QString::fromStdString(PrayerTimes::float_time_to_time24(times[i])));
    }
    
    return prayerTimes;
}

void PrayerTimesWrapper::setCalculationMethod(int method)
{
    m_prayerTimes.set_calc_method(static_cast<PrayerTimes::CalculationMethod>(method));
}

void PrayerTimesWrapper::setAsrMethod(int method)
{
    m_prayerTimes.set_asr_method(static_cast<PrayerTimes::JuristicMethod>(method));
}

void PrayerTimesWrapper::setHighLatitudesMethod(int method)
{
    m_prayerTimes.set_high_lats_adjust_method(static_cast<PrayerTimes::AdjustingMethod>(method));
}