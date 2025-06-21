#include "backend.h"

Backend::Backend(QObject *parent)
    : QObject{parent}
{
    m_path = QCoreApplication::applicationDirPath();
    m_path.append("/file.txt");
}

QString Backend::path() const
{
    return m_path;
}

void Backend::setPath(const QString &newPath)
{
    if (m_path == newPath)
        return;
    m_path = newPath;
    m_path.remove("file://");
    emit pathChanged();
}

QString Backend::data() const
{
    QFile file(m_path);
    if(!file.open(QIODevice::ReadOnly)){
        qWarning() << "could not read file";
        return "";
    }
    QTextStream stream(&file);
    QString value = stream.readAll();
    file.close();
    return value;
    // return m_data;
}

void Backend::setData(const QString &newData)
{
    QFile file(m_path);
    if(!file.open(QIODevice::WriteOnly)){
        qWarning() << "could not write file";

    }
    QTextStream stream(&file);
    stream << newData;
    stream.flush();
    file.close();
    emit dataChanged();
}
