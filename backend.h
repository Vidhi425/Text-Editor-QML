#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QTextStream>

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged FINAL)
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged FINAL)
public:
    explicit Backend(QObject *parent = nullptr);

    QString path() const;
    void setPath(const QString &newPath);

    QString data() const;
    void setData(const QString &newData);

signals:
    void pathChanged();
    void dataChanged();

private:
    QString m_path;
    QString m_data;
};

#endif // BACKEND_H
