#pragma once

#include <qobject.h>
#include <qqmlintegration.h>

class Search : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QObjectList entries WRITE setEntries NOTIFY entriesChanged)

  public:
    Q_INVOKABLE QObjectList search_entries(QString query);
    void setEntries(QObjectList& entries);

  signals:
    void entriesChanged();

  private:
    QObjectList m_entries;
};
