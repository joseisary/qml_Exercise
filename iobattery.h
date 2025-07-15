#ifndef IOBATTERY_H
#define IOBATTERY_H

#include <QObject>

class IOBattery : public QObject
{
    Q_OBJECT

public:
    explicit IOBattery(QObject *parent = nullptr);

    // Explicitly exposed methods
    Q_INVOKABLE int getPercentage();
    Q_INVOKABLE void setPercentage(int value);

signals:
    void percentageChanged();

private:
    int m_percentage;
};

#endif // IOBATTERY_H
