#include "iobattery.h"
#include <QDebug>
#include <QString>
#include <QTimer>

#define CHARGE_RATIO 1
#define CHARGE_UP 100
#define CHARGE_BOTTOM 0

#define CHARGE_RATIO  1
#define CHARGE_UP     100
#define CHARGE_BOTTOM 0

IOBattery::IOBattery(QObject *parent)
    : QObject(parent), m_charge(0) {
    setUptTimer();
}

void IOBattery::setUptTimer() {
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, [this]() {
        int newCharge = m_charge + CHARGE_RATIO;
        setCharge(newCharge);
    });
    timer->start(1000);  // Every second
}

int IOBattery::getCharge() const { return m_charge; }

void IOBattery::updateCharge(int charge){
    setCharge(charge);
}

void IOBattery::setCharge(int chrg) {
    if (m_charge == chrg)
        return;
    chrg = chrg < CHARGE_BOTTOM ? CHARGE_BOTTOM : chrg;
    chrg = chrg > CHARGE_UP ? CHARGE_UP : chrg;
    calculateLevel(chrg);

    m_charge = chrg;
    emit chargeChanged();
}

void IOBattery::calculateLevel(int charge) {
    auto getLevel = [](int chrg) {
        if (chrg < 5)  return CHARGE_LEVEL_0_5;
        if (chrg < 20) return CHARGE_LEVEL_5_20;
        if (chrg < 45) return CHARGE_LEVEL_20_45;
        return CHARGE_LEVEL_45_100;
    };
    CHARGE_LEVEL currLevel = getLevel(m_charge);
    CHARGE_LEVEL newLevel = getLevel(charge);
    if (currLevel != newLevel){
        emit chargeLevelChanged(newLevel);
    }
}
