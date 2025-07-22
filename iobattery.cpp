#include "iobattery.h"
#include <QTimer>
#include <QDebug>
#include <QKeyEvent>
#include <QString>


#define CHARGE_RATIO  1
#define CHARGE_UP     100
#define CHARGE_BOTTOM 0

IOBattery::IOBattery(QObject *parent)
    : QObject(parent), m_charge(0)
{
    setUptTimer();
}

void IOBattery::setUptTimer() {
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, [this]() {
        int newCharge = m_charge + CHARGE_RATIO;     
        setCharge(newCharge);
    });
    timer->start(1000);  //Every second
}

void IOBattery::installOn(QObject *obj) {
    if (obj) obj->installEventFilter(this);
}

int IOBattery::getCharge() const { return m_charge; }

void IOBattery::setCharge(int chrg) {
    if (m_charge != chrg) {
        chrg = chrg < CHARGE_BOTTOM ? CHARGE_BOTTOM : chrg;
        chrg = chrg > CHARGE_UP ? CHARGE_UP : chrg; 
        m_charge = chrg;
        emit chargeChanged();
    }
}

bool IOBattery::eventFilter(QObject *obj, QEvent *event) {
    if (
        event->type() == QEvent::KeyPress ||
        event->type() == QEvent::KeyRelease
    ) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        chargeByKeys(keyEvent);
        emit keyPressed(keyEvent->key(), keyEvent->text());
    }
    return QObject::eventFilter(obj, event);
}

void IOBattery::chargeByKeys(QKeyEvent* event) {
    if (event->type() == QEvent::KeyPress) {
        if (event->key() == Qt::Key_Up || event->key() == Qt::Key_Plus) {
            setCharge(m_charge + CHARGE_RATIO );
        } else if (event->key() == Qt::Key_Down || event->key() == Qt::Key_Minus) {
            setCharge(m_charge - CHARGE_RATIO);
        }
    }
}
