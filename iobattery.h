#ifndef IOBATTERY_H
#define IOBATTERY_H

#include <QObject>

class QString;
class QKeyEvent;

class IOBattery : public QObject {
    Q_OBJECT
public:
    Q_PROPERTY(int charge READ getCharge NOTIFY chargeChanged)
    Q_INVOKABLE void installOn(QObject *obj);

    explicit IOBattery(QObject *parent = nullptr);
signals:
    void chargeChanged();
    void keyPressed(int key, QString msg);

protected:
    bool eventFilter(QObject *obj, QEvent *event) override;
    void chargeByKeys(QKeyEvent *event);

private:
//----------------------------------------------//
// methods
//----------------------------------------------//
    int getCharge() const;
    void setCharge(int percentage);
    void setUptTimer();

//----------------------------------------------//
// data members
//----------------------------------------------//
int m_charge = 0;
};

#endif // IOBATTERY_H
