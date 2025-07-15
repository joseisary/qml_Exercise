#include "iobattery.h"


IOBattery::IOBattery(QObject *parent)
    : QObject(parent), m_percentage(0) {}

int IOBattery::getPercentage()
{
    return m_percentage++;
}

void IOBattery::setPercentage(int value) {
    if (value != m_percentage) {
        m_percentage = value;
        emit percentageChanged();
    }
}
