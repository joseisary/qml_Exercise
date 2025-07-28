#ifndef IOBATTERY_H
#define IOBATTERY_H

#include <QObject>

class QString;
class QKeyEvent;

class IOBattery : public QObject {
    Q_OBJECT
   public:
    Q_PROPERTY(int charge READ getCharge NOTIFY chargeChanged)
    Q_INVOKABLE void updateCharge(int charge);

    typedef enum {
        CHARGE_LEVEL_0_5,
        CHARGE_LEVEL_5_20,
        CHARGE_LEVEL_20_45,
        CHARGE_LEVEL_45_100,
    } CHARGE_LEVEL;
    Q_ENUM(CHARGE_LEVEL)

    explicit IOBattery(QObject *parent = nullptr);
   signals:
    void chargeChanged();
    void chargeLevelChanged(CHARGE_LEVEL level);
    void keyPressed(int key, QString msg);

   private:
    //----------------------------------------------//
    // methods
    //----------------------------------------------//
    int getCharge() const;
    void setCharge(int percentage);
    void setUptTimer();
    void calculateLevel(int charge);

    //----------------------------------------------//
    // data members
    //----------------------------------------------//
    int m_charge = 0;
};

#endif  // IOBATTERY_H
