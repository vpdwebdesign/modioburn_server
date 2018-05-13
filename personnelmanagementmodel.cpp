#include "personnelmanagementmodel.h"
#include <QSqlQuery>
#include <QSqlRecord>

PersonnelManagementModel::PersonnelManagementModel(QObject *parent)
    : QSqlQueryModel(parent)
{
}

QVariant PersonnelManagementModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.isValid())
    {
        QVariant value;
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }

        return value;
    }

    return QVariant();
}

QHash<int, QByteArray> PersonnelManagementModel::roleNames() const
{
    return m_rNames;
}

void PersonnelManagementModel::generateRoleNames()
{
    m_rNames.clear();
    for (int i = 0; i < this->record().count(); ++i)
    {
        m_rNames.insert(Qt::UserRole + i, this->record().fieldName(i).toUtf8());
    }
}
